import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../db/providers.dart';
import '../db/settings_dao.dart';
import 'apk_installer.dart';
import 'app_update_service.dart';

final appUpdateServiceProvider = Provider<AppUpdateService>(
  (ref) => defaultTargetPlatform == TargetPlatform.iOS
      ? const AppStoreUpdateService(bundleId: 'com.verybeauty.veryBeauty')
      : const GitHubReleasesUpdateService(),
);

/// The installed version, or null where it can't be read (tests).
final currentVersionProvider = FutureProvider<AppVersionInfo?>((ref) async {
  try {
    final info = await PackageInfo.fromPlatform();
    return AppVersionInfo(
      version: info.version,
      build: int.tryParse(info.buildNumber) ?? 0,
    );
  } catch (_) {
    return null;
  }
});

/// Automatic check at launch: at most once a day, never blocks the app,
/// silent when offline (docs/SPEC.md §8).
Future<void> autoCheckForUpdate(BuildContext context, WidgetRef ref) async {
  final dao = ref.read(settingsDaoProvider);
  final settings = await dao.loadAll();
  if (settings[SettingKeys.updateAutoCheck] == '0') return;
  final last = int.tryParse(settings[SettingKeys.lastUpdateCheck] ?? '') ?? 0;
  final now = DateTime.now().millisecondsSinceEpoch;
  if (now - last < const Duration(hours: 24).inMilliseconds) return;

  final current = await ref.read(currentVersionProvider.future);
  if (current == null) return;
  final info = await ref.read(appUpdateServiceProvider).check(current);
  await dao.setValue(SettingKeys.lastUpdateCheck, '$now');
  if (info == null || !context.mounted) return;
  if (!info.mandatory &&
      settings[SettingKeys.updateDismissed] == info.versionLabel) {
    return;
  }
  await showUpdateDialog(context, ref, info);
}

/// "Check for updates" in Settings; always reports the outcome.
Future<void> manualCheckForUpdate(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final current = await ref.read(currentVersionProvider.future);
  if (current == null) return;
  messenger.showSnackBar(SnackBar(content: Text(l10n.updateChecking)));
  final info = await ref.read(appUpdateServiceProvider).check(current);
  messenger.hideCurrentSnackBar();
  if (!context.mounted) return;
  if (info == null) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.updateNone)));
  } else {
    await showUpdateDialog(context, ref, info);
  }
}

Future<void> showUpdateDialog(
  BuildContext context,
  WidgetRef ref,
  UpdateInfo info,
) async {
  final l10n = AppLocalizations.of(context);
  final inApp =
      info.apkUrl != null && defaultTargetPlatform == TargetPlatform.android;
  final accepted = await showDialog<bool>(
    context: context,
    barrierDismissible: !info.mandatory,
    builder: (context) => PopScope(
      canPop: !info.mandatory,
      child: AlertDialog(
        icon: const Icon(Icons.system_update_rounded),
        title: Text(
          info.mandatory ? l10n.updateRequiredTitle : l10n.updateAvailableTitle,
        ),
        content: SingleChildScrollView(
          child: Text(
            [
              info.versionLabel,
              if (info.mandatory) l10n.updateRequiredBody,
              inApp ? l10n.updateInAppBody : l10n.updateKeepsData,
            ].join('\n\n'),
          ),
        ),
        actions: [
          if (!info.mandatory)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.updateLater),
            ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(inApp ? l10n.updateNow : l10n.updateDownload),
          ),
        ],
      ),
    ),
  );
  if (accepted == true) {
    if (inApp && context.mounted) {
      await installUpdate(context, ref, info);
    } else {
      await launchUrl(info.url, mode: LaunchMode.externalApplication);
    }
  } else {
    await ref
        .read(settingsDaoProvider)
        .setValue(SettingKeys.updateDismissed, info.versionLabel);
  }
}

/// Downloads the APK with a progress dialog, makes sure the app may install
/// packages (asked once), then hands it to Android. With the permanent
/// signing key the new version replaces the app and keeps all data.
Future<void> installUpdate(
  BuildContext context,
  WidgetRef ref,
  UpdateInfo info,
) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);
  final installer = ref.read(apkInstallerProvider);
  final progress = ValueNotifier<double?>(null);

  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(l10n.updateDownloading),
          content: ValueListenableBuilder<double?>(
            valueListenable: progress,
            builder: (context, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: value),
                const SizedBox(height: 12),
                Text(value == null ? '' : '${(value * 100).round()}%'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  File apk;
  try {
    final url = info.apkUrlFor(await installer.supportedAbis())!;
    apk = await installer.download(url, onProgress: (p) => progress.value = p);
  } catch (e) {
    debugPrint('Update download failed: $e');
    navigator.pop();
    messenger.showSnackBar(SnackBar(content: Text(l10n.updateDownloadFailed)));
    return;
  } finally {
    progress.dispose();
  }
  navigator.pop();

  if (!await installer.canInstall()) {
    if (!context.mounted) return;
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.verified_user_outlined),
        title: Text(l10n.updatePermissionTitle),
        content: Text(l10n.updatePermissionBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.updateLater),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.updatePermissionOpen),
          ),
        ],
      ),
    );
    if (open != true) return;
    final resumed = Completer<void>();
    final listener = AppLifecycleListener(
      onResume: () => resumed.isCompleted ? null : resumed.complete(),
    );
    await installer.openInstallSettings();
    await resumed.future;
    listener.dispose();
    if (!await installer.canInstall()) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.updatePermissionMissing)),
      );
      return;
    }
  }

  late final StreamSubscription<InstallStatus> subscription;
  subscription = installer.statuses.listen((status) async {
    if (status == InstallStatus.pendingUserAction) return;
    unawaited(subscription.cancel());
    if (status == InstallStatus.success) return; // The app is replaced.
    if (status == InstallStatus.aborted) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.updateCancelled)));
    } else if (status.isSignatureMismatch && context.mounted) {
      final download = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.key_rounded),
          title: Text(l10n.updateSignatureTitle),
          content: Text(l10n.updateSignatureBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.updateLater),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.updateDownload),
            ),
          ],
        ),
      );
      if (download == true) {
        await launchUrl(info.url, mode: LaunchMode.externalApplication);
      }
    } else {
      messenger.showSnackBar(SnackBar(content: Text(l10n.updateInstallFailed)));
    }
  });
  messenger.showSnackBar(
    SnackBar(
      content: Text(l10n.updateInstalling),
      duration: const Duration(seconds: 8),
    ),
  );
  try {
    await installer.install(apk);
  } catch (e) {
    debugPrint('Update install failed: $e');
    await subscription.cancel();
    messenger.showSnackBar(SnackBar(content: Text(l10n.updateInstallFailed)));
  }
}

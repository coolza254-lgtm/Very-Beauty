import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../db/providers.dart';
import '../db/settings_dao.dart';
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
  final download = await showDialog<bool>(
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
              l10n.updateKeepsData,
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
            child: Text(l10n.updateDownload),
          ),
        ],
      ),
    ),
  );
  if (download == true) {
    await launchUrl(info.url, mode: LaunchMode.externalApplication);
  } else {
    await ref
        .read(settingsDaoProvider)
        .setValue(SettingKeys.updateDismissed, info.versionLabel);
  }
}

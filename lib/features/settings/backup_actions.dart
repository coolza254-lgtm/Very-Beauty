import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/backup/backup_service.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/db/settings_dao.dart';
import '../../core/storage/app_paths.dart';
import '../../core/utils/formatters.dart';

Future<BackupService> _service(WidgetRef ref) async => BackupService(
  paths: await ref.read(appPathsProvider.future),
  tempDir: await getTemporaryDirectory(),
);

Future<T> _withProgress<T>(
  BuildContext context,
  String message,
  Future<T> Function() task,
) async {
  final navigator = Navigator.of(context, rootNavigator: true);
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    ),
  );
  try {
    return await task();
  } finally {
    navigator.pop();
  }
}

/// Builds the backup zip and opens the system share sheet so the user can
/// save it to Files/Drive/AirDrop (docs/SPEC.md §9).
Future<void> exportBackup(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  try {
    final info = await PackageInfo.fromPlatform();
    final service = await _service(ref);
    if (!context.mounted) return;
    final zip = await _withProgress(
      context,
      l10n.backupWorking,
      () => service.export(
        ref.read(databaseProvider),
        appVersion: '${info.version}+${info.buildNumber}',
      ),
    );
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(zip.path, mimeType: 'application/zip')],
        subject: l10n.backupShareSubject,
        fileNameOverrides: [p.basename(zip.path)],
      ),
    );
    if (result.status != ShareResultStatus.dismissed) {
      await ref
          .read(settingsDaoProvider)
          .setValue(
            SettingKeys.lastBackupAt,
            '${DateTime.now().millisecondsSinceEpoch}',
          );
      messenger.showSnackBar(SnackBar(content: Text(l10n.backupDone)));
    }
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.backupFailed('$e'))));
  }
}

/// Lets the user pick a backup zip, shows what it contains, and replaces
/// all current data after confirmation.
Future<void> importBackup(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final locale = Localizations.localeOf(context).toLanguageTag();
  final picked = await FilePicker.pickFile();
  if (picked == null || !context.mounted) return;

  File? copy;
  try {
    // The picker may hand back a content:// URI; work on a local copy.
    final service = await _service(ref);
    copy = File(
      p.join(
        service.tempDir.path,
        'import_${DateTime.now().millisecondsSinceEpoch}.zip',
      ),
    );
    final sink = copy.openWrite();
    await sink.addStream(picked.readAsByteStream());
    await sink.close();

    final manifest = await service.inspect(copy);
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.restore_rounded),
        title: Text(l10n.restoreConfirmTitle),
        content: Text(
          l10n.restoreConfirmBody(
            formatShortDate(manifest.createdAt, locale),
            manifest.photoCount,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.restoreAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final db = ref.read(databaseProvider);
    final zip = copy;
    await _withProgress(
      context,
      l10n.backupRestoring,
      () async => service.restore(
        zip,
        databaseFile: await AppDatabase.defaultFile(),
        currentSchemaVersion: db.schemaVersion,
        closeDatabase: db.close,
      ),
    );
    // Reopen the restored database; every screen reloads from it.
    ref.invalidate(databaseProvider);
    messenger.showSnackBar(SnackBar(content: Text(l10n.restoreDone)));
  } on BackupException catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (e.error) {
          BackupError.notABackup => l10n.restoreNotBackup,
          BackupError.newerVersion => l10n.restoreNewer('${e.detail}'),
          BackupError.corrupt => l10n.restoreCorrupt,
        }),
      ),
    );
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.restoreCorrupt)));
  } finally {
    if (copy != null && await copy.exists()) await copy.delete();
  }
}

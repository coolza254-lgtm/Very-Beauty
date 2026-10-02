import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../db/providers.dart';
import '../db/settings_dao.dart';
import '../utils/date_utils.dart';
import 'notification_service.dart';
import 'reminder_planner.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => LocalNotificationService(),
);

ReminderTexts reminderTextsFor(AppLocalizations l10n) => ReminderTexts(
  routineTitle: l10n.reminderRoutineTitle,
  routineBody: l10n.reminderRoutineBody,
  weighTitle: l10n.reminderWeighTitle,
  weighBody: l10n.reminderWeighBody,
  expiryTitle: l10n.reminderExpiryTitle,
  expiryBody: l10n.reminderExpiryBody,
  backupTitle: l10n.reminderBackupTitle,
  backupBody: l10n.reminderBackupBody,
);

/// Keeps scheduled notifications in step with routines, products and
/// settings. Watched once by the app root.
final reminderSyncProvider = Provider<void>((ref) {
  final db = ref.watch(databaseProvider);
  final settingsDao = ref.watch(settingsDaoProvider);
  final service = ref.watch(notificationServiceProvider);

  // Anchor for the first backup reminder.
  unawaited(
    settingsDao.getValue(SettingKeys.firstRunAt).then((v) async {
      if (v == null) {
        await settingsDao.setValue(
          SettingKeys.firstRunAt,
          '${DateTime.now().millisecondsSinceEpoch}',
        );
      }
    }),
  );

  var queue = Future<void>.value();
  String? lastSignature;

  final sub = db
      .watchTables([db.routines, db.products, db.appSettings], () async {
        final settings = await settingsDao.loadAll();
        final locale = settings[SettingKeys.locale] ?? 'th';
        final l10n = lookupAppLocalizations(Locale(locale));
        final backupOn = settings[SettingKeys.backupReminders] != '0';
        final lastBackupMs = int.tryParse(
          settings[SettingKeys.lastBackupAt] ??
              settings[SettingKeys.firstRunAt] ??
              '',
        );
        return planReminders(
          now: DateTime.now(),
          routines: await db.select(db.routines).get(),
          products: await db.select(db.products).get(),
          settings: settings,
          texts: reminderTextsFor(l10n),
          lastBackupAt: backupOn && lastBackupMs != null
              ? fromEpochMs(lastBackupMs)
              : null,
        );
      })
      .listen((plan) {
        final signature = plan.join('|');
        if (signature == lastSignature) return;
        lastSignature = signature;
        // Run syncs one after another; a failure must never break the app.
        queue = queue.then((_) => service.sync(plan)).catchError((Object e) {
          debugPrint('Reminder sync failed: $e');
        });
      });
  ref.onDispose(sub.cancel);
});

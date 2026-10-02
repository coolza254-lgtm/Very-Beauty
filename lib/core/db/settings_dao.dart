import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'settings_dao.g.dart';

/// Keys used in the `app_settings` key-value table.
abstract final class SettingKeys {
  static const themeMode = 'theme_mode';
  static const locale = 'locale';

  /// Weighing reminder interval in days: '0' (off), '7' or '14'.
  static const weighReminderDays = 'weigh_reminder_days';

  /// Epoch ms the weighing reminder schedule is anchored to.
  static const weighReminderAnchor = 'weigh_reminder_anchor';

  /// '1' to remind 7 days before a product expires (label date or PAO).
  static const expiryReminders = 'expiry_reminders';

  /// Weighing is "due" on Today after this many days ('14' by default).
  static const weighDueDays = 'weigh_due_days';

  /// '0' turns off the monthly backup reminder (on by default).
  static const backupReminders = 'backup_reminders';

  /// Epoch ms of the last successful backup export.
  static const lastBackupAt = 'last_backup_at';

  /// Epoch ms of the first launch; anchors the first backup reminder.
  static const firstRunAt = 'first_run_at';

  /// '1' when the app asks for biometrics/PIN on open.
  static const appLock = 'app_lock';

  /// '1' to block screenshots (Android FLAG_SECURE).
  static const secureScreen = 'secure_screen';

  /// '0' turns off the daily automatic update check (on by default).
  static const updateAutoCheck = 'update_auto_check';

  /// Epoch ms of the last automatic update check.
  static const lastUpdateCheck = 'last_update_check';

  /// Version label the user chose "later" for; not offered again
  /// automatically.
  static const updateDismissed = 'update_dismissed';
}

@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.attachedDatabase);

  Stream<String?> watchValue(String key) => (select(
    appSettings,
  )..where((s) => s.key.equals(key))).map((s) => s.value).watchSingleOrNull();

  Future<String?> getValue(String key) => (select(
    appSettings,
  )..where((s) => s.key.equals(key))).map((s) => s.value).getSingleOrNull();

  Stream<Map<String, String>> watchAll() =>
      select(appSettings)
          .watch()
          .map((rows) => {for (final r in rows) r.key: r.value});

  Future<Map<String, String>> loadAll() =>
      select(appSettings)
          .get()
          .then((rows) => {for (final r in rows) r.key: r.value});

  Future<void> setValue(String key, String value) => into(appSettings).insert(
    AppSettingsCompanion.insert(key: key, value: value),
    onConflict: DoUpdate(
      (_) => AppSettingsCompanion(
        value: Value(value),
        updatedAt: Value(nowEpochMs()),
      ),
      target: [appSettings.key],
    ),
  );
}

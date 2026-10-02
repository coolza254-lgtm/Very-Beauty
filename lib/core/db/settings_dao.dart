import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'settings_dao.g.dart';

/// Keys used in the `app_settings` key-value table.
abstract final class SettingKeys {
  static const themeMode = 'theme_mode';
  static const locale = 'locale';
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

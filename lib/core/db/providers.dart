import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'daily_log_dao.dart';
import 'photos_dao.dart';
import 'products_dao.dart';
import 'routines_dao.dart';
import 'settings_dao.dart';

/// The single app-wide database. Override in tests with an in-memory one.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final settingsDaoProvider = Provider<SettingsDao>(
  (ref) => SettingsDao(ref.watch(databaseProvider)),
);

final productsDaoProvider = Provider<ProductsDao>(
  (ref) => ProductsDao(ref.watch(databaseProvider)),
);

final routinesDaoProvider = Provider<RoutinesDao>(
  (ref) => RoutinesDao(ref.watch(databaseProvider)),
);

final dailyLogDaoProvider = Provider<DailyLogDao>(
  (ref) => DailyLogDao(ref.watch(databaseProvider)),
);

/// All `app_settings` as a key-value map.
final settingsProvider = StreamProvider<Map<String, String>>(
  (ref) => ref.watch(settingsDaoProvider).watchAll(),
);

final photosDaoProvider = Provider<PhotosDao>(
  (ref) => PhotosDao(ref.watch(databaseProvider)),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'products_dao.dart';
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

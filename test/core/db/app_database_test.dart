import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' show SqliteException;
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/settings_dao.dart';

import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());
  tearDown(() => db.close());

  Future<int> addProduct([String name = 'Serum']) => db
      .into(db.products)
      .insert(
        ProductsCompanion.insert(name: name, category: ProductCategory.serum),
      );

  test('seeds default tags and morning/evening routines', () async {
    final tags = await db.select(db.tags).get();
    expect(tags.map((t) => t.name), containsAll(['ระคายเคือง', 'นอนน้อย']));
    expect(tags.where((t) => t.type == TagType.symptom), isNotEmpty);
    expect(tags.where((t) => t.type == TagType.factor), isNotEmpty);

    final routines = await db.select(db.routines).get();
    expect(routines.map((r) => r.timeOfDay), [
      TimeOfDaySlot.morning,
      TimeOfDaySlot.evening,
    ]);
  });

  test('product needs only name + category and gets defaults', () async {
    final id = await addProduct();
    final p = await (db.select(
      db.products,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(p.status, ProductStatus.inUse);
    expect(p.netUnit, NetUnit.g);
    expect(p.price, null);
    expect(p.createdAt, greaterThan(0));
    expect(p.updatedAt, p.createdAt);
  });

  test('enums are stored as snake_case text', () async {
    await db
        .into(db.products)
        .insert(
          ProductsCompanion.insert(
            name: 'Wish',
            category: ProductCategory.sunscreen,
            status: const Value(ProductStatus.wishlist),
            netUnit: const Value(NetUnit.ml),
          ),
        );
    await addProduct('In use');
    final rows = await db
        .customSelect('SELECT category, status, net_unit FROM products')
        .get();
    expect(rows.map((r) => r.data), [
      {'category': 'sunscreen', 'status': 'wishlist', 'net_unit': 'ml'},
      {'category': 'serum', 'status': 'in_use', 'net_unit': 'g'},
    ]);
  });

  test('deleting a product cascades to its weight and usage logs', () async {
    final id = await addProduct();
    await db
        .into(db.weightLogs)
        .insert(
          WeightLogsCompanion.insert(productId: id, weighedAt: 1, weight: 120),
        );
    await db
        .into(db.usageLogs)
        .insert(UsageLogsCompanion.insert(productId: id, usedAt: 1));

    await (db.delete(db.products)..where((t) => t.id.equals(id))).go();

    expect(await db.select(db.weightLogs).get(), isEmpty);
    expect(await db.select(db.usageLogs).get(), isEmpty);
  });

  test('foreign keys are enforced', () async {
    expect(
      () => db
          .into(db.usageLogs)
          .insert(UsageLogsCompanion.insert(productId: 999, usedAt: 1)),
      throwsA(isA<SqliteException>()),
    );
  });

  test('daily entry date is unique and scores must be 1–5', () async {
    await db
        .into(db.dailyEntries)
        .insert(
          DailyEntriesCompanion.insert(
            date: '2026-10-02',
            scoreOil: const Value(3),
          ),
        );
    expect(
      () => db
          .into(db.dailyEntries)
          .insert(DailyEntriesCompanion.insert(date: '2026-10-02')),
      throwsA(isA<SqliteException>()),
    );
    expect(
      () => db
          .into(db.dailyEntries)
          .insert(
            DailyEntriesCompanion.insert(
              date: '2026-10-03',
              scoreAcne: const Value(6),
            ),
          ),
      throwsA(isA<SqliteException>()),
    );
  });

  test('settings dao upserts values', () async {
    final dao = SettingsDao(db);
    expect(await dao.getValue(SettingKeys.themeMode), null);
    await dao.setValue(SettingKeys.themeMode, 'dark');
    await dao.setValue(SettingKeys.themeMode, 'light');
    expect(await dao.getValue(SettingKeys.themeMode), 'light');
    expect(await db.select(db.appSettings).get(), hasLength(1));
  });
}

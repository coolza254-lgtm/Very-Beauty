// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTable get products => attachedDatabase.products;
  $WeightLogsTable get weightLogs => attachedDatabase.weightLogs;
  $RoutinesTable get routines => attachedDatabase.routines;
  $UsageLogsTable get usageLogs => attachedDatabase.usageLogs;
  $TagsTable get tags => attachedDatabase.tags;
  $ProductTagsTable get productTags => attachedDatabase.productTags;
  $DailyEntriesTable get dailyEntries => attachedDatabase.dailyEntries;
  ProductsDaoManager get managers => ProductsDaoManager(this);
}

class ProductsDaoManager {
  final _$ProductsDaoMixin _db;
  ProductsDaoManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db.attachedDatabase, _db.weightLogs);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$UsageLogsTableTableManager get usageLogs =>
      $$UsageLogsTableTableManager(_db.attachedDatabase, _db.usageLogs);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$ProductTagsTableTableManager get productTags =>
      $$ProductTagsTableTableManager(_db.attachedDatabase, _db.productTags);
  $$DailyEntriesTableTableManager get dailyEntries =>
      $$DailyEntriesTableTableManager(_db.attachedDatabase, _db.dailyEntries);
}

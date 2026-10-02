// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights_dao.dart';

// ignore_for_file: type=lint
mixin _$InsightsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyEntriesTable get dailyEntries => attachedDatabase.dailyEntries;
  $TagsTable get tags => attachedDatabase.tags;
  $EntryTagsTable get entryTags => attachedDatabase.entryTags;
  $ProductsTable get products => attachedDatabase.products;
  $RoutinesTable get routines => attachedDatabase.routines;
  $UsageLogsTable get usageLogs => attachedDatabase.usageLogs;
  $PhotosTable get photos => attachedDatabase.photos;
  $WeightLogsTable get weightLogs => attachedDatabase.weightLogs;
  InsightsDaoManager get managers => InsightsDaoManager(this);
}

class InsightsDaoManager {
  final _$InsightsDaoMixin _db;
  InsightsDaoManager(this._db);
  $$DailyEntriesTableTableManager get dailyEntries =>
      $$DailyEntriesTableTableManager(_db.attachedDatabase, _db.dailyEntries);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$EntryTagsTableTableManager get entryTags =>
      $$EntryTagsTableTableManager(_db.attachedDatabase, _db.entryTags);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$UsageLogsTableTableManager get usageLogs =>
      $$UsageLogsTableTableManager(_db.attachedDatabase, _db.usageLogs);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db.attachedDatabase, _db.photos);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db.attachedDatabase, _db.weightLogs);
}

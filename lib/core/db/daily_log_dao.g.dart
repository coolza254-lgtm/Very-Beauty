// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyEntriesTable get dailyEntries => attachedDatabase.dailyEntries;
  $TagsTable get tags => attachedDatabase.tags;
  $EntryTagsTable get entryTags => attachedDatabase.entryTags;
  DailyLogDaoManager get managers => DailyLogDaoManager(this);
}

class DailyLogDaoManager {
  final _$DailyLogDaoMixin _db;
  DailyLogDaoManager(this._db);
  $$DailyEntriesTableTableManager get dailyEntries =>
      $$DailyEntriesTableTableManager(_db.attachedDatabase, _db.dailyEntries);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$EntryTagsTableTableManager get entryTags =>
      $$EntryTagsTableTableManager(_db.attachedDatabase, _db.entryTags);
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_database.steps.dart';
import 'enums.dart';
import 'seed.dart';
import 'tables.dart';

export 'enums.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    WeightLogs,
    Routines,
    RoutineSteps,
    UsageLogs,
    DailyEntries,
    Photos,
    Tags,
    EntryTags,
    ProductTags,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const databaseName = 'very_beauty';

  bool _closed = false;

  /// Safe to call more than once (restore closes the database before the
  /// provider that owns it is disposed).
  @override
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await super.close();
  }

  /// Bump this and add a step in [migration] for every schema change, then
  /// run `dart run drift_dev make-migrations` (see README) and update
  /// docs/SPEC.md §5.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.addColumn(schema.products, schema.products.finishedDate);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Emits [load]'s result now and again whenever any of [tables] changes.
  ///
  /// Use for screens that combine several tables, where a single drift
  /// `watch()` query would not notice changes in the others.
  Stream<T> watchTables<T>(
    Iterable<TableInfo<Table, dynamic>> tables,
    Future<T> Function() load,
  ) async* {
    yield await load();
    await for (final _ in tableUpdates(TableUpdateQuery.onAllTables(tables))) {
      yield await load();
    }
  }

  Future<void> _seed() async {
    await batch((b) {
      for (final MapEntry(key: type, value: names) in seedTags.entries) {
        b.insertAll(tags, [
          for (final name in names)
            TagsCompanion.insert(name: name, type: type),
        ]);
      }
      b.insertAll(routines, [
        for (final (name, slot) in seedRoutines)
          RoutinesCompanion.insert(name: name, timeOfDay: slot),
      ]);
    });
  }

  /// `<documents>/very_beauty.sqlite` — drift_flutter's default location,
  /// spelled out so backup/restore can replace exactly this file.
  static Future<File> defaultFile() async => File(
    p.join(
      (await getApplicationDocumentsDirectory()).path,
      '$databaseName.sqlite',
    ),
  );

  static QueryExecutor _openConnection() => driftDatabase(
    name: databaseName,
    native: DriftNativeOptions(
      databasePath: () async => (await defaultFile()).path,
    ),
  );
}

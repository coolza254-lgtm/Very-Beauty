import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

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

  /// Bump this and add a step in [migration] for every schema change, then
  /// run `dart run drift_dev make-migrations` (see README) and update
  /// docs/SPEC.md §5.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
    // Future versions: use the generated `stepByStep` helper from
    // app_database.steps.dart, e.g.
    // onUpgrade: stepByStep(from1To2: (m, schema) async { ... }),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

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

  static QueryExecutor _openConnection() => driftDatabase(name: databaseName);
}

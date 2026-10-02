import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:very_beauty/core/db/app_database.dart';

/// A fresh in-memory database for tests.
AppDatabase createTestDatabase() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

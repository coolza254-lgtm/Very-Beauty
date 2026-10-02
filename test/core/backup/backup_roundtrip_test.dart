import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:very_beauty/core/backup/backup_service.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/photos_dao.dart';
import 'package:very_beauty/core/storage/app_paths.dart';
import 'package:very_beauty/core/storage/photo_storage.dart';

import '../../drift/app_database/generated/schema_v1.dart' as v1;
import '../../helpers/demo_data.dart';

/// Row counts for every table, to compare devices.
Future<Map<String, int>> _counts(AppDatabase db) async => {
  for (final t in db.allTables)
    t.actualTableName:
        (await db
                .customSelect('SELECT COUNT(*) AS c FROM ${t.actualTableName}')
                .getSingle())
            .read<int>('c'),
};

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late Directory root;

  setUp(() async => root = await Directory.systemTemp.createTemp('vb_backup'));
  tearDown(() => root.delete(recursive: true));

  Future<Directory> dir(String name) =>
      Directory(p.join(root.path, name)).create(recursive: true);

  test(
    'export on one phone, import on another: data and photos match',
    () async {
      // --- Phone A -------------------------------------------------------
      final docsA = await dir('a/docs');
      final pathsA = AppPaths(docsA);
      final dbA = AppDatabase(
        NativeDatabase(File(p.join(docsA.path, 'vb.sqlite'))),
      );
      await seedDemoData(dbA, now: DateTime(2026, 10, 15));
      final stored = await PhotoStorage(pathsA).save(
        img.encodeJpg(img.Image(width: 40, height: 50)),
        takenAt: DateTime(2026, 10, 14, 8),
      );
      await PhotosDao(dbA).addPhoto(
        date: '2026-10-14',
        takenAt: DateTime(2026, 10, 14, 8),
        filePath: stored.filePath,
        thumbPath: stored.thumbPath,
        session: TimeOfDaySlot.morning,
        note: 'after retinol',
      );
      final countsA = await _counts(dbA);
      final serumA = await (dbA.select(
        dbA.products,
      )..where((t) => t.name.equals('Vitamin C Glow Serum'))).getSingle();

      final zip = await BackupService(
        paths: pathsA,
        tempDir: await dir('a/tmp'),
      ).export(dbA, appVersion: '1.0.0+7', now: DateTime(2026, 10, 15, 21, 5));
      await dbA.close();
      expect(p.basename(zip.path), 'VeryBeauty-backup-20261015-2105.zip');

      // --- Phone B (already has some unrelated data) ------------------------
      final docsB = await dir('b/docs');
      final pathsB = AppPaths(docsB);
      final dbFileB = File(p.join(docsB.path, 'vb.sqlite'));
      var dbB = AppDatabase(NativeDatabase(dbFileB));
      await dbB
          .into(dbB.products)
          .insert(
            ProductsCompanion.insert(
              name: 'Old',
              category: ProductCategory.other,
            ),
          );
      await File(p.join(pathsB.photos.path, 'stale.jpg'))
          .create(recursive: true);

      final service = BackupService(paths: pathsB, tempDir: await dir('b/tmp'));
      final manifest = await service.inspect(zip);
      expect(manifest.appVersion, '1.0.0+7');
      expect(manifest.photoCount, 1);
      expect(manifest.schemaVersion, dbB.schemaVersion);

      await service.restore(
        zip,
        databaseFile: dbFileB,
        currentSchemaVersion: dbB.schemaVersion,
        closeDatabase: dbB.close,
      );
      dbB = AppDatabase(NativeDatabase(dbFileB));
      addTearDown(dbB.close);

      expect(await _counts(dbB), countsA);
      final serumB = await (dbB.select(
        dbB.products,
      )..where((t) => t.name.equals('Vitamin C Glow Serum'))).getSingle();
      expect(serumB, serumA);
      expect(
        await (dbB.select(
          dbB.products,
        )..where((t) => t.name.equals('Old'))).get(),
        isEmpty,
      );
      final photo = (await PhotosDao(dbB).watchAll().first).single;
      expect(photo.photo.note, 'after retinol');
      expect(File(pathsB.resolve(photo.photo.filePath)).existsSync(), isTrue);
      expect(File(pathsB.resolve(photo.photo.thumbPath)).existsSync(), isTrue);
      expect(
        File(p.join(pathsB.photos.path, 'stale.jpg')).existsSync(),
        isFalse,
      );
    },
  );

  Future<File> zipWith(Map<String, Object> manifest, {File? database}) async {
    final out = File(p.join(root.path, 'custom_${manifest.hashCode}.zip'));
    final encoder = ZipFileEncoder()..create(out.path);
    encoder.addArchiveFile(
      ArchiveFile.string('manifest.json', jsonEncode(manifest)),
    );
    if (database != null) {
      await encoder.addFile(database, 'database.sqlite');
    } else {
      encoder.addArchiveFile(ArchiveFile.string('database.sqlite', 'x'));
    }
    await encoder.close();
    return out;
  }

  Map<String, Object> manifestJson({int schema = 2}) => {
    'format': 'very_beauty_backup',
    'formatVersion': 1,
    'appVersion': '9.9.9',
    'schemaVersion': schema,
    'createdAt': '2026-10-01T00:00:00Z',
    'photoCount': 0,
  };

  test('a backup from an older schema is migrated on restore', () async {
    final oldFile = File(p.join(root.path, 'old.sqlite'));
    final old = v1.DatabaseAtV1(NativeDatabase(oldFile));
    await old.customStatement(
      'INSERT INTO products '
      '(name, category, net_unit, status, created_at, updated_at) '
      "VALUES ('Legacy Toner', 'toner', 'ml', 'in_use', 1, 1)",
    );
    await old.close();

    final docs = await dir('c/docs');
    final dbFile = File(p.join(docs.path, 'vb.sqlite'));
    final service = BackupService(
      paths: AppPaths(docs),
      tempDir: await dir('c/tmp'),
    );
    await service.restore(
      await zipWith(manifestJson(schema: 1), database: oldFile),
      databaseFile: dbFile,
      currentSchemaVersion: 2,
      closeDatabase: () async {},
    );
    final db = AppDatabase(NativeDatabase(dbFile));
    addTearDown(db.close);
    final p0 = (await db.select(db.products).get()).single;
    expect(p0.name, 'Legacy Toner');
    expect(p0.finishedDate, isNull); // v2 column exists now
  });

  test('rejects newer backups and non-backups without touching data', () async {
    final docs = await dir('d/docs');
    final dbFile = File(p.join(docs.path, 'vb.sqlite'));
    await dbFile.writeAsString('live');
    final service = BackupService(
      paths: AppPaths(docs),
      tempDir: await dir('d/tmp'),
    );
    var closed = false;
    Future<void> close() async => closed = true;

    await expectLater(
      service.restore(
        await zipWith(manifestJson(schema: 99)),
        databaseFile: dbFile,
        currentSchemaVersion: 2,
        closeDatabase: close,
      ),
      throwsA(
        isA<BackupException>().having(
          (e) => e.error,
          'error',
          BackupError.newerVersion,
        ),
      ),
    );
    await expectLater(
      service.restore(
        await zipWith({...manifestJson(), 'format': 'something_else'}),
        databaseFile: dbFile,
        currentSchemaVersion: 2,
        closeDatabase: close,
      ),
      throwsA(
        isA<BackupException>().having(
          (e) => e.error,
          'error',
          BackupError.notABackup,
        ),
      ),
    );
    // A zip whose "database" is garbage fails validation before swapping.
    await expectLater(
      service.restore(
        await zipWith(manifestJson()),
        databaseFile: dbFile,
        currentSchemaVersion: 2,
        closeDatabase: close,
      ),
      throwsA(
        isA<BackupException>().having(
          (e) => e.error,
          'error',
          BackupError.corrupt,
        ),
      ),
    );
    expect(closed, isFalse);
    expect(await dbFile.readAsString(), 'live');
  });
}

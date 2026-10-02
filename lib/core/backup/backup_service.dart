import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../db/app_database.dart';
import '../storage/app_paths.dart';

/// Contents of `manifest.json` inside a backup zip.
class BackupManifest {
  const BackupManifest({
    required this.appVersion,
    required this.schemaVersion,
    required this.createdAt,
    required this.photoCount,
    this.formatVersion = currentFormatVersion,
  });

  static const format = 'very_beauty_backup';
  static const currentFormatVersion = 1;

  final int formatVersion;
  final String appVersion;
  final int schemaVersion;
  final DateTime createdAt;
  final int photoCount;

  Map<String, Object> toJson() => {
    'format': format,
    'formatVersion': formatVersion,
    'appVersion': appVersion,
    'schemaVersion': schemaVersion,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'photoCount': photoCount,
  };

  static BackupManifest fromJson(Map<String, Object?> json) {
    if (json['format'] != format) {
      throw const BackupException(BackupError.notABackup);
    }
    return BackupManifest(
      formatVersion: json['formatVersion'] as int,
      appVersion: json['appVersion'] as String,
      schemaVersion: json['schemaVersion'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      photoCount: json['photoCount'] as int,
    );
  }
}

enum BackupError {
  /// Not a Very Beauty backup zip.
  notABackup,

  /// Made by a newer app version; update the app first.
  newerVersion,

  /// The zip or its database is damaged.
  corrupt,
}

class BackupException implements Exception {
  const BackupException(this.error, [this.detail]);

  final BackupError error;
  final Object? detail;

  @override
  String toString() => 'BackupException($error, $detail)';
}

/// Exports everything (database + photos + manifest) to one zip, and
/// restores such a zip, replacing current data (docs/SPEC.md §9).
class BackupService {
  const BackupService({required this.paths, required this.tempDir});

  final AppPaths paths;

  /// Scratch space (the app's temporary directory).
  final Directory tempDir;

  static const _manifestName = 'manifest.json';
  static const _databaseName = 'database.sqlite';

  /// Writes `VeryBeauty-backup-YYYYMMDD-HHmm.zip` into [tempDir].
  Future<File> export(
    AppDatabase db, {
    required String appVersion,
    DateTime? now,
  }) async {
    final when = now ?? DateTime.now();
    final work = await Directory(
      p.join(tempDir.path, 'backup_${when.millisecondsSinceEpoch}'),
    ).create(recursive: true);
    try {
      // A consistent snapshot even while the app is running.
      final snapshot = File(p.join(work.path, _databaseName));
      final escaped = snapshot.path.replaceAll("'", "''");
      await db.customStatement("VACUUM INTO '$escaped'");

      final photos = await _photoFiles();
      final manifest = BackupManifest(
        appVersion: appVersion,
        schemaVersion: db.schemaVersion,
        createdAt: when,
        photoCount: photos.where((f) => !f.path.contains('/thumbs/')).length,
      );

      String two(int n) => n.toString().padLeft(2, '0');
      final name =
          'VeryBeauty-backup-${when.year}${two(when.month)}${two(when.day)}'
          '-${two(when.hour)}${two(when.minute)}.zip';
      final zip = File(p.join(tempDir.path, name));
      final encoder = ZipFileEncoder()..create(zip.path);
      encoder.addArchiveFile(
        ArchiveFile.string(
          _manifestName,
          const JsonEncoder.withIndent('  ').convert(manifest.toJson()),
        ),
      );
      await encoder.addFile(snapshot, _databaseName);
      for (final f in photos) {
        await encoder.addFile(f, paths.relativize(f.path));
      }
      await encoder.close();
      return zip;
    } finally {
      await work.delete(recursive: true);
    }
  }

  /// Reads only the manifest, to show the user what they are restoring.
  Future<BackupManifest> inspect(File zip) async {
    final input = InputFileStream(zip.path);
    try {
      final archive = ZipDecoder().decodeStream(input);
      final entry = archive.findFile(_manifestName);
      if (entry == null || archive.findFile(_databaseName) == null) {
        throw const BackupException(BackupError.notABackup);
      }
      final json = jsonDecode(utf8.decode(entry.content));
      return BackupManifest.fromJson((json as Map).cast<String, Object?>());
    } on BackupException {
      rethrow;
    } catch (e) {
      throw BackupException(BackupError.notABackup, e);
    } finally {
      await input.close();
    }
  }

  /// Replaces the current database file and photos with the backup's.
  ///
  /// The backup's database is opened (and migrated to the current schema)
  /// in a staging folder first, so a broken backup never touches live data.
  /// [closeDatabase] must close the running database before files are
  /// swapped; reopen it afterwards.
  Future<BackupManifest> restore(
    File zip, {
    required File databaseFile,
    required int currentSchemaVersion,
    required Future<void> Function() closeDatabase,
  }) async {
    final manifest = await inspect(zip);
    if (manifest.schemaVersion > currentSchemaVersion ||
        manifest.formatVersion > BackupManifest.currentFormatVersion) {
      throw BackupException(BackupError.newerVersion, manifest.appVersion);
    }

    final staging = await Directory(
      p.join(tempDir.path, 'restore_${DateTime.now().millisecondsSinceEpoch}'),
    ).create(recursive: true);
    try {
      await _extract(zip, staging);
      final stagedDb = File(p.join(staging.path, _databaseName));
      await _validateAndMigrate(stagedDb);

      await closeDatabase();
      for (final suffix in ['', '-wal', '-shm', '-journal']) {
        final f = File('${databaseFile.path}$suffix');
        if (await f.exists()) await f.delete();
      }
      await databaseFile.parent.create(recursive: true);
      await stagedDb.copy(databaseFile.path);

      if (await paths.photos.exists()) {
        await paths.photos.delete(recursive: true);
      }
      final stagedPhotos = Directory(p.join(staging.path, 'photos'));
      if (await stagedPhotos.exists()) {
        await _moveDirectory(stagedPhotos, paths.photos);
      }
      return manifest;
    } finally {
      if (await staging.exists()) await staging.delete(recursive: true);
    }
  }

  Future<List<File>> _photoFiles() async {
    if (!await paths.photos.exists()) return const [];
    return paths.photos
        .list(recursive: true, followLinks: false)
        .where((e) => e is File)
        .cast<File>()
        .toList();
  }

  Future<void> _extract(File zip, Directory target) async {
    final input = InputFileStream(zip.path);
    try {
      final archive = ZipDecoder().decodeStream(input);
      for (final entry in archive.files) {
        if (!entry.isFile) continue;
        final name = entry.name;
        if (name != _databaseName && !name.startsWith('photos/')) continue;
        final out = p.normalize(p.join(target.path, name));
        // Refuse "../" tricks that would write outside the staging folder.
        if (!p.isWithin(target.path, out)) {
          throw BackupException(BackupError.corrupt, name);
        }
        await Directory(p.dirname(out)).create(recursive: true);
        final output = OutputFileStream(out);
        entry.writeContent(output);
        await output.close();
      }
    } on BackupException {
      rethrow;
    } catch (e) {
      throw BackupException(BackupError.corrupt, e);
    } finally {
      await input.close();
    }
  }

  Future<void> _validateAndMigrate(File dbFile) async {
    if (!await dbFile.exists()) {
      throw const BackupException(BackupError.corrupt, 'no database');
    }
    // SQLite would happily treat a damaged/empty file as a brand-new
    // database, so check the file header and that it has a schema first.
    final header = await dbFile
        .openRead(0, 16)
        .fold<List<int>>([], (a, b) => a..addAll(b));
    if (ascii.decode(header, allowInvalid: true) != 'SQLite format 3\u0000') {
      throw const BackupException(BackupError.corrupt, 'not SQLite');
    }
    final raw = sqlite3.open(dbFile.path, mode: OpenMode.readOnly);
    try {
      if (raw.userVersion < 1) {
        throw const BackupException(BackupError.corrupt, 'no schema');
      }
    } finally {
      raw.close();
    }
    final db = AppDatabase(NativeDatabase(dbFile));
    try {
      final check = await db.customSelect('PRAGMA integrity_check').get();
      if (check.first.data.values.first != 'ok') {
        throw BackupException(BackupError.corrupt, check.first.data);
      }
      // Opening runs migrations from the backup's schema to the current one.
      await db.select(db.products).get();
    } on BackupException {
      rethrow;
    } catch (e) {
      throw BackupException(BackupError.corrupt, e);
    } finally {
      await db.close();
    }
  }

  Future<void> _moveDirectory(Directory from, Directory to) async {
    try {
      await to.parent.create(recursive: true);
      await from.rename(to.path);
    } on FileSystemException {
      // Different file systems: copy then delete.
      await for (final e in from.list(recursive: true)) {
        if (e is! File) continue;
        final dest = File(p.join(to.path, p.relative(e.path, from: from.path)));
        await dest.parent.create(recursive: true);
        await e.copy(dest.path);
      }
      await from.delete(recursive: true);
    }
  }
}

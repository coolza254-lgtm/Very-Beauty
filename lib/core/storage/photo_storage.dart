import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import 'app_paths.dart';
import 'photo_processing.dart';

/// Relative paths of a stored photo.
class StoredPhoto {
  const StoredPhoto({required this.filePath, required this.thumbPath});

  final String filePath;
  final String thumbPath;
}

/// Writes processed photos under `photos/YYYY/MM/` (full size) and
/// `photos/thumbs/YYYY/MM/` (thumbnails).
class PhotoStorage {
  const PhotoStorage(this.paths);

  final AppPaths paths;

  Future<StoredPhoto> save(
    Uint8List bytes, {
    required DateTime takenAt,
    bool mirror = false,
  }) async {
    final processed = await Isolate.run(
      () => processPhoto(PhotoJob(bytes, mirror: mirror)),
    );
    final y = takenAt.year.toString();
    final m = takenAt.month.toString().padLeft(2, '0');
    final name = '${takenAt.millisecondsSinceEpoch}.jpg';
    final full = p.join('photos', y, m, name);
    final thumb = p.join('photos', 'thumbs', y, m, name);
    await _write(full, processed.full);
    await _write(thumb, processed.thumb);
    return StoredPhoto(filePath: full, thumbPath: thumb);
  }

  Future<void> delete(StoredPhoto photo) async {
    for (final rel in [photo.filePath, photo.thumbPath]) {
      final f = File(paths.resolve(rel));
      if (await f.exists()) await f.delete();
    }
  }

  Future<void> _write(String relative, Uint8List bytes) async {
    final file = File(paths.resolve(relative));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/photos_dao.dart';
import 'package:very_beauty/core/storage/app_paths.dart';
import 'package:very_beauty/core/storage/photo_processing.dart';
import 'package:very_beauty/core/storage/photo_storage.dart';

import '../../helpers/test_database.dart';

/// A 400x300 JPEG with GPS + camera EXIF and orientation 6 (rotate 90°).
Uint8List _jpegWithExif() {
  final image = img.Image(width: 400, height: 300);
  img.fill(image, color: img.ColorRgb8(240, 200, 200));
  // Mark the top-left corner so mirroring can be detected.
  img.fillRect(
    image,
    x1: 0,
    y1: 0,
    x2: 40,
    y2: 40,
    color: img.ColorRgb8(0, 0, 0),
  );
  image.exif.imageIfd['Orientation'] = 6;
  image.exif.imageIfd['Make'] = 'TestCam';
  image.exif.gpsIfd['GPSLatitude'] = img.IfdValueRational(13, 1);
  image.exif.gpsIfd['GPSLongitude'] = img.IfdValueRational(100, 1);
  return img.encodeJpg(image);
}

void main() {
  test('removes all EXIF, bakes orientation and makes a thumbnail', () {
    final input = _jpegWithExif();
    expect(img.decodeJpgExif(input)!.gpsIfd.isEmpty, isFalse);

    final out = processPhoto(PhotoJob(input, thumbSide: 100));
    final full = img.decodeJpg(out.full)!;
    final thumb = img.decodeJpg(out.thumb)!;

    // Orientation 6 rotates a 400x300 landscape into 300x400 portrait.
    expect((full.width, full.height), (300, 400));
    expect(thumb.height, 100);

    for (final bytes in [out.full, out.thumb]) {
      final exif = img.decodeJpgExif(bytes);
      expect(exif == null || exif.isEmpty, isTrue, reason: 'EXIF must be gone');
    }
  });

  test('mirrors selfies when asked', () {
    final image = img.Image(width: 100, height: 50);
    img.fill(image, color: img.ColorRgb8(255, 255, 255));
    img.fillRect(
      image,
      x1: 0,
      y1: 0,
      x2: 10,
      y2: 49,
      color: img.ColorRgb8(0, 0, 0),
    );
    final out = processPhoto(PhotoJob(img.encodePng(image), mirror: true));
    final decoded = img.decodeJpg(out.full)!;
    expect(
      decoded.getPixel(95, 25).r,
      lessThan(60),
    ); // dark bar now on the right
    expect(decoded.getPixel(5, 25).r, greaterThan(200));
  });

  test('downsizes large photos', () {
    final big = img.Image(width: 3000, height: 4000);
    final out = processPhoto(PhotoJob(img.encodeJpg(big)));
    expect(img.decodeJpg(out.full)!.height, 2000);
  });

  test(
    'storage writes relative paths and the DAO links them to the day',
    () async {
      final dir = await Directory.systemTemp.createTemp('vb_photos');
      addTearDown(() => dir.delete(recursive: true));
      final storage = PhotoStorage(AppPaths(dir));
      final takenAt = DateTime(2026, 10, 2, 8, 15);

      final stored = await storage.save(
        img.encodeJpg(img.Image(width: 80, height: 60)),
        takenAt: takenAt,
      );
      expect(stored.filePath, startsWith('photos/2026/10/'));
      expect(stored.thumbPath, startsWith('photos/thumbs/2026/10/'));
      expect(File('${dir.path}/${stored.filePath}').existsSync(), isTrue);

      final db = createTestDatabase();
      addTearDown(db.close);
      final dao = PhotosDao(db);
      final id = await dao.addPhoto(
        date: '2026-10-02',
        takenAt: takenAt,
        filePath: stored.filePath,
        thumbPath: stored.thumbPath,
        session: TimeOfDaySlot.morning,
      );
      final all = await dao.watchAll().first;
      expect(all.single.date, '2026-10-02');
      expect((await dao.latest())!.id, id);

      final deleted = await dao.deletePhoto(id);
      await storage.delete(
        StoredPhoto(filePath: deleted!.filePath, thumbPath: deleted.thumbPath),
      );
      expect(File('${dir.path}/${stored.filePath}').existsSync(), isFalse);
      expect(await dao.watchAll().first, isEmpty);
    },
  );
}

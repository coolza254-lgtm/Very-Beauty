import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/photos_dao.dart';
import 'package:very_beauty/core/storage/app_paths.dart';
import 'package:very_beauty/core/storage/photo_storage.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('gallery groups by month and compares two photos', (
    tester,
  ) async {
    final dir = (await tester.runAsync(
      () => Directory.systemTemp.createTemp('vb_gallery'),
    ))!;
    addTearDown(() => dir.delete(recursive: true));
    final paths = AppPaths(dir);
    final dates = [DateTime(2026, 9, 3, 8), DateTime(2026, 10, 1, 8)];
    final stored = (await tester.runAsync(
      () => Future.wait([
        for (final d in dates)
          PhotoStorage(
            paths,
          ).save(img.encodeJpg(img.Image(width: 30, height: 40)), takenAt: d),
      ]),
    ))!;

    await pumpApp(
      tester,
      overrides: [appPathsProvider.overrideWith((ref) async => paths)],
      seed: (db) async {
        for (final (i, d) in dates.indexed) {
          await PhotosDao(db).addPhoto(
            date: toDateKey(d),
            takenAt: d,
            filePath: stored[i].filePath,
            thumbPath: stored[i].thumbPath,
            session: TimeOfDaySlot.morning,
          );
        }
      },
    );

    await tester.tap(find.text('รูปถ่าย'));
    await tester.pumpAndSettle();
    expect(find.text('ตุลาคม 2569'), findsOneWidget);
    expect(find.text('กันยายน 2569'), findsOneWidget);

    await tester.tap(find.text('เทียบรูป'));
    await tester.pumpAndSettle();
    expect(find.text('เลือก 2 รูปที่จะเทียบ'), findsOneWidget);
    await tester.tap(find.text('1')); // 1 Oct
    await tester.tap(find.text('3')); // 3 Sep
    await tester.pumpAndSettle();
    await tester.tap(find.text('เทียบรูป'));
    await tester.pumpAndSettle();
    expect(find.text('เทียบรูป · ห่างกัน 28 วัน'), findsOneWidget);
  });
}

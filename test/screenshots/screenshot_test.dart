// Renders phone-sized screenshots of the main screens for design review.
//
// Run: flutter test test/screenshots --update-goldens --dart-define=SCREENSHOTS=true
// Output: build/screenshots/*.png (not committed).
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/app/app.dart';
import 'package:very_beauty/core/db/providers.dart';
import 'package:very_beauty/core/db/settings_dao.dart';

import '../helpers/test_database.dart';

const _enabled = bool.fromEnvironment('SCREENSHOTS');

Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> paths) async {
    final loader = FontLoader(family);
    for (final p in paths) {
      loader.addFont(
        Future.value(ByteData.sublistView(File(p).readAsBytesSync())),
      );
    }
    await loader.load();
  }

  final flutterRoot = Platform.environment['FLUTTER_ROOT']!;
  await load('MaterialIcons', [
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  ]);
  await load('Mali', [
    for (final w in ['Medium', 'SemiBold', 'Bold']) 'assets/fonts/Mali-$w.ttf',
  ]);
  await load('Prompt', [
    for (final w in ['Light', 'Regular', 'Medium', 'SemiBold'])
      'assets/fonts/Prompt-$w.ttf',
  ]);
}

void main() {
  setUpAll(_loadFonts);

  Future<void> shoot(
    WidgetTester tester,
    String name, {
    String? tab,
    String theme = 'light',
  }) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final db = createTestDatabase();
    addTearDown(db.close);
    await SettingsDao(db).setValue(SettingKeys.themeMode, theme);

    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const VeryBeautyApp(),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));
      for (final element in find.byType(Image).evaluate()) {
        final image = element.widget as Image;
        await precacheImage(image.image, element);
      }
      await precacheImage(
        const AssetImage('assets/branding/face_round.png'),
        tester.element(find.byType(Scaffold).first),
      );
    });
    await tester.pumpAndSettle();
    if (tab != null) {
      await tester.tap(find.text(tab));
      await tester.pumpAndSettle();
    }
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/$name.png'),
    );
  }

  testWidgets('today', (t) => shoot(t, '1_today'), skip: !_enabled);
  testWidgets(
    'products',
    (t) => shoot(t, '2_products', tab: 'สินค้า'),
    skip: !_enabled,
  );
  testWidgets(
    'settings',
    (t) => shoot(t, '3_settings', tab: 'ตั้งค่า'),
    skip: !_enabled,
  );
  testWidgets(
    'today dark',
    (t) => shoot(t, '4_today_dark', theme: 'dark'),
    skip: !_enabled,
  );
}

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

import '../helpers/demo_data.dart';
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
    bool demo = false,
    Future<void> Function(WidgetTester tester)? navigate,
  }) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final db = createTestDatabase();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      await db.close();
    });
    await SettingsDao(db).setValue(SettingKeys.themeMode, theme);
    if (demo) await tester.runAsync(() => seedDemoData(db));

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
      await tester.tap(find.text(tab).last);
      await tester.pumpAndSettle();
    }
    if (navigate != null) await navigate(tester);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/$name.png'),
    );
  }

  Future<void> open(WidgetTester t, String text) async {
    await t.tap(find.text(text).first);
    await t.pumpAndSettle();
  }

  final shots = <String, Future<void> Function(WidgetTester)>{
    '01_today_empty': (t) => shoot(t, '01_today_empty'),
    '02_today': (t) => shoot(t, '02_today', demo: true),
    '03_today_dark': (t) =>
        shoot(t, '03_today_dark', theme: 'dark', demo: true),
    '10_products_empty': (t) => shoot(t, '10_products_empty', tab: 'สินค้า'),
    '11_products': (t) => shoot(t, '11_products', tab: 'สินค้า', demo: true),
    '12_product_detail': (t) => shoot(
      t,
      '12_product_detail',
      tab: 'สินค้า',
      demo: true,
      navigate: (t) => open(t, 'Vitamin C Glow Serum'),
    ),
    '13_product_detail_more': (t) => shoot(
      t,
      '13_product_detail_more',
      tab: 'สินค้า',
      demo: true,
      navigate: (t) async {
        await open(t, 'Vitamin C Glow Serum');
        await t.drag(find.byType(ListView).last, const Offset(0, -700));
        await t.pumpAndSettle();
      },
    ),
    '14_product_form': (t) => shoot(
      t,
      '14_product_form',
      tab: 'สินค้า',
      demo: true,
      navigate: (t) => open(t, 'เพิ่มสินค้า'),
    ),
    '90_settings': (t) => shoot(t, '90_settings', tab: 'ตั้งค่า'),
  };
  for (final MapEntry(key: name, value: body) in shots.entries) {
    testWidgets(name, body, skip: !_enabled);
  }
}

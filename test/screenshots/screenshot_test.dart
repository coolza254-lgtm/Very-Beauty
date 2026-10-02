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
import 'package:very_beauty/core/notifications/notification_service.dart';
import 'package:very_beauty/core/notifications/reminder_sync.dart';
import 'package:very_beauty/core/db/settings_dao.dart';

import 'package:very_beauty/core/update/app_update_service.dart';
import 'package:very_beauty/core/update/update_controller.dart';

import '../helpers/demo_data.dart';
import '../helpers/pump_app.dart';
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
          overrides: [
            databaseProvider.overrideWithValue(db),
            notificationServiceProvider.overrideWithValue(
              NoopNotificationService(),
            ),
            appUpdateServiceProvider.overrideWithValue(NoUpdates()),
            currentVersionProvider.overrideWith(
              (ref) async => const AppVersionInfo(version: '1.0.0', build: 1),
            ),
          ],
          child: const VeryBeautyApp(),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));
    });
    await tester.pumpAndSettle();
    await tester.runAsync(
      () => precacheImage(
        const AssetImage('assets/branding/face_round.png'),
        tester.element(find.byType(Scaffold).first),
      ),
    );
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
    '04_today_scrolled': (t) => shoot(
      t,
      '04_today_scrolled',
      demo: true,
      navigate: (t) async {
        await t.tap(find.text('ใช้ตามปกติ').first);
        await t.pumpAndSettle();
        await t.drag(find.byType(ListView).first, const Offset(0, -900));
        await t.pumpAndSettle();
      },
    ),
    '05_daily_log': (t) => shoot(
      t,
      '05_daily_log',
      demo: true,
      navigate: (t) async {
        await t.drag(find.byType(ListView).first, const Offset(0, -1400));
        await t.pumpAndSettle();
        await open(t, 'บันทึกสภาพผิว');
      },
    ),
    '06_routine_editor': (t) => shoot(
      t,
      '06_routine_editor',
      demo: true,
      navigate: (t) async {
        await open(t, 'จัดการรูทีน');
        await open(t, 'เช้า');
      },
    ),
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
    '15_product_form_ingredients': (t) => shoot(
      t,
      '15_product_form_ingredients',
      tab: 'สินค้า',
      demo: true,
      navigate: (t) async {
        await open(t, 'เพิ่มสินค้า');
        await open(t, 'กันแดด');
        final field = find.byKey(const Key('ingredientField'));
        await t.enterText(field, 'Niacinamide, Glycerin,');
        await t.pumpAndSettle();
        await t.drag(find.byType(ListView).first, const Offset(0, -320));
        await t.pumpAndSettle();
        await t.enterText(field, 'zinc');
        await t.pumpAndSettle();
      },
    ),
    '16_ingredient_db': (t) => shoot(
      t,
      '16_ingredient_db',
      tab: 'สินค้า',
      navigate: (t) async {
        await t.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
        await t.pumpAndSettle();
      },
    ),
    '17_ingredient_info': (t) => shoot(
      t,
      '17_ingredient_info',
      tab: 'สินค้า',
      navigate: (t) async {
        await t.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
        await t.pumpAndSettle();
        await t.enterText(find.byType(TextField), 'niacinamide');
        await t.pumpAndSettle();
        await open(t, 'Niacinamide');
      },
    ),
    '18_ingredient_structure': (t) => shoot(
      t,
      '18_ingredient_structure',
      tab: 'สินค้า',
      navigate: (t) async {
        await t.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
        await t.pumpAndSettle();
        await t.enterText(find.byType(TextField), 'tinosorb s');
        await t.pumpAndSettle();
        await open(t, 'Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine');
        await t.drag(find.byType(ListView).last, const Offset(0, -500));
        await t.pumpAndSettle();
      },
    ),
    '20_insights_calendar': (t) =>
        shoot(t, '20_insights_calendar', tab: 'สรุป', demo: true),
    '21_insights_day': (t) => shoot(
      t,
      '21_insights_day',
      tab: 'สรุป',
      demo: true,
      navigate: (t) async {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        await t.tap(find.text('${yesterday.day}').last);
        await t.pumpAndSettle();
      },
    ),
    '22_insights_chart': (t) => shoot(
      t,
      '22_insights_chart',
      tab: 'สรุป',
      demo: true,
      navigate: (t) => open(t, 'กราฟผิว'),
    ),
    '23_insights_spending': (t) => shoot(
      t,
      '23_insights_spending',
      tab: 'สรุป',
      demo: true,
      navigate: (t) => open(t, 'ค่าใช้จ่าย'),
    ),
    '90_settings': (t) => shoot(t, '90_settings', tab: 'ตั้งค่า'),
    '91_settings_more': (t) => shoot(
      t,
      '91_settings_more',
      tab: 'ตั้งค่า',
      navigate: (t) async {
        await t.drag(find.byType(ListView).last, const Offset(0, -900));
        await t.pumpAndSettle();
      },
    ),
  };
  for (final MapEntry(key: name, value: body) in shots.entries) {
    testWidgets(name, body, skip: !_enabled);
  }
}

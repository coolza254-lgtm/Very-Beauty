import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/app/app.dart';
import 'package:very_beauty/core/db/providers.dart';

import 'helpers/test_database.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const VeryBeautyApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('opens on Today with Thai bottom navigation', (tester) async {
    await pumpApp(tester);

    expect(find.byType(NavigationBar), findsOneWidget);
    for (final label in ['วันนี้', 'สินค้า', 'รูปถ่าย', 'สรุป', 'ตั้งค่า']) {
      expect(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
        findsOneWidget,
      );
    }
    expect(find.text('วันนี้ดูแลผิวแล้วหรือยัง?'), findsOneWidget);
  });

  testWidgets('switching theme in Settings updates the app', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('ตั้งค่า'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('มืด'));
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });
}

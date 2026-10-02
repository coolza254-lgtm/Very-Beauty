import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
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

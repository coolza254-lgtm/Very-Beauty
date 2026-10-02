import 'package:drift/drift.dart' hide isNull;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/daily_log_dao.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

import '../helpers/demo_data.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('"done as usual" ticks the whole routine in one tap', (
    tester,
  ) async {
    final db = await pumpApp(tester, seed: seedDemoData);

    expect(find.text('วันนี้ทำไปแล้ว 0 จาก 6 ขั้นตอน'), findsOneWidget);
    await tester.tap(find.text('ใช้ตามปกติ').first);
    await tester.pumpAndSettle();
    expect(find.text('วันนี้ทำไปแล้ว 4 จาก 6 ขั้นตอน'), findsOneWidget);

    // Untick one step.
    final spf = find.text('Airy Sun Milk SPF50+');
    await tester.ensureVisible(spf);
    await tester.pumpAndSettle();
    await tester.tap(spf);
    await tester.pumpAndSettle();

    final (start, end) = dayRangeMs(DateTime.now());
    final today = await tester.runAsync(
      () => (db.select(
        db.usageLogs,
      )..where((u) => u.usedAt.isBetweenValues(start, end - 1))).get(),
    );
    expect(today, hasLength(3));
  });

  testWidgets('shows product alerts', (tester) async {
    await pumpApp(tester, seed: seedDemoData);
    // Sun milk: (44-30)/(95-30) ≈ 22% -> runs out soon, not "low".
    expect(find.text('ควรรู้วันนี้'), findsOneWidget);
  });

  testWidgets('log skin with partial data', (tester) async {
    final semantics = tester.ensureSemantics();
    final db = await pumpApp(tester);

    final cta = find.text('ยังไม่ได้บันทึก แตะเพื่อบันทึกสภาพผิว');
    await tester.scrollUntilVisible(cta, 200);
    await tester.tap(cta);
    await tester.pumpAndSettle();
    expect(find.text('บันทึกสภาพผิว'), findsWidgets);

    await tester.tap(find.bySemanticsLabel('ความมัน 4'));
    await tapVisible(tester, find.widgetWithText(FilterChip, 'นอนน้อย'));
    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();

    final entry = await tester.runAsync(
      () => DailyLogDao(db).loadEntry(toDateKey(DateTime.now())),
    );
    expect(entry!.entry.scoreOil, 4);
    expect(entry.entry.scoreAcne, isNull);
    expect(entry.tagIds, hasLength(1));
    final chip = find.text('ความมัน 4'); // summary chip on Today
    await tester.scrollUntilVisible(chip, 200);
    expect(chip, findsOneWidget);
    semantics.dispose();
  });
}

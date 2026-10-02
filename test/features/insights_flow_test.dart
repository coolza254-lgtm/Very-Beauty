import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

import '../helpers/demo_data.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('day summary from the calendar and tag search', (tester) async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    await pumpApp(
      tester,
      seed: (db) async {
        await seedDemoData(db);
        final entry = await (db.select(
          db.dailyEntries,
        )..where((e) => e.date.equals(toDateKey(yesterday)))).getSingle();
        final tag = await (db.select(
          db.tags,
        )..where((t) => t.name.equals('แสบ'))).getSingle();
        await db
            .into(db.entryTags)
            .insert(
              EntryTagsCompanion.insert(entryId: entry.id, tagId: tag.id),
            );
      },
    );

    await tester.tap(find.text('สรุป'));
    await tester.pumpAndSettle();

    // Yesterday may be in the previous month.
    if (yesterday.month != DateTime.now().month) {
      await tester.tap(find.byIcon(Icons.chevron_left_rounded));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('${yesterday.day}').last);
    await tester.pumpAndSettle();
    expect(find.text('สินค้าที่ใช้'), findsOneWidget);
    expect(find.text('แสบ'), findsOneWidget);
    await tester.tapAt(const Offset(20, 20)); // dismiss sheet
    await tester.pumpAndSettle();

    await tester.tap(find.text('ค้นหา'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'แสบ'));
    await tester.pumpAndSettle();
    expect(find.text('พบ 1 วัน'), findsOneWidget);
    final recent = find.text('ใช้ในช่วง 3 วันก่อน');
    await tester.scrollUntilVisible(
      recent,
      200,
      scrollable: find
          .ancestor(
            of: find.text('พบ 1 วัน'),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(recent, findsOneWidget);
  });
}

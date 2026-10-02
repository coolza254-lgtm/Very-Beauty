import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/insights_dao.dart';
import 'package:very_beauty/core/utils/calculations.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

import '../../helpers/demo_data.dart';
import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late InsightsDao dao;
  final now = DateTime(2026, 10, 15, 9);

  setUp(() async {
    db = createTestDatabase();
    dao = InsightsDao(db);
    await seedDemoData(db, now: now);
  });
  tearDown(() => db.close());

  test('skin trouble index inverts hydration', () {
    expect(skinTroubleIndex(moisture: 5), 1);
    expect(skinTroubleIndex(oil: 4, moisture: 2), 4);
    expect(skinTroubleIndex(), isNull);
  });

  test('month marks combine entries and usage', () async {
    final marks = await dao.loadMonth(DateTime(2026, 10));
    // Demo data logs days 1..30 before "now" (15 Oct): 1–14 Oct are in October.
    expect(marks.keys.where((k) => k.startsWith('2026-10')), hasLength(14));
    final day = marks['2026-10-10']!;
    expect(day.hasEntry, isTrue);
    expect(day.trouble, isNotNull);
    expect(day.usageCount, 6); // 4 morning + 2 evening steps
    expect(marks.containsKey('2026-10-15'), isFalse);
  });

  test('day summary lists products used and tags', () async {
    final entry = await (db.select(
      db.dailyEntries,
    )..where((e) => e.date.equals('2026-10-10'))).getSingle();
    final tag = await (db.select(
      db.tags,
    )..where((t) => t.name.equals('ระคายเคือง'))).getSingle();
    await db
        .into(db.entryTags)
        .insert(EntryTagsCompanion.insert(entryId: entry.id, tagId: tag.id));

    final s = await dao.loadDay('2026-10-10');
    expect(s.entry, isNotNull);
    expect(s.tags.single.name, 'ระคายเคือง');
    final names = s.products.map((p) => p.product.name).toList();
    // Used morning and evening; ties are ordered by name.
    expect(names.take(2), ['Ceramide Barrier Cream', 'Gentle Foam Cleanser']);
    expect(s.products.first.times, 2);
    expect(names, contains('Airy Sun Milk SPF50+'));

    final tagged = await dao.watchTaggedDays(tag.id).first;
    expect(tagged.single.date, '2026-10-10');
    // Look-back covers 7–10 Oct.
    expect(tagged.single.recentProducts.first.times, 8);
  });

  test('chart markers for products started and finished in range', () async {
    final markers = await dao
        .watchMarkers(DateTime(2026, 9, 1), DateTime(2026, 10, 15))
        .first;
    final finished = markers.where((m) => !m.isStart).toList();
    expect(finished.single.product.name, 'Hydrating Toner');
    expect(
      markers.where((m) => m.isStart).map((m) => m.product.name),
      containsAll(['Vitamin C Glow Serum', 'Ceramide Barrier Cream']),
    );
    // Wishlist items never mark the chart.
    expect(
      markers.map((m) => m.product.name),
      isNot(contains('Retinal Night Serum')),
    );
  });

  test(
    'monthly spending uses purchase/opened dates and skips wishlist',
    () async {
      final spending = await dao.watchMonthlySpending(now).first;
      expect(spending, hasLength(6));
      expect(spending.last.month, DateTime(2026, 10));
      final total = spending.fold<double>(0, (s, m) => s + m.total);
      // All demo products except the 1,290 wishlist serum.
      expect(total, 890 + 650 + 450 + 320 + 390);
      // The toner was opened 90 days before 15 Oct → July.
      expect(
        spending.firstWhere((m) => m.month == DateTime(2026, 7)).total,
        390,
      );
      expect(toDateKey(spending.first.month), '2026-05-01');
    },
  );
}

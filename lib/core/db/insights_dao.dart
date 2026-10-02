import 'package:drift/drift.dart';

import '../utils/calculations.dart';
import '../utils/date_utils.dart';
import 'app_database.dart';
import 'tables.dart';

part 'insights_dao.g.dart';

/// Calendar cell data for one day.
class DayMarks {
  const DayMarks({
    this.trouble,
    this.hasEntry = false,
    this.hasPhoto = false,
    this.usageCount = 0,
  });

  /// [skinTroubleIndex] of the day's scores.
  final double? trouble;
  final bool hasEntry;
  final bool hasPhoto;
  final int usageCount;
}

class UsedProduct {
  const UsedProduct({required this.product, required this.times});

  final Product product;
  final int times;
}

class DaySummary {
  const DaySummary({
    required this.date,
    this.entry,
    this.tags = const [],
    this.products = const [],
    this.photos = const [],
  });

  final String date;
  final DailyEntry? entry;
  final List<Tag> tags;
  final List<UsedProduct> products;
  final List<Photo> photos;
}

/// "Started using" / "finished" markers for the score chart.
class ProductMarker {
  const ProductMarker({
    required this.product,
    required this.date,
    required this.isStart,
  });

  final Product product;
  final DateTime date;
  final bool isStart;
}

/// A day carrying a tag, with what was used in the days before it.
class TaggedDay {
  const TaggedDay({required this.date, required this.recentProducts});

  final String date;
  final List<UsedProduct> recentProducts;
}

class MonthSpending {
  const MonthSpending({required this.month, required this.total});

  /// First day of the month.
  final DateTime month;
  final double total;
}

@DriftAccessor(
  tables: [
    DailyEntries,
    EntryTags,
    Tags,
    UsageLogs,
    Products,
    Photos,
    WeightLogs,
  ],
)
class InsightsDao extends DatabaseAccessor<AppDatabase>
    with _$InsightsDaoMixin {
  InsightsDao(super.attachedDatabase);

  late final _all = <TableInfo<Table, dynamic>>[
    dailyEntries,
    entryTags,
    usageLogs,
    products,
    photos,
  ];

  Stream<T> _watch<T>(Future<T> Function() load) =>
      attachedDatabase.watchTables(_all, load);

  // ---- Calendar ----------------------------------------------------------

  Stream<Map<String, DayMarks>> watchMonth(DateTime month) =>
      _watch(() => loadMonth(month));

  Future<Map<String, DayMarks>> loadMonth(DateTime month) async {
    final first = DateTime(month.year, month.month);
    final next = DateTime(month.year, month.month + 1);
    final fromKey = toDateKey(first);
    final toKey = toDateKey(next.subtract(const Duration(days: 1)));

    final entries = await (select(
      dailyEntries,
    )..where((e) => e.date.isBetweenValues(fromKey, toKey))).get();
    final photoEntryIds =
        await (selectOnly(photos, distinct: true)
              ..addColumns([photos.dailyEntryId]))
            .map((r) => r.read(photos.dailyEntryId)!)
            .get()
            .then((l) => l.toSet());
    final usage =
        await (select(usageLogs)..where(
              (u) => u.usedAt.isBetweenValues(
                first.millisecondsSinceEpoch,
                next.millisecondsSinceEpoch - 1,
              ),
            ))
            .get();

    final usageByDay = <String, int>{};
    for (final u in usage) {
      final key = toDateKey(fromEpochMs(u.usedAt));
      usageByDay[key] = (usageByDay[key] ?? 0) + 1;
    }
    final result = <String, DayMarks>{};
    final days = {...entries.map((e) => e.date), ...usageByDay.keys};
    for (final day in days) {
      final e = entries.where((x) => x.date == day).firstOrNull;
      result[day] = DayMarks(
        trouble: e == null
            ? null
            : skinTroubleIndex(
                oil: e.scoreOil,
                moisture: e.scoreMoisture,
                acne: e.scoreAcne,
                redness: e.scoreRedness,
                dullness: e.scoreDullness,
              ),
        hasEntry: e != null,
        hasPhoto: e != null && photoEntryIds.contains(e.id),
        usageCount: usageByDay[day] ?? 0,
      );
    }
    return result;
  }

  Stream<DaySummary> watchDay(String date) => _watch(() => loadDay(date));

  Future<DaySummary> loadDay(String date) async {
    final entry = await (select(
      dailyEntries,
    )..where((e) => e.date.equals(date))).getSingleOrNull();
    final tagList = entry == null
        ? const <Tag>[]
        : await (select(tags).join([
                innerJoin(entryTags, entryTags.tagId.equalsExp(tags.id)),
              ])..where(entryTags.entryId.equals(entry.id)))
              .map((r) => r.readTable(tags))
              .get();
    final photoList = entry == null
        ? const <Photo>[]
        : await (select(photos)
                ..where((p) => p.dailyEntryId.equals(entry.id))
                ..orderBy([(p) => OrderingTerm.asc(p.takenAt)]))
              .get();
    final day = fromDateKey(date);
    return DaySummary(
      date: date,
      entry: entry,
      tags: tagList,
      products: await _usedBetween(day, day),
      photos: photoList,
    );
  }

  // ---- Score chart -------------------------------------------------------

  Stream<List<DailyEntry>> watchEntries(DateTime from, DateTime to) =>
      (select(dailyEntries)
            ..where(
              (e) => e.date.isBetweenValues(toDateKey(from), toDateKey(to)),
            )
            ..orderBy([(e) => OrderingTerm.asc(e.date)]))
          .watch();

  Stream<List<ProductMarker>> watchMarkers(DateTime from, DateTime to) =>
      _watch(() async {
        final all = await select(products).get();
        final start = startOfDay(from);
        final end = DateTime(to.year, to.month, to.day + 1);
        bool inRange(DateTime d) => !d.isBefore(start) && d.isBefore(end);
        final markers = <ProductMarker>[
          for (final p in all) ...[
            if (p.openedDate != null &&
                p.status != ProductStatus.wishlist &&
                inRange(fromEpochMs(p.openedDate!)))
              ProductMarker(
                product: p,
                date: fromEpochMs(p.openedDate!),
                isStart: true,
              ),
            if (p.finishedDate != null && inRange(fromEpochMs(p.finishedDate!)))
              ProductMarker(
                product: p,
                date: fromEpochMs(p.finishedDate!),
                isStart: false,
              ),
          ],
        ]..sort((a, b) => a.date.compareTo(b.date));
        return markers;
      });

  // ---- Search ------------------------------------------------------------

  /// Days carrying [tagId], newest first, each with the products used on
  /// that day and the [lookbackDays] before it.
  Stream<List<TaggedDay>> watchTaggedDays(int tagId, {int lookbackDays = 3}) =>
      _watch(() async {
        final dates =
            await (select(dailyEntries).join([
                    innerJoin(
                      entryTags,
                      entryTags.entryId.equalsExp(dailyEntries.id),
                    ),
                  ])
                  ..where(entryTags.tagId.equals(tagId))
                  ..orderBy([OrderingTerm.desc(dailyEntries.date)]))
                .map((r) => r.readTable(dailyEntries).date)
                .get();
        return [
          for (final d in dates)
            TaggedDay(
              date: d,
              recentProducts: await _usedBetween(
                fromDateKey(d).subtract(Duration(days: lookbackDays)),
                fromDateKey(d),
              ),
            ),
        ];
      });

  // ---- Spending ----------------------------------------------------------

  /// Purchases per month for the [months] months ending with [now]'s month.
  /// A product counts in the month of its purchase date, falling back to
  /// the opened date, then the date it was added. Wishlist items are
  /// excluded.
  Stream<List<MonthSpending>> watchMonthlySpending(
    DateTime now, {
    int months = 6,
  }) => _watch(() async {
    final all =
        await (select(products)..where(
              (p) =>
                  p.price.isNotNull() &
                  p.status
                      .equals(
                        productStatusConverter.toSql(ProductStatus.wishlist),
                      )
                      .not(),
            ))
            .get();
    final totals = <DateTime, double>{
      for (var i = months - 1; i >= 0; i--)
        DateTime(now.year, now.month - i): 0,
    };
    for (final p in all) {
      final d = fromEpochMs(p.purchaseDate ?? p.openedDate ?? p.createdAt);
      final key = DateTime(d.year, d.month);
      if (totals.containsKey(key)) totals[key] = totals[key]! + p.price!;
    }
    return [
      for (final MapEntry(key: month, value: total) in totals.entries)
        MonthSpending(month: month, total: total),
    ];
  });

  Future<List<UsedProduct>> _usedBetween(DateTime from, DateTime to) async {
    final start = startOfDay(from).millisecondsSinceEpoch;
    final end = DateTime(to.year, to.month, to.day + 1).millisecondsSinceEpoch;
    final count = usageLogs.id.count();
    final rows =
        await (select(products).join([
                innerJoin(
                  usageLogs,
                  usageLogs.productId.equalsExp(products.id),
                  useColumns: false,
                ),
              ])
              ..addColumns([count])
              ..where(usageLogs.usedAt.isBetweenValues(start, end - 1))
              ..groupBy([products.id]))
            .get();
    final result =
        [
          for (final r in rows)
            UsedProduct(product: r.readTable(products), times: r.read(count)!),
        ]..sort((a, b) {
          final byTimes = b.times.compareTo(a.times);
          return byTimes != 0
              ? byTimes
              : a.product.name.compareTo(b.product.name);
        });
    return result;
  }
}

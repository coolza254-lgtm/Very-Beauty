import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/utils/calculations.dart';

void main() {
  group('usedGrams', () {
    test('start minus latest', () {
      expect(usedGrams(start: 150, latest: 120), 30);
    });

    test('null when data is missing', () {
      expect(usedGrams(start: null, latest: 120), isNull);
      expect(usedGrams(start: 150, latest: null), isNull);
    });

    test('null (and anomaly) when latest is heavier than start', () {
      expect(usedGrams(start: 100, latest: 105), isNull);
      expect(isWeightAnomaly(start: 100, latest: 105), isTrue);
      expect(isWeightAnomaly(start: 100, latest: 100), isFalse);
      expect(isWeightAnomaly(start: null, latest: 100), isFalse);
    });
  });

  group('remainingPercent', () {
    test('uses empty bottle weight when known (exact)', () {
      // 200 g full, 50 g bottle -> 150 g product; 125 g now -> 75 g left.
      final r = remainingPercent(
        start: 200,
        latest: 125,
        emptyBottle: 50,
        netContent: 150,
      )!;
      expect(r.percent, 50);
      expect(r.isEstimate, isFalse);
    });

    test('falls back to net content as an estimate', () {
      final r = remainingPercent(
        start: 200,
        latest: 170,
        emptyBottle: null,
        netContent: 100,
      )!;
      expect(r.percent, 70);
      expect(r.isEstimate, isTrue);
    });

    test('ml products are always estimates', () {
      final r = remainingPercent(
        start: 200,
        latest: 125,
        emptyBottle: 50,
        netContent: 150,
        isMillilitres: true,
      )!;
      expect(r.isEstimate, isTrue);
    });

    test('clamps to 0–100', () {
      expect(
        remainingPercent(
          start: 200,
          latest: 40,
          emptyBottle: 50,
          netContent: 150,
        )!.percent,
        0,
      );
      expect(
        remainingPercent(
          start: 200,
          latest: 50,
          emptyBottle: null,
          netContent: 100,
        )!.percent,
        0,
      );
    });

    test('null without weights or net content', () {
      expect(
        remainingPercent(
          start: null,
          latest: null,
          emptyBottle: null,
          netContent: 100,
        ),
        isNull,
      );
      expect(
        remainingPercent(
          start: 200,
          latest: 180,
          emptyBottle: null,
          netContent: null,
        ),
        isNull,
      );
    });

    test('ignores an empty weight that is not lighter than start', () {
      final r = remainingPercent(
        start: 50,
        latest: 45,
        emptyBottle: 60,
        netContent: 50,
      )!;
      expect(r.isEstimate, isTrue);
      expect(r.percent, 90);
    });
  });

  group('remainingGrams', () {
    test('prefers empty bottle weight', () {
      expect(
        remainingGrams(latest: 80, emptyBottle: 30, netContent: 100, used: 5),
        50,
      );
    });

    test('falls back to net content minus used', () {
      expect(
        remainingGrams(
          latest: 80,
          emptyBottle: null,
          netContent: 100,
          used: 20,
        ),
        80,
      );
    });

    test('never negative', () {
      expect(
        remainingGrams(latest: 20, emptyBottle: 30, netContent: 100, used: 5),
        0,
      );
    });
  });

  group('dailyUsage', () {
    test('used divided by days', () {
      expect(
        dailyUsage(
          used: 30,
          from: DateTime(2026, 1, 1),
          to: DateTime(2026, 1, 11),
        ),
        3,
      );
    });

    test('null with less than a day or nothing used', () {
      expect(
        dailyUsage(
          used: 5,
          from: DateTime(2026, 1, 1, 8),
          to: DateTime(2026, 1, 1, 20),
        ),
        isNull,
      );
      expect(
        dailyUsage(
          used: 0,
          from: DateTime(2026, 1, 1),
          to: DateTime(2026, 2, 1),
        ),
        isNull,
      );
      expect(dailyUsage(used: 5, from: null, to: DateTime(2026)), isNull);
    });
  });

  group('predictedEmptyDate', () {
    test('last weighing + remaining / rate', () {
      expect(
        predictedEmptyDate(
          remaining: 30,
          perDay: 3,
          lastWeighed: DateTime(2026, 1, 11, 21),
        ),
        DateTime(2026, 1, 21),
      );
    });

    test('null when the rate is unknown', () {
      expect(
        predictedEmptyDate(
          remaining: 30,
          perDay: null,
          lastWeighed: DateTime(2026),
        ),
        isNull,
      );
      expect(
        predictedEmptyDate(
          remaining: 30,
          perDay: 0,
          lastWeighed: DateTime(2026),
        ),
        isNull,
      );
    });
  });

  group('money', () {
    test('price per unit', () {
      expect(pricePerUnit(price: 590, netContent: 50), 11.8);
      expect(pricePerUnit(price: null, netContent: 50), isNull);
      expect(pricePerUnit(price: 590, netContent: 0), isNull);
    });

    test('cost used is proportional and capped at price', () {
      expect(costUsed(price: 600, netContent: 60, used: 15), 150);
      expect(costUsed(price: 600, netContent: 60, used: 90), 600);
      expect(costUsed(price: null, netContent: 60, used: 15), isNull);
      expect(costUsed(price: 600, netContent: 60, used: null), isNull);
    });

    test('cost per use', () {
      expect(costPerUse(costUsed: 150, usageCount: 30), 5);
      expect(costPerUse(costUsed: 150, usageCount: 0), isNull);
      expect(costPerUse(costUsed: null, usageCount: 3), isNull);
    });
  });

  test('average skips nulls', () {
    expect(average([3, null, 5]), 4);
    expect(average([null, null]), isNull);
    expect(average(const []), isNull);
  });

  group('dates', () {
    test('addMonths clamps to month end', () {
      expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
      expect(addMonths(DateTime(2026, 11, 15), 3), DateTime(2027, 2, 15));
      expect(addMonths(DateTime(2024, 1, 31), 1), DateTime(2024, 2, 29));
    });

    test('effective expiry is the earlier of label and PAO', () {
      final opened = DateTime(2026, 1, 1);
      expect(
        effectiveExpiry(
          expiryDate: DateTime(2028),
          openedDate: opened,
          paoMonths: 12,
        ),
        DateTime(2027, 1, 1),
      );
      expect(
        effectiveExpiry(
          expiryDate: DateTime(2026, 3, 1),
          openedDate: opened,
          paoMonths: 12,
        ),
        DateTime(2026, 3, 1),
      );
      expect(
        effectiveExpiry(expiryDate: null, openedDate: null, paoMonths: 6),
        isNull,
      );
    });
  });

  group('computeProductMetrics', () {
    test('full data', () {
      final m = computeProductMetrics(
        ProductInputs(
          price: 900,
          netContent: 30,
          startWeight: 80,
          emptyBottleWeight: 50,
          openedDate: DateTime(2026, 1, 1),
          weighings: [
            WeighPoint(DateTime(2026, 1, 11), 70),
            WeighPoint(DateTime(2026, 1, 1), 80),
          ],
          usageCount: 20,
        ),
      );
      expect(m.usedGrams, 10);
      expect(m.remainingGrams, 20);
      expect(m.remaining!.percent, closeTo(66.67, 0.01));
      expect(m.remaining!.isEstimate, isFalse);
      expect(m.dailyUsage, 1);
      expect(m.predictedEmpty, DateTime(2026, 1, 31));
      expect(m.pricePerUnit, 30);
      expect(m.costUsed, 300);
      expect(m.costPerUse, 15);
      expect(m.latestWeight, 70);
      expect(m.weightAnomaly, isFalse);
    });

    test('only price and net content', () {
      final m = computeProductMetrics(
        const ProductInputs(price: 300, netContent: 100),
      );
      expect(m.pricePerUnit, 3);
      expect(m.usedGrams, isNull);
      expect(m.remaining, isNull);
      expect(m.predictedEmpty, isNull);
      expect(m.costPerUse, isNull);
    });

    test('no price, no weights', () {
      final m = computeProductMetrics(const ProductInputs());
      expect(m.pricePerUnit, isNull);
      expect(m.costUsed, isNull);
      expect(m.remaining, isNull);
    });

    test('weighed once: start comes from the first log, nothing used yet', () {
      final m = computeProductMetrics(
        ProductInputs(
          netContent: 50,
          weighings: [WeighPoint(DateTime(2026, 2, 1), 120)],
        ),
      );
      expect(m.usedGrams, 0);
      expect(m.remaining!.percent, 100);
      expect(m.dailyUsage, isNull);
      expect(m.predictedEmpty, isNull);
    });

    test('latest heavier than start is flagged', () {
      final m = computeProductMetrics(
        ProductInputs(
          price: 100,
          netContent: 50,
          startWeight: 100,
          weighings: [WeighPoint(DateTime(2026, 2, 1), 110)],
        ),
      );
      expect(m.weightAnomaly, isTrue);
      expect(m.usedGrams, isNull);
      expect(m.costUsed, isNull);
    });

    test('ml product is an estimate', () {
      final m = computeProductMetrics(
        ProductInputs(
          price: 250,
          netContent: 100,
          isMillilitres: true,
          openedDate: DateTime(2026, 3, 1),
          weighings: [
            WeighPoint(DateTime(2026, 3, 1), 180),
            WeighPoint(DateTime(2026, 3, 21), 140),
          ],
        ),
      );
      expect(m.usedGrams, 40);
      expect(m.remaining!.percent, 60);
      expect(m.remaining!.isEstimate, isTrue);
      expect(m.dailyUsage, 2);
      expect(m.predictedEmpty, DateTime(2026, 4, 20));
      expect(m.pricePerUnit, 2.5);
      expect(m.costUsed, 100);
    });
  });
}

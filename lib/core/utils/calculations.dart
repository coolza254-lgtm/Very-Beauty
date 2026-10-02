/// Product value and usage formulas from docs/SPEC.md §6.
///
/// Everything here is a pure function so it can be unit tested without a
/// database. Weights are grams including the container. Products measured in
/// millilitres are converted assuming a density of 1 g/ml, so results for them
/// are always flagged as estimates.
library;

import 'date_utils.dart';

/// One weighing of a product.
class WeighPoint {
  const WeighPoint(this.at, this.grams);

  final DateTime at;
  final double grams;
}

/// Grams used so far: `start − latest`. Returns null when either is unknown
/// or when the latest weight is heavier than the start (a weighing mistake,
/// see [isWeightAnomaly]).
double? usedGrams({required double? start, required double? latest}) {
  if (start == null || latest == null) return null;
  final used = start - latest;
  if (used < 0) return null;
  return used;
}

/// True when the latest weighing is heavier than the starting weight, which
/// almost always means a weighing mistake the user should be warned about.
bool isWeightAnomaly({required double? start, required double? latest}) =>
    start != null && latest != null && latest > start;

/// Grams of product left. Uses the empty-container weight when known,
/// otherwise `netContent − used`.
double? remainingGrams({
  required double? latest,
  required double? emptyBottle,
  required double? netContent,
  required double? used,
}) {
  if (latest != null && emptyBottle != null) {
    return _atLeastZero(latest - emptyBottle);
  }
  if (netContent != null && used != null) {
    return _atLeastZero(netContent - used);
  }
  return null;
}

/// Result of [remainingPercent].
class RemainingPercent {
  const RemainingPercent(this.percent, {required this.isEstimate});

  /// 0–100.
  final double percent;

  /// True when derived from the label's net content instead of the empty
  /// container weight (shown to the user as "ประมาณ").
  final bool isEstimate;
}

/// Percentage left.
///
/// - With the empty-container weight:
///   `(latest − empty) ÷ (start − empty) × 100`
/// - Otherwise from the label: `(netContent − used) ÷ netContent × 100`,
///   flagged as an estimate.
RemainingPercent? remainingPercent({
  required double? start,
  required double? latest,
  required double? emptyBottle,
  required double? netContent,
  bool isMillilitres = false,
}) {
  if (start != null && latest != null && emptyBottle != null) {
    final full = start - emptyBottle;
    if (full > 0) {
      return RemainingPercent(
        _clampPercent((latest - emptyBottle) / full * 100),
        isEstimate: isMillilitres,
      );
    }
  }
  final used = usedGrams(start: start, latest: latest);
  if (used != null && netContent != null && netContent > 0) {
    return RemainingPercent(
      _clampPercent((netContent - used) / netContent * 100),
      isEstimate: true,
    );
  }
  return null;
}

/// Average grams used per day between [from] and [to]. Null when there is
/// less than one day of data or nothing has been used yet.
double? dailyUsage({
  required double? used,
  required DateTime? from,
  required DateTime? to,
}) {
  if (used == null || used <= 0 || from == null || to == null) return null;
  final days = daysBetween(from, to);
  if (days < 1) return null;
  return used / days;
}

/// Date the product is expected to run out: the latest weighing date plus
/// `remaining ÷ dailyUsage` days. Null means "not enough data yet".
///
/// The projection starts from the latest weighing rather than today because
/// the remaining amount was measured then.
DateTime? predictedEmptyDate({
  required double? remaining,
  required double? perDay,
  required DateTime? lastWeighed,
}) {
  if (remaining == null || perDay == null || perDay <= 0) return null;
  if (lastWeighed == null) return null;
  final days = (remaining / perDay).round();
  final base = DateTime(lastWeighed.year, lastWeighed.month, lastWeighed.day);
  return DateTime(base.year, base.month, base.day + days);
}

/// Label price per gram (or per ml): `price ÷ netContent`.
double? pricePerUnit({required double? price, required double? netContent}) {
  if (price == null || netContent == null || netContent <= 0) return null;
  return price / netContent;
}

/// Cost of the product used so far: `price × (used ÷ netContent)`, capped at
/// the full price.
double? costUsed({
  required double? price,
  required double? netContent,
  required double? used,
}) {
  if (price == null || netContent == null || netContent <= 0 || used == null) {
    return null;
  }
  final cost = price * (used / netContent);
  return cost > price ? price : cost;
}

/// Approximate cost per application: `costUsed ÷ number of usage logs`.
double? costPerUse({required double? costUsed, required int usageCount}) {
  if (costUsed == null || usageCount <= 0) return null;
  return costUsed / usageCount;
}

/// Mean of the non-null values, or null if there are none.
double? average(Iterable<int?> values) {
  var sum = 0;
  var count = 0;
  for (final v in values) {
    if (v == null) continue;
    sum += v;
    count++;
  }
  return count == 0 ? null : sum / count;
}

/// Adds calendar months, clamping the day to the end of the target month
/// (e.g. 31 Jan + 1 month = 28/29 Feb).
DateTime addMonths(DateTime date, int months) {
  final monthIndex = date.month - 1 + months;
  final year = date.year + (monthIndex / 12).floor();
  final month = monthIndex % 12 + 1;
  final lastDay = DateTime(year, month + 1, 0).day;
  return DateTime(
    year,
    month,
    date.day > lastDay ? lastDay : date.day,
    date.hour,
    date.minute,
  );
}

/// The earlier of the printed expiry date and `opened + PAO months`.
DateTime? effectiveExpiry({
  required DateTime? expiryDate,
  required DateTime? openedDate,
  required int? paoMonths,
}) {
  final pao = openedDate != null && paoMonths != null && paoMonths > 0
      ? addMonths(openedDate, paoMonths)
      : null;
  if (pao == null) return expiryDate;
  if (expiryDate == null) return pao;
  return pao.isBefore(expiryDate) ? pao : expiryDate;
}

/// Everything needed to compute [ProductMetrics].
class ProductInputs {
  const ProductInputs({
    this.price,
    this.netContent,
    this.isMillilitres = false,
    this.startWeight,
    this.emptyBottleWeight,
    this.openedDate,
    this.weighings = const [],
    this.usageCount = 0,
  });

  final double? price;
  final double? netContent;
  final bool isMillilitres;

  /// `products.start_weight`; falls back to the first weighing.
  final double? startWeight;
  final double? emptyBottleWeight;

  /// Falls back to the first weighing date.
  final DateTime? openedDate;

  /// Any order; sorted internally.
  final List<WeighPoint> weighings;
  final int usageCount;
}

/// All derived numbers shown on the product detail screen.
class ProductMetrics {
  const ProductMetrics({
    this.usedGrams,
    this.remainingGrams,
    this.remaining,
    this.dailyUsage,
    this.predictedEmpty,
    this.pricePerUnit,
    this.costUsed,
    this.costPerUse,
    this.latestWeight,
    this.lastWeighedAt,
    this.weightAnomaly = false,
  });

  final double? usedGrams;
  final double? remainingGrams;
  final RemainingPercent? remaining;
  final double? dailyUsage;
  final DateTime? predictedEmpty;
  final double? pricePerUnit;
  final double? costUsed;
  final double? costPerUse;
  final double? latestWeight;
  final DateTime? lastWeighedAt;
  final bool weightAnomaly;
}

ProductMetrics computeProductMetrics(ProductInputs input) {
  final weighings = [...input.weighings]..sort((a, b) => a.at.compareTo(b.at));
  final first = weighings.isEmpty ? null : weighings.first;
  final latest = weighings.isEmpty ? null : weighings.last;

  final start = input.startWeight ?? first?.grams;
  final startDate = input.openedDate ?? first?.at;
  final latestGrams = latest?.grams;

  final used = usedGrams(start: start, latest: latestGrams);
  final remaining = remainingGrams(
    latest: latestGrams,
    emptyBottle: input.emptyBottleWeight,
    netContent: input.netContent,
    used: used,
  );
  final perDay = dailyUsage(used: used, from: startDate, to: latest?.at);
  final cost = costUsed(
    price: input.price,
    netContent: input.netContent,
    used: used,
  );

  return ProductMetrics(
    usedGrams: used,
    remainingGrams: remaining,
    remaining: remainingPercent(
      start: start,
      latest: latestGrams,
      emptyBottle: input.emptyBottleWeight,
      netContent: input.netContent,
      isMillilitres: input.isMillilitres,
    ),
    dailyUsage: perDay,
    predictedEmpty: predictedEmptyDate(
      remaining: remaining,
      perDay: perDay,
      lastWeighed: latest?.at,
    ),
    pricePerUnit: pricePerUnit(
      price: input.price,
      netContent: input.netContent,
    ),
    costUsed: cost,
    costPerUse: costPerUse(costUsed: cost, usageCount: input.usageCount),
    latestWeight: latestGrams,
    lastWeighedAt: latest?.at,
    weightAnomaly: isWeightAnomaly(start: start, latest: latestGrams),
  );
}

double _atLeastZero(double v) => v < 0 ? 0 : v;

double _clampPercent(double v) => v.clamp(0, 100).toDouble();

/// One number for "how is my skin" on a day, 1 (calm) to 5 (troubled), used
/// to colour the calendar. Oiliness, breakouts, redness and dullness count
/// as they are; hydration is inverted (more hydrated = calmer). Null when no
/// score was logged.
double? skinTroubleIndex({
  int? oil,
  int? moisture,
  int? acne,
  int? redness,
  int? dullness,
}) => average([
  oil,
  moisture == null ? null : 6 - moisture,
  acne,
  redness,
  dullness,
]);

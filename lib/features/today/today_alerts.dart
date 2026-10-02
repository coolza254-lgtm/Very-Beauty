import '../../core/db/app_database.dart';
import '../../core/db/products_dao.dart';
import '../../core/utils/calculations.dart';
import '../../core/utils/date_utils.dart';

enum AlertKind { low, emptySoon, expired, expiring, weighDue }

class TodayAlert {
  const TodayAlert({
    required this.kind,
    required this.product,
    this.date,
    this.percent,
    this.days,
  });

  final AlertKind kind;
  final Product product;
  final DateTime? date;
  final double? percent;
  final int? days;
}

/// Products running low, expiring, or due for a weighing (docs/SPEC.md §7.1).
List<TodayAlert> computeTodayAlerts(
  List<ProductWithMetrics> products, {
  required DateTime now,
  int weighDueDays = 14,
  int lowPercent = 15,
  int emptySoonDays = 7,
  int expiringDays = 30,
}) {
  final today = startOfDay(now);
  final alerts = <TodayAlert>[];
  for (final item in products) {
    final p = item.product;
    final m = item.metrics;
    final inUse = p.status == ProductStatus.inUse;
    if (inUse) {
      final remaining = m.remaining?.percent;
      if (remaining != null && remaining <= lowPercent) {
        alerts.add(
          TodayAlert(kind: AlertKind.low, product: p, percent: remaining),
        );
      } else if (m.predictedEmpty != null &&
          daysBetween(today, m.predictedEmpty!) <= emptySoonDays) {
        alerts.add(
          TodayAlert(
            kind: AlertKind.emptySoon,
            product: p,
            date: m.predictedEmpty,
          ),
        );
      }
    }
    if (inUse || p.status == ProductStatus.paused) {
      final expiry = effectiveExpiry(
        expiryDate: p.expiryDate == null ? null : fromEpochMs(p.expiryDate!),
        openedDate: p.openedDate == null ? null : fromEpochMs(p.openedDate!),
        paoMonths: p.paoMonths,
      );
      if (expiry != null) {
        final days = daysBetween(today, expiry);
        if (days < 0) {
          alerts.add(
            TodayAlert(kind: AlertKind.expired, product: p, date: expiry),
          );
        } else if (days <= expiringDays) {
          alerts.add(
            TodayAlert(kind: AlertKind.expiring, product: p, date: expiry),
          );
        }
      }
    }
    if (inUse && m.lastWeighedAt != null) {
      final since = daysBetween(m.lastWeighedAt!, today);
      if (since >= weighDueDays) {
        alerts.add(
          TodayAlert(kind: AlertKind.weighDue, product: p, days: since),
        );
      }
    }
  }
  alerts.sort((a, b) => a.kind.index.compareTo(b.kind.index));
  return alerts;
}

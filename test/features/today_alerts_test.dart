import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';
import 'package:very_beauty/core/utils/calculations.dart';
import 'package:very_beauty/features/today/today_alerts.dart';

final _now = DateTime(2026, 10, 2, 9);

ProductWithMetrics _item({
  ProductStatus status = ProductStatus.inUse,
  ProductMetrics metrics = const ProductMetrics(),
  DateTime? expiry,
  DateTime? opened,
  int? pao,
}) => ProductWithMetrics(
  product: Product(
    id: 1,
    createdAt: 0,
    updatedAt: 0,
    name: 'P',
    category: ProductCategory.serum,
    netUnit: NetUnit.g,
    status: status,
    expiryDate: expiry?.millisecondsSinceEpoch,
    openedDate: opened?.millisecondsSinceEpoch,
    paoMonths: pao,
  ),
  metrics: metrics,
  usageCount: 0,
);

List<AlertKind> _kinds(ProductWithMetrics item) =>
    computeTodayAlerts([item], now: _now).map((a) => a.kind).toList();

void main() {
  test('low stock', () {
    expect(
      _kinds(
        _item(
          metrics: const ProductMetrics(
            remaining: RemainingPercent(10, isEstimate: true),
          ),
        ),
      ),
      [AlertKind.low],
    );
  });

  test('runs out within a week', () {
    expect(
      _kinds(
        _item(metrics: ProductMetrics(predictedEmpty: DateTime(2026, 10, 6))),
      ),
      [AlertKind.emptySoon],
    );
    expect(
      _kinds(
        _item(metrics: ProductMetrics(predictedEmpty: DateTime(2026, 11, 6))),
      ),
      isEmpty,
    );
  });

  test('expired and expiring, including PAO', () {
    expect(_kinds(_item(expiry: DateTime(2026, 9, 30))), [AlertKind.expired]);
    expect(_kinds(_item(expiry: DateTime(2026, 10, 20))), [AlertKind.expiring]);
    expect(_kinds(_item(opened: DateTime(2026, 4, 20), pao: 6)), [
      AlertKind.expiring,
    ]);
    expect(_kinds(_item(expiry: DateTime(2027, 6, 1))), isEmpty);
  });

  test('weighing due after 14 days', () {
    expect(
      _kinds(
        _item(metrics: ProductMetrics(lastWeighedAt: DateTime(2026, 9, 10))),
      ),
      [AlertKind.weighDue],
    );
    expect(
      _kinds(
        _item(metrics: ProductMetrics(lastWeighedAt: DateTime(2026, 9, 25))),
      ),
      isEmpty,
    );
  });

  test('finished and wishlist products never alert', () {
    for (final s in [ProductStatus.finished, ProductStatus.wishlist]) {
      expect(
        _kinds(
          _item(
            status: s,
            expiry: DateTime(2026, 9, 1),
            metrics: const ProductMetrics(
              remaining: RemainingPercent(5, isEstimate: false),
            ),
          ),
        ),
        isEmpty,
      );
    }
  });
}

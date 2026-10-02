import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/utils/formatters.dart';
import '../products/product_providers.dart';
import '../products/widgets/product_widgets.dart';
import 'insights_providers.dart';

/// Monthly spending and value per product (docs/SPEC.md §7.6).
class SpendingTab extends ConsumerWidget {
  const SpendingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final months = ref.watch(monthlySpendingProvider).value ?? const [];
    final products =
        (ref.watch(productsProvider).value ?? const [])
            .where(
              (p) =>
                  p.product.status != ProductStatus.wishlist &&
                  p.product.price != null,
            )
            .toList()
          ..sort((a, b) {
            final ca = a.metrics.costPerUse;
            final cb = b.metrics.costPerUse;
            if (ca == null && cb == null) return 0;
            if (ca == null) return 1;
            if (cb == null) return -1;
            return ca.compareTo(cb);
          });

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.spendingNoProducts,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    final thisMonth = months.isEmpty ? 0.0 : months.last.total;
    final sixMonths = months.fold<double>(0, (s, m) => s + m.total);
    final maxY = months.fold<double>(0, (m, x) => x.total > m ? x.total : m);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        Row(
          children: [
            Expanded(
              child: StatTile(
                label: l10n.spendingThisMonth,
                value: formatBaht(thisMonth),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                label: l10n.spendingSixMonths,
                value: formatBaht(sixMonths),
              ),
            ),
          ],
        ),
        SectionTitle(l10n.spendingPerMonth),
        SoftCard(
          padding: const EdgeInsets.fromLTRB(12, 20, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                child: BarChart(
                  BarChartData(
                    maxY: maxY <= 0 ? 100 : maxY * 1.2,
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) =>
                          FlLine(color: scheme.outlineVariant, strokeWidth: 1),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                      leftTitles: const AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (v, meta) => SideTitleWidget(
                            meta: meta,
                            child: Text(
                              DateFormat.MMM(locale)
                                  .format(months[v.toInt()].month),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => scheme.onSurface,
                        getTooltipItem: (group, _, rod, _) => BarTooltipItem(
                          formatBaht(rod.toY),
                          TextStyle(color: scheme.surface),
                        ),
                      ),
                    ),
                    barGroups: [
                      for (final (i, m) in months.indexed)
                        BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: m.total,
                              width: 22,
                              color: i == months.length - 1
                                  ? scheme.primary
                                  : scheme.primary.withValues(alpha: 0.45),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(l10n.spendingNote, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        SectionTitle(l10n.spendingValue),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(l10n.spendingValueHint, style: theme.textTheme.bodySmall),
        ),
        SoftCard(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              for (final p in products)
                ListTile(
                  leading: CategoryBadge(
                    category: p.product.category,
                    size: 40,
                  ),
                  title: Text(
                    p.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    [
                      formatBaht(p.product.price!),
                      if (p.metrics.pricePerUnit != null)
                        l10n.perUnitShort(
                          formatNumber(p.metrics.pricePerUnit!),
                          l10n.unit(p.product.netUnit),
                        ),
                      if (p.product.rating != null) '★ ${p.product.rating}',
                    ].join(' · '),
                  ),
                  trailing: Text(
                    p.metrics.costPerUse == null
                        ? '–'
                        : l10n.perUseShort(formatBaht(p.metrics.costPerUse!)),
                    style: theme.textTheme.titleSmall,
                  ),
                  onTap: () =>
                      context.push(AppRoutes.productDetail(p.product.id)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/theme.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/insights_dao.dart';
import '../../core/utils/current_day.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'insights_providers.dart';

/// Skin score over time with vertical markers where a product was started
/// or finished (docs/SPEC.md §7.6).
class ChartTab extends ConsumerWidget {
  const ChartTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final days = ref.watch(chartRangeProvider);
    final score = ref.watch(chartScoreProvider);
    final today = ref.watch(currentDayProvider);
    final from = DateTime(today.year, today.month, today.day - days + 1);
    final range = (from, today);
    final entries = ref.watch(chartEntriesProvider(range)).value ?? const [];
    final markers = ref.watch(chartMarkersProvider(range)).value ?? const [];

    final spots = [
      for (final e in entries)
        if (score.of(e) != null)
          FlSpot(
            daysBetween(from, fromDateKey(e.date)).toDouble(),
            score.of(e)!.toDouble(),
          ),
    ];
    double x(DateTime d) => daysBetween(from, d).toDouble();
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 10,
      color: scheme.onSurfaceVariant,
    );
    const startColor = Color(0xFF7FBF8E);
    final endColor = scheme.primary;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in SkinScore.values)
              ChoiceChip(
                label: Text(s.label(l10n)),
                selected: s == score,
                showCheckmark: false,
                onSelected: (_) => ref.read(chartScoreProvider.notifier).set(s),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: 30, label: Text(l10n.chartRange30)),
            ButtonSegment(value: 90, label: Text(l10n.chartRange90)),
            ButtonSegment(value: 180, label: Text(l10n.chartRange180)),
          ],
          selected: {days},
          onSelectionChanged: (s) =>
              ref.read(chartRangeProvider.notifier).set(s.single),
        ),
        const SizedBox(height: 16),
        SoftCard(
          padding: const EdgeInsets.fromLTRB(8, 20, 28, 8),
          child: spots.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    l10n.chartEmpty,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              : SizedBox(
                  height: 220,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (days - 1).toDouble(),
                      minY: 0.5,
                      maxY: 5.5,
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: scheme.outlineVariant,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      extraLinesData: ExtraLinesData(
                        verticalLines: [
                          for (final m in markers)
                            VerticalLine(
                              x: x(m.date),
                              color: m.isStart ? startColor : endColor,
                              strokeWidth: 1.5,
                              dashArray: [4, 4],
                            ),
                        ],
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 28,
                            getTitlesWidget: (v, meta) =>
                                v % 1 == 0 && v >= 1 && v <= 5
                                ? SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      '${v.toInt()}',
                                      style: labelStyle,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 26,
                            interval: (days - 1) / 2,
                            getTitlesWidget: (v, meta) => SideTitleWidget(
                              meta: meta,
                              child: Text(
                                formatShortDate(
                                  from.add(Duration(days: v.round())),
                                  locale,
                                ),
                                style: labelStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (_) => scheme.onSurface,
                          getTooltipItems: (touched) => [
                            for (final s in touched)
                              LineTooltipItem(
                                '${formatShortDate(from.add(Duration(days: s.x.round())), locale)}\n${s.y.toInt()}',
                                TextStyle(color: scheme.surface, fontSize: 12),
                              ),
                          ],
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          curveSmoothness: 0.25,
                          preventCurveOverShooting: true,
                          color: scheme.primary,
                          barWidth: 2.5,
                          dotData: FlDotData(show: spots.length <= 45),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                scheme.primary.withValues(alpha: 0.2),
                                scheme.primary.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        if (markers.isNotEmpty) ...[
          SectionTitle(l10n.chartMarkers),
          SoftCard(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                for (final m in markers)
                  _MarkerRow(
                    marker: m,
                    color: m.isStart ? startColor : endColor,
                    locale: locale,
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MarkerRow extends StatelessWidget {
  const _MarkerRow({
    required this.marker,
    required this.color,
    required this.locale,
  });

  final ProductMarker marker;
  final Color color;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      dense: true,
      leading: PastelIconBadge(
        icon: marker.isStart
            ? Icons.play_arrow_rounded
            : Icons.check_circle_outline_rounded,
        color: marker.isStart ? BrandColors.mint : BrandColors.blush,
        size: 32,
      ),
      title: Text(
        marker.isStart
            ? l10n.chartMarkerStart(marker.product.name)
            : l10n.chartMarkerEnd(marker.product.name),
      ),
      trailing: Text(
        formatShortDate(marker.date, locale),
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

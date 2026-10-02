import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/db/app_database.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/formatters.dart';

/// Line chart of weighings over time (x = days since the first weighing).
class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.weighings});

  /// Oldest first; needs at least two points.
  final List<WeightLog> weighings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final first = fromEpochMs(weighings.first.weighedAt);
    final spots = [
      for (final w in weighings)
        FlSpot(
          fromEpochMs(w.weighedAt).difference(first).inHours / 24,
          w.weight,
        ),
    ];
    final ys = spots.map((s) => s.y);
    final minY = ys.reduce((a, b) => a < b ? a : b);
    final maxY = ys.reduce((a, b) => a > b ? a : b);
    final pad = ((maxY - minY) * 0.2).clamp(2, double.infinity).toDouble();
    final maxX = spots.last.x <= 0 ? 1.0 : spots.last.x;
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
      fontSize: 10,
    );

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: maxX,
          minY: (minY - pad).clamp(0, double.infinity).toDouble(),
          maxY: maxY + pad,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: scheme.outlineVariant, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (v, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(formatNumber(v.round()), style: labelStyle),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: maxX,
                getTitlesWidget: (v, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(
                    formatShortDate(
                      first.add(Duration(hours: (v * 24).round())),
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
              getTooltipItems: (spots) => [
                for (final s in spots)
                  LineTooltipItem(
                    '${formatNumber(s.y)} g',
                    TextStyle(color: scheme.surface, fontSize: 12),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: spots.length > 2,
              preventCurveOverShooting: true,
              color: scheme.primary,
              barWidth: 3,
              dotData: FlDotData(
                getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                  radius: 4,
                  color: scheme.surfaceContainerLowest,
                  strokeWidth: 2.5,
                  strokeColor: scheme.primary,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.primary.withValues(alpha: 0.25),
                    scheme.primary.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

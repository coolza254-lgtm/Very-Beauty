import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/router.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/insights_dao.dart';
import '../../core/storage/app_paths.dart';
import '../../core/utils/current_day.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/thai_date.dart';
import '../products/widgets/product_widgets.dart';
import 'insights_providers.dart';

class CalendarTab extends ConsumerWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final month = ref.watch(calendarMonthProvider);
    final today = ref.watch(currentDayProvider);
    final marks = ref.watch(monthMarksProvider(month)).value ?? const {};
    final notifier = ref.read(calendarMonthProvider.notifier);

    final monthLabel =
        '${DateFormat.MMMM(locale).format(month)} '
        '${locale.startsWith('th') ? month.year + 543 : month.year}';
    // Sunday-first grid.
    final leading = DateTime(month.year, month.month).weekday % 7;
    final days = DateTime(month.year, month.month + 1, 0).day;
    final weekdays = [
      for (var i = 0; i < 7; i++)
        DateFormat.E(locale).format(DateTime(2026, 1, 4 + i)),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        SoftCard(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () =>
                        notifier.set(DateTime(month.year, month.month - 1)),
                  ),
                  Expanded(
                    child: Text(
                      monthLabel,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: () =>
                        notifier.set(DateTime(month.year, month.month + 1)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  for (final w in weekdays)
                    Expanded(
                      child: Text(
                        w,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.82,
                children: [
                  for (var i = 0; i < leading; i++) const SizedBox(),
                  for (var d = 1; d <= days; d++)
                    _DayCell(
                      day: DateTime(month.year, month.month, d),
                      marks:
                          marks[toDateKey(
                            DateTime(month.year, month.month, d),
                          )],
                      isToday: DateTime(month.year, month.month, d) == today,
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _Legend(color: troubleColor(1), label: l10n.calendarLegendCalm),
            _Legend(color: troubleColor(5), label: l10n.calendarLegendTroubled),
            _LegendIcon(
              icon: Icons.photo_camera_rounded,
              label: l10n.calendarLegendPhoto,
            ),
            _Legend(
              color: scheme.secondary,
              label: l10n.calendarLegendUsage,
              small: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day, this.marks, required this.isToday});

  final DateTime day;
  final DayMarks? marks;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final m = marks;
    final trouble = m?.trouble;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => showDaySummary(context, toDateKey(day)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: trouble == null
                  ? null
                  : troubleColor(trouble).withValues(alpha: 0.85),
              border: isToday
                  ? Border.all(color: scheme.primary, width: 2)
                  : null,
            ),
            child: Text(
              '${day.day}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface,
                fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (m?.hasPhoto ?? false)
                  Icon(
                    Icons.photo_camera_rounded,
                    size: 10,
                    color: scheme.primary,
                  ),
                if ((m?.usageCount ?? 0) > 0) ...[
                  const SizedBox(width: 2),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: scheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label, this.small = false});

  final Color color;
  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: small ? 6 : 12,
        height: small ? 6 : 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

class _LegendIcon extends StatelessWidget {
  const _LegendIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 12, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: 6),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

/// Bottom sheet with everything logged on one day.
Future<void> showDaySummary(BuildContext context, String date) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _DaySummarySheet(date: date),
    );

class _DaySummarySheet extends ConsumerWidget {
  const _DaySummarySheet({required this.date});

  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final summary = ref.watch(daySummaryProvider(date)).value;
    final paths = ref.watch(appPathsProvider).value;
    final e = summary?.entry;
    final scores = e == null
        ? const <(String, int)>[]
        : [
            for (final s in SkinScore.values)
              if (s.of(e) != null) (s.label(l10n), s.of(e)!),
          ];

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
        children: [
          Text(
            formatLongDate(fromDateKey(date), locale),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (summary == null)
            const Center(child: CircularProgressIndicator())
          else ...[
            if (scores.isEmpty && summary.tags.isEmpty && e?.note == null)
              Text(l10n.daySummaryNoLog, style: theme.textTheme.bodyMedium)
            else
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final (label, v) in scores)
                    Chip(
                      label: Text('$label $v'),
                      visualDensity: VisualDensity.compact,
                    ),
                  for (final t in summary.tags)
                    Chip(
                      avatar: const Icon(Icons.sell_outlined, size: 16),
                      label: Text(t.name),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            if (e?.note != null) ...[
              const SizedBox(height: 8),
              Text(e!.note!, style: theme.textTheme.bodyLarge),
            ],
            if (summary.photos.isNotEmpty && paths != null) ...[
              SectionTitle(l10n.daySummaryPhotos),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: summary.photos.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () =>
                        context.push(AppRoutes.photoView(summary.photos[i].id)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        File(paths.resolve(summary.photos[i].thumbPath)),
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover,
                        cacheWidth: 270,
                        errorBuilder: (_, _, _) =>
                            const SizedBox(width: 90, height: 120),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            SectionTitle(l10n.daySummaryProducts),
            if (summary.products.isEmpty)
              Text(l10n.daySummaryNoProducts, style: theme.textTheme.bodyMedium)
            else
              for (final u in summary.products)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CategoryBadge(
                    category: u.product.category,
                    size: 36,
                  ),
                  title: Text(u.product.name),
                  trailing: Text(l10n.daySummaryTimes(u.times)),
                  onTap: () =>
                      context.push(AppRoutes.productDetail(u.product.id)),
                ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.edit_note_rounded),
              label: Text(l10n.daySummaryEdit),
              onPressed: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.dailyLog(fromDateKey(date)));
              },
            ),
          ],
        ],
      ),
    );
  }
}

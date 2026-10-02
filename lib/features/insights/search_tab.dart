import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/router.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/thai_date.dart';
import '../log/log_providers.dart';
import 'calendar_tab.dart';
import 'insights_providers.dart';

/// Find days with a symptom/factor and what was used just before
/// (docs/SPEC.md §7.6).
class SearchTab extends ConsumerWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final tags = (ref.watch(tagsProvider).value ?? const <Tag>[])
        .where((t) => t.type != TagType.ingredient)
        .toList();
    final selected = ref.watch(searchTagProvider);
    final days = selected == null
        ? null
        : ref.watch(taggedDaysProvider(selected)).value;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        Text(l10n.searchPrompt, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final t in tags)
              ChoiceChip(
                avatar: Icon(
                  t.type == TagType.symptom
                      ? Icons.healing_outlined
                      : Icons.wb_cloudy_outlined,
                  size: 16,
                ),
                label: Text(t.name),
                selected: t.id == selected,
                showCheckmark: false,
                onSelected: (on) =>
                    ref.read(searchTagProvider.notifier).set(on ? t.id : null),
              ),
          ],
        ),
        if (days != null) ...[
          SectionTitle(
            days.isEmpty
                ? l10n.searchNoDays
                : l10n.searchDaysFound(days.length),
          ),
          for (final d in days) ...[
            SoftCard(
              onTap: () => showDaySummary(context, d.date),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatLongDate(fromDateKey(d.date), locale),
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.searchRecentProducts,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final u in d.recentProducts)
                        ActionChip(
                          label: Text(
                            '${u.product.name} · ${l10n.daySummaryTimes(u.times)}',
                          ),
                          visualDensity: VisualDensity.compact,
                          onPressed: () => context.push(
                            AppRoutes.productDetail(u.product.id),
                          ),
                        ),
                      if (d.recentProducts.isEmpty)
                        Text(
                          l10n.daySummaryNoProducts,
                          style: theme.textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ],
    );
  }
}

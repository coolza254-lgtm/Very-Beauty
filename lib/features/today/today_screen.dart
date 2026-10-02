import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/theme.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/daily_log_dao.dart';
import '../../core/db/providers.dart';
import '../../core/db/routines_dao.dart';
import '../../core/db/settings_dao.dart';
import '../../core/utils/current_day.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/thai_date.dart';
import '../log/log_providers.dart';
import '../products/product_providers.dart';
import '../products/widgets/product_widgets.dart';
import '../routines/routine_providers.dart';
import 'today_alerts.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final day = ref.watch(currentDayProvider);
    final progress = ref.watch(todayProgressProvider).value ?? const [];
    final withSteps = progress.where((p) => p.total > 0).toList();
    final done = withSteps.fold<int>(0, (s, p) => s + p.done);
    final total = withSteps.fold<int>(0, (s, p) => s + p.total);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            _Header(day: day),
            const SizedBox(height: 20),
            _HeroCard(done: done, total: total),
            const _Alerts(),
            SectionTitle(
              l10n.todayRoutinesTitle,
              trailing: TextButton(
                onPressed: () => context.push(AppRoutes.routines),
                child: Text(l10n.routinesManage),
              ),
            ),
            for (final p in progress) ...[
              _RoutineChecklist(progress: p, day: day),
              const SizedBox(height: 12),
            ],
            SectionTitle(l10n.todaySkinTitle),
            _SkinToday(day: day),
            SectionTitle(l10n.todayQuickTitle),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: Icons.photo_camera_outlined,
                    color: BrandColors.sky,
                    label: l10n.quickPhoto,
                    onTap: () => context.push(AppRoutes.camera),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickAction(
                    icon: Icons.edit_note_rounded,
                    color: BrandColors.mint,
                    label: l10n.quickSkinLog,
                    onTap: () => context.push(AppRoutes.dailyLog(day)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatLongDate(day, locale),
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(l10n.todayHello, style: theme.textTheme.headlineMedium),
            const SizedBox(width: 8),
            Icon(Icons.auto_awesome, color: theme.colorScheme.secondary),
          ],
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final allDone = total > 0 && done == total;
    return SoftCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [scheme.primaryContainer, scheme.surfaceContainerLowest],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: scheme.surfaceContainerLowest,
                width: 3,
              ),
              boxShadow: softShadow(context),
            ),
            child: const CircleAvatar(
              radius: 36,
              backgroundColor: BrandColors.blush,
              backgroundImage: AssetImage('assets/branding/face_round.png'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allDone ? l10n.todayAllDone : l10n.todayGreeting,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  total == 0
                      ? l10n.todayHeroSubtitle
                      : l10n.todayProgress(done, total),
                  style: theme.textTheme.bodyMedium,
                ),
                if (total > 0) ...[
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: done / total,
                      minHeight: 8,
                      backgroundColor: scheme.surfaceContainerLowest,
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

class _Alerts extends ConsumerWidget {
  const _Alerts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final products = ref.watch(productsProvider).value ?? const [];
    final settings = ref.watch(settingsProvider).value ?? const {};
    final today = ref.watch(currentDayProvider);
    final alerts = computeTodayAlerts(
      products,
      now: today,
      weighDueDays:
          int.tryParse(settings[SettingKeys.weighDueDays] ?? '') ?? 14,
    );
    final backupDays = backupDueDays(settings, today);
    if (alerts.isEmpty && backupDays == null) return const SizedBox.shrink();

    String date(DateTime d) => formatShortDate(d, locale);
    String text(TodayAlert a) => switch (a.kind) {
      AlertKind.low => l10n.alertLow(a.product.name, formatPercent(a.percent!)),
      AlertKind.emptySoon => l10n.alertEmptySoon(a.product.name, date(a.date!)),
      AlertKind.expired => l10n.alertExpired(a.product.name, date(a.date!)),
      AlertKind.expiring => l10n.alertExpiring(a.product.name, date(a.date!)),
      AlertKind.weighDue => l10n.alertWeighDue(a.product.name, a.days!),
    };
    (IconData, Color) style(AlertKind k) => switch (k) {
      AlertKind.low || AlertKind.emptySoon => (
        Icons.hourglass_bottom_rounded,
        BrandColors.butter,
      ),
      AlertKind.expired ||
      AlertKind.expiring => (Icons.event_busy_outlined, BrandColors.blush),
      AlertKind.weighDue => (Icons.scale_outlined, BrandColors.sky),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(l10n.todayAlertsTitle),
        SoftCard(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              if (backupDays != null)
                ListTile(
                  leading: const PastelIconBadge(
                    icon: Icons.cloud_upload_outlined,
                    color: BrandColors.lavender,
                    size: 36,
                  ),
                  title: Text(
                    l10n.alertBackupDue(backupDays),
                    style: theme.textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.go(AppRoutes.settings),
                ),
              for (final a in alerts.take(5))
                ListTile(
                  leading: PastelIconBadge(
                    icon: style(a.kind).$1,
                    color: style(a.kind).$2,
                    size: 36,
                  ),
                  title: Text(text(a), style: theme.textTheme.bodyMedium),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () =>
                      context.push(AppRoutes.productDetail(a.product.id)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoutineChecklist extends ConsumerWidget {
  const _RoutineChecklist({required this.progress, required this.day});

  final RoutineProgress progress;
  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final routine = progress.routine;
    final r = routine.routine;
    final (icon, color) = slotStyle(r.timeOfDay);
    final steps = routine.activeSteps;
    final dao = ref.read(routinesDaoProvider);

    return SoftCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              PastelIconBadge(icon: icon, color: color, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => context.push(AppRoutes.routine(r.id)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.name, style: theme.textTheme.titleMedium),
                      if (steps.isNotEmpty)
                        Text(
                          l10n.routineProgress(progress.done, progress.total),
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ),
              if (progress.isComplete)
                Chip(
                  avatar: Icon(Icons.check_rounded, color: scheme.primary),
                  label: Text(l10n.routineAllDone),
                  visualDensity: VisualDensity.compact,
                )
              else if (steps.isNotEmpty)
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () => dao.completeRoutine(routine, day),
                  child: Text(l10n.routineUseAsUsual),
                ),
            ],
          ),
          const SizedBox(height: 6),
          if (steps.isEmpty)
            TextButton(
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              onPressed: () => context.push(AppRoutes.routine(r.id)),
              child: Text(l10n.routineEmptySteps),
            )
          else
            for (final s in steps)
              _StepRow(
                name: s.product.name,
                category: s.product.category,
                checked: progress.usedProductIds.contains(s.product.id),
                onTap: () => dao.toggleUsage(
                  routineId: r.id,
                  productId: s.product.id,
                  day: day,
                ),
              ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.name,
    required this.category,
    required this.checked,
    required this.onTap,
  });

  final String name;
  final ProductCategory category;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checked ? scheme.primary : Colors.transparent,
                border: Border.all(
                  color: checked ? scheme.primary : scheme.outline,
                  width: 1.5,
                ),
              ),
              child: checked
                  ? Icon(Icons.check_rounded, size: 18, color: scheme.onPrimary)
                  : null,
            ),
            const SizedBox(width: 14),
            CategoryBadge(category: category, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: checked ? scheme.onSurfaceVariant : scheme.onSurface,
                  decoration: checked ? TextDecoration.lineThrough : null,
                  decorationColor: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkinToday extends ConsumerWidget {
  const _SkinToday({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final entry = ref.watch(dailyEntryProvider(toDateKey(day))).value;
    final draft = DailyLogDraft.fromEntry(entry);
    final scores = [
      (l10n.scoreOil, draft.scoreOil),
      (l10n.scoreMoisture, draft.scoreMoisture),
      (l10n.scoreAcne, draft.scoreAcne),
      (l10n.scoreRedness, draft.scoreRedness),
      (l10n.scoreDullness, draft.scoreDullness),
    ].where((s) => s.$2 != null).toList();
    final hasAny =
        scores.isNotEmpty || draft.tagIds.isNotEmpty || draft.note != null;

    return SoftCard(
      onTap: () => context.push(AppRoutes.dailyLog(day)),
      child: Row(
        children: [
          const PastelIconBadge(
            icon: Icons.face_retouching_natural_outlined,
            color: BrandColors.mint,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: hasAny
                ? Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final (label, v) in scores)
                        Chip(
                          label: Text('$label $v'),
                          visualDensity: VisualDensity.compact,
                        ),
                      if (scores.isEmpty) Text(l10n.todaySkinEdit),
                    ],
                  )
                : Text(l10n.todaySkinEmpty, style: theme.textTheme.bodyMedium),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      onTap: onTap,
      child: Column(
        children: [
          PastelIconBadge(icon: icon, color: color, size: 52),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

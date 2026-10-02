import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/theme.dart';
import '../../app/widgets/empty_state_view.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/utils/thai_date.dart';
import '../routines/routine_providers.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final routines = ref.watch(routinesProvider).value ?? const <Routine>[];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            const _Header(),
            const SizedBox(height: 20),
            const _HeroCard(),
            SectionTitle(l10n.todayRoutinesTitle),
            for (final routine in routines) ...[
              _RoutineCard(routine: routine),
              const SizedBox(height: 12),
            ],
            SectionTitle(l10n.todayQuickTitle),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: Icons.photo_camera_outlined,
                    color: BrandColors.sky,
                    label: l10n.quickPhoto,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickAction(
                    icon: Icons.edit_note_rounded,
                    color: BrandColors.mint,
                    label: l10n.quickSkinLog,
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
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatLongDate(DateTime.now(), locale),
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
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
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
                Text(l10n.todayGreeting, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(l10n.todayHeroSubtitle, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (icon, color) = switch (routine.timeOfDay) {
      TimeOfDaySlot.morning => (Icons.wb_sunny_outlined, BrandColors.butter),
      TimeOfDaySlot.evening => (
        Icons.nightlight_outlined,
        BrandColors.lavender,
      ),
      TimeOfDaySlot.other => (Icons.spa_outlined, BrandColors.blush),
    };
    return SoftCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      onTap: () => showComingSoon(context),
      child: Row(
        children: [
          PastelIconBadge(icon: icon, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(routine.name, style: theme.textTheme.titleMedium),
                Text(
                  AppLocalizations.of(context).routineNoSteps,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
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
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      onTap: () => showComingSoon(context),
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

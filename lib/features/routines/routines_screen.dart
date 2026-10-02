import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import 'routine_providers.dart';

class RoutinesScreen extends ConsumerWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final routines = ref.watch(routinesProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.routinesTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final id = await ref
              .read(routinesDaoProvider)
              .createRoutine(l10n.routineNew, TimeOfDaySlot.other);
          if (context.mounted) await context.push(AppRoutes.routine(id));
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.routineNew),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
        itemCount: routines.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final r = routines[i];
          final (icon, color) = slotStyle(r.routine.timeOfDay);
          final subtitle = [
            l10n.routineStepCount(r.steps.length),
            if (r.routine.reminderEnabled && r.routine.reminderTime != null)
              '🔔 ${r.routine.reminderTime}',
          ].join(' · ');
          return SoftCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            onTap: () => context.push(AppRoutes.routine(r.routine.id)),
            child: Row(
              children: [
                PastelIconBadge(icon: icon, color: color),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.routine.name, style: theme.textTheme.titleMedium),
                      Text(subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          );
        },
      ),
    );
  }
}

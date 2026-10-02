import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/widgets/confirm_dialog.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/db/routines_dao.dart';
import '../../core/notifications/permission.dart';
import '../../core/notifications/reminder_planner.dart';
import '../products/product_providers.dart';
import '../products/widgets/product_widgets.dart';
import 'routine_providers.dart';

class RoutineEditorScreen extends ConsumerWidget {
  const RoutineEditorScreen({super.key, required this.routineId});

  final int routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(routineProvider(routineId));
    return switch (routine) {
      AsyncData(value: final r?) => _Editor(routine: r),
      AsyncData() => Scaffold(appBar: AppBar()),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}

class _Editor extends ConsumerStatefulWidget {
  const _Editor({required this.routine});

  final RoutineWithSteps routine;

  @override
  ConsumerState<_Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<_Editor> {
  late final TextEditingController _name;
  late List<RoutineStepItem> _steps;

  Routine get r => widget.routine.routine;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: r.name);
    _steps = [...widget.routine.steps];
  }

  @override
  void didUpdateWidget(covariant _Editor oldWidget) {
    super.didUpdateWidget(oldWidget);
    _steps = [...widget.routine.steps];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _update({
    String? name,
    TimeOfDaySlot? slot,
    String? reminderTime,
    bool? reminderEnabled,
  }) => ref
      .read(routinesDaoProvider)
      .updateRoutine(
        r.id,
        name: (name ?? _name.text).trim().isEmpty
            ? r.name
            : (name ?? _name.text),
        slot: slot ?? r.timeOfDay,
        reminderTime: reminderTime ?? r.reminderTime,
        reminderEnabled: reminderEnabled ?? r.reminderEnabled,
      );

  Future<void> _toggleReminder(bool on) async {
    if (on) {
      final granted = await ensureNotificationPermission(context, ref);
      if (!granted || !mounted) return;
      final time =
          r.reminderTime ??
          await _pickTime(r.timeOfDay == TimeOfDaySlot.evening ? 21 : 7);
      if (time == null) return;
      await _update(reminderTime: time, reminderEnabled: true);
    } else {
      await _update(reminderEnabled: false);
    }
  }

  Future<String?> _pickTime(int defaultHour) async {
    final current = parseHourMinute(r.reminderTime);
    final picked = await showTimePicker(
      context: context,
      initialTime: current == null
          ? TimeOfDay(hour: defaultHour, minute: 0)
          : TimeOfDay(hour: current.$1, minute: current.$2),
      helpText: AppLocalizations.of(context).pickTime,
    );
    return picked == null ? null : formatHourMinute(picked.hour, picked.minute);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(r.name),
        actions: [
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final ok = await confirmDialog(
                context,
                title: l10n.routineDeleteTitle,
                body: l10n.routineDeleteBody,
                confirm: l10n.actionDelete,
              );
              if (ok && context.mounted) {
                context.pop();
                await ref.read(routinesDaoProvider).deleteRoutine(r.id);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSteps(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.routineAddSteps),
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(labelText: l10n.routineName),
                    onChanged: (v) => _update(name: v),
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.routineSlot, style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<TimeOfDaySlot>(
                      showSelectedIcon: false,
                      segments: [
                        for (final s in TimeOfDaySlot.values)
                          ButtonSegment(
                            value: s,
                            label: Text(l10n.slot(s)),
                            icon: Icon(slotStyle(s).$1),
                          ),
                      ],
                      selected: {r.timeOfDay},
                      onSelectionChanged: (s) => _update(slot: s.single),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.routineReminder),
                    subtitle: r.reminderEnabled && r.reminderTime != null
                        ? Text(l10n.routineReminderAt(r.reminderTime!))
                        : null,
                    value: r.reminderEnabled,
                    onChanged: _toggleReminder,
                  ),
                  if (r.reminderEnabled)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        icon: const Icon(Icons.schedule_rounded),
                        label: Text(l10n.pickTime),
                        onPressed: () async {
                          final t = await _pickTime(7);
                          if (t != null) await _update(reminderTime: t);
                        },
                      ),
                    ),
                ],
              ),
            ),
            SectionTitle(l10n.routineSteps),
            if (_steps.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  l10n.routineStepsHint,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            if (_steps.isEmpty)
              SoftCard(
                onTap: () => _showAddSteps(context),
                child: Text(l10n.routineEmptySteps),
              ),
          ],
        ),
        itemCount: _steps.length,
        onReorderItem: (from, to) {
          setState(() => _steps.insert(to, _steps.removeAt(from)));
          ref.read(routinesDaoProvider).reorderSteps([
            for (final s in _steps) s.step.id,
          ]);
        },
        itemBuilder: (context, i) {
          final s = _steps[i];
          final inUse = s.product.status == ProductStatus.inUse;
          return Padding(
            key: ValueKey(s.step.id),
            padding: const EdgeInsets.only(bottom: 10),
            child: SoftCard(
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Row(
                children: [
                  Text(
                    '${i + 1}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ProductThumb(product: s.product, size: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.product.name,
                          style: theme.textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          inUse
                              ? categoryLabels(l10n, s.product)
                              : l10n.routineNotInUse,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.actionDelete,
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                    onPressed: () =>
                        ref.read(routinesDaoProvider).removeStep(s.step.id),
                  ),
                  ReorderableDragStartListener(
                    index: i,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.drag_indicator_rounded),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAddSteps(BuildContext context) async {
    final present = {for (final s in _steps) s.product.id};
    final candidates = (ref.read(productsProvider).value ?? const [])
        .where(
          (p) =>
              p.product.status == ProductStatus.inUse &&
              !present.contains(p.product.id),
        )
        .map((p) => p.product)
        .toList();
    final selected = await showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AddStepsSheet(candidates: candidates),
    );
    if (selected != null && selected.isNotEmpty) {
      await ref.read(routinesDaoProvider).addSteps(r.id, selected);
    }
  }
}

class _AddStepsSheet extends StatefulWidget {
  const _AddStepsSheet({required this.candidates});

  final List<Product> candidates;

  @override
  State<_AddStepsSheet> createState() => _AddStepsSheetState();
}

class _AddStepsSheetState extends State<_AddStepsSheet> {
  final _selected = <int>[];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(
              l10n.routineAddStepsTitle,
              style: theme.textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: widget.candidates.isEmpty
                ? Center(child: Text(l10n.routineAddStepsEmpty))
                : ListView(
                    controller: controller,
                    children: [
                      for (final p in widget.candidates)
                        CheckboxListTile(
                          value: _selected.contains(p.id),
                          onChanged: (v) => setState(
                            () => v == true
                                ? _selected.add(p.id)
                                : _selected.remove(p.id),
                          ),
                          secondary: ProductThumb(product: p, size: 40),
                          title: Text(p.name),
                          subtitle: Text(categoryLabels(l10n, p)),
                        ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
              onPressed: _selected.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(_selected),
              child: Text(l10n.routineAddSelected(_selected.length)),
            ),
          ),
        ],
      ),
    );
  }
}

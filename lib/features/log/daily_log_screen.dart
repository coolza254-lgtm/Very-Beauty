import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/daily_log_dao.dart';
import '../../core/db/providers.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/thai_date.dart';
import 'log_providers.dart';

/// Daily skin log for one date (`YYYY-MM-DD`). Everything is optional and
/// can be saved partially (docs/SPEC.md §7.4).
class DailyLogScreen extends ConsumerWidget {
  const DailyLogScreen({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entry = ref.watch(dailyEntryProvider(date));
    final tags = ref.watch(tagsProvider);
    if (!entry.hasValue || !tags.hasValue) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _DailyLogForm(
      date: date,
      initial: DailyLogDraft.fromEntry(entry.value),
    );
  }
}

class _DailyLogForm extends ConsumerStatefulWidget {
  const _DailyLogForm({required this.date, required this.initial});

  final String date;
  final DailyLogDraft initial;

  @override
  ConsumerState<_DailyLogForm> createState() => _DailyLogFormState();
}

class _DailyLogFormState extends ConsumerState<_DailyLogForm> {
  late int? _oil = widget.initial.scoreOil;
  late int? _moisture = widget.initial.scoreMoisture;
  late int? _acne = widget.initial.scoreAcne;
  late int? _redness = widget.initial.scoreRedness;
  late int? _dullness = widget.initial.scoreDullness;
  late double? _sleep = widget.initial.sleepHours;
  late int? _stress = widget.initial.stressLevel;
  late SunExposure? _sun = widget.initial.sunExposure;
  late PeriodPhase? _period = widget.initial.periodPhase;
  late final Set<int> _tags = {...widget.initial.tagIds};
  late final _note = TextEditingController(text: widget.initial.note);
  bool _saving = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    await ref
        .read(dailyLogDaoProvider)
        .saveEntry(
          widget.date,
          DailyLogDraft(
            scoreOil: _oil,
            scoreMoisture: _moisture,
            scoreAcne: _acne,
            scoreRedness: _redness,
            scoreDullness: _dullness,
            sleepHours: _sleep,
            stressLevel: _stress,
            sunExposure: _sun,
            periodPhase: _period,
            note: _note.text,
            tagIds: _tags,
          ),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).dailyLogSaved)),
    );
    context.pop();
  }

  Future<void> _addTag(TagType type) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tagAddTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: l10n.tagName),
          onSubmitted: (v) => Navigator.of(context).pop(v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(l10n.tagAdd),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.trim().isEmpty) return;
    final id = await ref.read(dailyLogDaoProvider).addTag(name, type);
    setState(() => _tags.add(id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final tags = ref.watch(tagsProvider).value ?? const <Tag>[];

    Widget tagSection(String title, TagType type) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final t in tags.where((t) => t.type == type))
              FilterChip(
                label: Text(t.name),
                selected: _tags.contains(t.id),
                onSelected: (on) =>
                    setState(() => on ? _tags.add(t.id) : _tags.remove(t.id)),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 18),
              label: Text(l10n.tagAdd),
              onPressed: () => _addTag(type),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dailyLogTitle),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(l10n.actionSave),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          Text(
            formatLongDate(fromDateKey(widget.date), locale),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SectionTitle(l10n.dailyLogScores),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.dailyLogScoresHint, style: theme.textTheme.bodySmall),
                const SizedBox(height: 12),
                ScoreRow(
                  label: l10n.scoreOil,
                  value: _oil,
                  onChanged: (v) => setState(() => _oil = v),
                ),
                ScoreRow(
                  label: l10n.scoreMoisture,
                  value: _moisture,
                  onChanged: (v) => setState(() => _moisture = v),
                ),
                ScoreRow(
                  label: l10n.scoreAcne,
                  value: _acne,
                  onChanged: (v) => setState(() => _acne = v),
                ),
                ScoreRow(
                  label: l10n.scoreRedness,
                  value: _redness,
                  onChanged: (v) => setState(() => _redness = v),
                ),
                ScoreRow(
                  label: l10n.scoreDullness,
                  value: _dullness,
                  onChanged: (v) => setState(() => _dullness = v),
                ),
              ],
            ),
          ),
          tagSection(l10n.dailyLogSymptoms, TagType.symptom),
          tagSection(l10n.dailyLogFactors, TagType.factor),
          SectionTitle(l10n.dailyLogLifestyle),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChipGroup<double>(
                  label: l10n.dailyLogSleep,
                  options: const [4, 5, 6, 7, 8, 9, 10],
                  value: _sleep,
                  labelOf: (v) => v == 10 ? '10+' : '${v.round()}',
                  onChanged: (v) => setState(() => _sleep = v),
                ),
                ScoreRow(
                  label: l10n.dailyLogStress,
                  value: _stress,
                  onChanged: (v) => setState(() => _stress = v),
                ),
                _ChipGroup<SunExposure>(
                  label: l10n.dailyLogSun,
                  options: SunExposure.values,
                  value: _sun,
                  labelOf: (v) => switch (v) {
                    SunExposure.none => l10n.sunNone,
                    SunExposure.low => l10n.sunLow,
                    SunExposure.high => l10n.sunHigh,
                  },
                  onChanged: (v) => setState(() => _sun = v),
                ),
                _ChipGroup<PeriodPhase>(
                  label: l10n.dailyLogPeriod,
                  options: PeriodPhase.values,
                  value: _period,
                  labelOf: (v) => switch (v) {
                    PeriodPhase.menstruation => l10n.periodMenstruation,
                    PeriodPhase.follicular => l10n.periodFollicular,
                    PeriodPhase.ovulation => l10n.periodOvulation,
                    PeriodPhase.luteal => l10n.periodLuteal,
                  },
                  onChanged: (v) => setState(() => _period = v),
                ),
              ],
            ),
          ),
          SectionTitle(l10n.dailyLogNote),
          TextField(
            controller: _note,
            minLines: 3,
            maxLines: 8,
            decoration: InputDecoration(hintText: l10n.dailyLogNoteHint),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
  }
}

/// Label plus five round 1–5 buttons. Tapping the selected one clears it.
class ScoreRow extends StatelessWidget {
  const ScoreRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 1; i <= 5; i++)
                Semantics(
                  button: true,
                  selected: value == i,
                  excludeSemantics: true,
                  label: '$label $i',
                  child: InkResponse(
                    onTap: () => onChanged(value == i ? null : i),
                    radius: 26,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value == i
                            ? scheme.primary
                            : scheme.surfaceContainerLowest,
                        border: Border.all(
                          color: value == i ? scheme.primary : scheme.outline,
                        ),
                      ),
                      child: Text(
                        '$i',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: value == i
                              ? scheme.onPrimary
                              : scheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChipGroup<T> extends StatelessWidget {
  const _ChipGroup({
    required this.label,
    required this.options,
    required this.value,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final List<T> options;
  final T? value;
  final String Function(T) labelOf;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final o in options)
                ChoiceChip(
                  label: Text(labelOf(o)),
                  selected: value == o,
                  showCheckmark: false,
                  onSelected: (_) => onChanged(value == o ? null : o),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../core/db/providers.dart';
import '../../core/ingredients/ingredient_db.dart';
import 'widgets/ingredient_widgets.dart';

/// Ingredient names saved on the user's products that the bundled database
/// doesn't know yet, so they can be reported and added later.
final missingIngredientsProvider = FutureProvider.autoDispose<List<String>>((
  ref,
) async {
  final db = await ref.watch(ingredientDbProvider.future);
  final names = await ref.watch(productsDaoProvider).usedIngredientNames();
  return [
    for (final n in names)
      if (db.lookup(n) == null) n,
  ];
});

/// Browsable, searchable view of the bundled ingredient database.
class IngredientsScreen extends ConsumerStatefulWidget {
  const IngredientsScreen({super.key});

  @override
  ConsumerState<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends ConsumerState<IngredientsScreen> {
  String _query = '';
  IngredientFunction? _function;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final db = ref.watch(ingredientDbProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.ingredientsTitle)),
      body: switch (db) {
        AsyncData(value: final db) => _body(context, l10n, theme, db),
        AsyncError(:final error) => Center(child: Text('$error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _body(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    IngredientDb db,
  ) {
    final matches = _query.trim().isEmpty
        ? ([...db.all]..sort((a, b) => a.inci.compareTo(b.inci)))
        : db.search(_query, limit: db.all.length);
    final items = [
      for (final i in matches)
        if (_function == null || i.functions.contains(_function)) i,
    ];
    final functions = [
      null,
      for (final f in IngredientFunction.values)
        if (db.all.any((i) => i.functions.contains(f))) f,
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.ingredientsSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              isDense: true,
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: functions.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final f = functions[i];
              return ChoiceChip(
                label: Text(
                  f == null
                      ? l10n.ingredientsFilterAll
                      : l10n.ingredientFunction(f),
                ),
                selected: f == _function,
                showCheckmark: false,
                onSelected: (_) => setState(() => _function = f),
              );
            },
          ),
        ),
        _MissingBanner(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.ingredientsCount(items.length),
              style: theme.textTheme.bodySmall,
            ),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? Center(child: Text(l10n.ingredientsNoMatch))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final i = items[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 8,
                        backgroundColor: ingredientColor(i.function),
                      ),
                      title: Text(i.inci),
                      subtitle: Text(
                        '${i.thai} · ${l10n.ingredientFunction(i.function)}',
                      ),
                      trailing: i.note == null
                          ? null
                          : const Icon(Icons.info_outline_rounded, size: 20),
                      onTap: () => showIngredientInfo(context, i.inci),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _MissingBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missing = ref.watch(missingIngredientsProvider).value ?? const [];
    if (missing.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Material(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showMissing(context, missing),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            child: Row(
              children: [
                const Icon(Icons.help_outline_rounded, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.ingredientsMissing(missing.length),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  l10n.ingredientsMissingShow,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMissing(BuildContext context, List<String> missing) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _MissingSheet(),
    );
  }
}

class _MissingSheet extends ConsumerWidget {
  const _MissingSheet();

  Future<void> _fix(BuildContext context, WidgetRef ref, String name) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final picked = await showDialog<String>(
      context: context,
      builder: (_) => _FixDialog(name: name),
    );
    if (picked == null) return;
    await ref.read(productsDaoProvider).renameIngredient(name, picked);
    ref.invalidate(missingIngredientsProvider);
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.ingredientsFixed(picked))),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final missing = ref.watch(missingIngredientsProvider).value ?? const [];
    final db = ref.watch(ingredientDbProvider).value;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.ingredientsMissingTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    l10n.ingredientsMissingHint,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (final name in missing)
                    ListTile(
                      dense: true,
                      title: Text(name),
                      subtitle: switch (db?.search(name, limit: 1)) {
                        [final best, ...] => Text(
                          l10n.ingredientsDidYouMean(best.inci),
                        ),
                        _ => null,
                      },
                      trailing: TextButton(
                        onPressed: () => _fix(context, ref, name),
                        child: Text(l10n.ingredientsFix),
                      ),
                    ),
                ],
              ),
            ),
            if (missing.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: FilledButton.icon(
                  icon: const Icon(Icons.copy_rounded),
                  label: Text(l10n.ingredientsMissingCopy),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: missing.join('\n')),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.ingredientsMissingCopied)),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Search the database for the right name to replace [name] with.
class _FixDialog extends ConsumerStatefulWidget {
  const _FixDialog({required this.name});

  final String name;

  @override
  ConsumerState<_FixDialog> createState() => _FixDialogState();
}

class _FixDialogState extends ConsumerState<_FixDialog> {
  late final _query = TextEditingController(text: widget.name);

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(ingredientDbProvider).value;
    final results = db?.search(_query.text, limit: 8) ?? const <Ingredient>[];
    return AlertDialog(
      title: Text(l10n.ingredientsFixTitle(widget.name)),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.ingredientsFixHint),
            const SizedBox(height: 8),
            TextField(
              controller: _query,
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final i in results)
                    ListTile(
                      dense: true,
                      title: Text(i.inci),
                      subtitle: Text(i.thai),
                      onTap: () => Navigator.of(context).pop(i.inci),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    );
  }
}

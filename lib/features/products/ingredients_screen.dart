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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.75,
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
                      ListTile(dense: true, title: SelectableText(name)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: FilledButton.icon(
                  icon: const Icon(Icons.copy_rounded),
                  label: Text(l10n.ingredientsMissingCopy),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: missing.join('\n')),
                    );
                    if (sheetContext.mounted) {
                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                        SnackBar(content: Text(l10n.ingredientsMissingCopied)),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

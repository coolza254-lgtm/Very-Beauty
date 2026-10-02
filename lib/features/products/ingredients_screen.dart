import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../core/ingredients/ingredient_db.dart';
import 'widgets/ingredient_widgets.dart';

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
        if (_function == null || i.function == _function) i,
    ];
    final functions = [
      null,
      for (final f in IngredientFunction.values)
        if (db.all.any((i) => i.function == f)) f,
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

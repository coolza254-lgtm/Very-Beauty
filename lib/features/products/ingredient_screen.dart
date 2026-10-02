import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/ingredients/ingredient_db.dart';
import '../../core/utils/formatters.dart';
import 'widgets/ingredient_widgets.dart';
import 'widgets/molecule_view.dart';

final _productsWithIngredientProvider = StreamProvider.autoDispose
    .family<List<Product>, String>((ref, names) {
      return ref
          .watch(productsDaoProvider)
          .watchProductsWithIngredient(names.split('\n'));
    });

/// Full page about one ingredient: what it is, what it does, how to use it,
/// cautions, its chemical structure and the user's products containing it.
class IngredientScreen extends ConsumerWidget {
  const IngredientScreen({super.key, required this.name});

  /// INCI, Thai or alias name.
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(ingredientDbProvider);
    final ingredient = db.value?.lookup(name);
    return Scaffold(
      appBar: AppBar(),
      body: switch (db) {
        AsyncData() when ingredient == null => _Unknown(name: name),
        AsyncData() => _Body(ingredient: ingredient!),
        AsyncError(:final error) => Center(child: Text('$error')),
        _ => Center(child: Text(l10n.ingredientsTitle)),
      },
    );
  }
}

class _Unknown extends ConsumerWidget {
  const _Unknown({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      children: [
        Text(name, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text(l10n.ingredientsUnknown, style: theme.textTheme.bodyLarge),
        _MyProducts(names: [name]),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final i = ingredient;
    final isThai = Localizations.localeOf(context).languageCode == 'th';
    final note = i.noteFor(isThai ? 'th' : 'en');

    Widget section(String title, String body) => Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(body, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );

    final categories = [
      for (final c in ProductCategory.values)
        if (i.usedIn.contains(c.name)) l10n.category(c),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      children: [
        Text(i.inci, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 2),
        Text(i.thai, style: theme.textTheme.titleMedium),
        if (i.aliases.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${l10n.ingredientsAlsoKnownAs}: ${i.aliases.join(', ')}',
            style: theme.textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [for (final f in i.functions) FunctionChip(f)],
        ),
        if (note != null) ...[const SizedBox(height: 16), _Caution(text: note)],
        if (isThai) ...[
          if (i.what case final what?) section(l10n.ingredientWhat, what),
          if (i.good case final good?) section(l10n.ingredientGood, good),
          if (i.tips case final tips?) section(l10n.ingredientTips, tips),
        ] else if (i.summaryEn case final en?)
          section(l10n.ingredientAbout, en),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.ingredientRoles, style: theme.textTheme.titleMedium),
                for (final f in i.functions) ...[
                  const SizedBox(height: 10),
                  FunctionChip(f),
                  const SizedBox(height: 4),
                  Text(
                    l10n.ingredientFunctionAbout(f),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (categories.isNotEmpty)
          section(l10n.ingredientsTypicalIn, categories.join(', ')),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _Structure(ingredient: i),
        ),
        _MyProducts(names: [i.inci, i.thai, ...i.aliases]),
        const SizedBox(height: 20),
        Text(l10n.ingredientsDisclaimer, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _Caution extends StatelessWidget {
  const _Caution({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).ingredientsCaution,
                  style: theme.textTheme.labelLarge,
                ),
                Text(text, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Structure extends StatelessWidget {
  const _Structure({required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final i = ingredient;
    final molecule = i.molecule;
    final kindText = switch (i.kind) {
      'polymer' => l10n.ingredientKindPolymer,
      'extract' => l10n.ingredientKindExtract,
      'oil' => l10n.ingredientKindOil,
      'mixture' => l10n.ingredientKindMixture,
      'mineral' => l10n.ingredientKindMineral,
      'protein' => l10n.ingredientKindProtein,
      'ferment' => l10n.ingredientKindFerment,
      'peptide' => l10n.ingredientKindPeptide,
      _ => l10n.ingredientKindUnknown,
    };
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.ingredientStructure, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (molecule != null)
            ClipRect(
              child: InteractiveViewer(
                maxScale: 5,
                child: MoleculeView(molecule: molecule),
              ),
            )
          else
            Text(kindText, style: theme.textTheme.bodyMedium),
          if (i.formula case final formula?) ...[
            const SizedBox(height: 8),
            Text(
              l10n.ingredientFormula(formatFormula(formula)),
              style: theme.textTheme.bodyLarge,
            ),
          ],
          if (i.molecularWeight case final mw?)
            Text(
              l10n.ingredientMw(formatNumber(mw)),
              style: theme.textTheme.bodyMedium,
            ),
          if (molecule != null) ...[
            const SizedBox(height: 4),
            Text(l10n.ingredientZoomHint, style: theme.textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

class _MyProducts extends ConsumerWidget {
  const _MyProducts({required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products =
        ref.watch(_productsWithIngredientProvider(names.join('\n'))).value ??
        const <Product>[];
    if (products.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SoftCard(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                l10n.ingredientMyProducts,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final p in products)
              ListTile(
                leading: Icon(categoryIcon(p.category)),
                title: Text(p.name),
                subtitle: p.brand == null ? null : Text(p.brand!),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push(AppRoutes.productDetail(p.id)),
              ),
          ],
        ),
      ),
    );
  }
}

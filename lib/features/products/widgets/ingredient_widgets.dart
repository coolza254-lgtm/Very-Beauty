import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/l10n/gen/app_localizations.dart';
import '../../../app/labels.dart';
import '../../../app/router.dart';
import '../../../app/theme.dart';
import '../../../core/db/enums.dart';
import '../../../core/ingredients/ingredient_db.dart';

/// Pastel colour per ingredient function, so lists are easy to scan.
Color ingredientColor(IngredientFunction f) => switch (f) {
  IngredientFunction.uvChemical ||
  IngredientFunction.uvMineral => BrandColors.butter,
  IngredientFunction.surfactant => BrandColors.sky,
  IngredientFunction.humectant ||
  IngredientFunction.emollient ||
  IngredientFunction.occlusive ||
  IngredientFunction.barrier => BrandColors.mint,
  IngredientFunction.brightening ||
  IngredientFunction.antioxidant ||
  IngredientFunction.exfoliant ||
  IngredientFunction.antiAcne ||
  IngredientFunction.retinoid ||
  IngredientFunction.antiAging => BrandColors.lavender,
  IngredientFunction.soothing => BrandColors.blush,
  _ => BrandColors.petal,
};

/// Opens the full ingredient page (INCI, Thai or alias name).
Future<void> showIngredientInfo(BuildContext context, String name) =>
    context.push(AppRoutes.ingredient(name));

/// Small pastel label naming what an ingredient does.
class FunctionChip extends StatelessWidget {
  const FunctionChip(this.function, {super.key});

  final IngredientFunction function;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = ingredientColor(function);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isDark ? color.withValues(alpha: 0.2) : color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        AppLocalizations.of(context).ingredientFunction(function),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

/// Read-only ingredient chips; tapping one opens its info sheet.
class IngredientChips extends ConsumerWidget {
  const IngredientChips({super.key, required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(ingredientDbProvider).value;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final name in names)
          _chip(
            context,
            name,
            db?.lookup(name),
            onPressed: () {
              showIngredientInfo(context, name);
            },
          ),
      ],
    );
  }
}

Widget _chip(
  BuildContext context,
  String name,
  Ingredient? known, {
  VoidCallback? onPressed,
  VoidCallback? onDeleted,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final color = known == null ? null : ingredientColor(known.function);
  final avatar = known?.note != null
      ? const Icon(Icons.info_outline_rounded, size: 16)
      : null;
  return InputChip(
    label: Text(name),
    avatar: avatar,
    backgroundColor: color == null
        ? null
        : isDark
        ? color.withValues(alpha: 0.2)
        : color,
    visualDensity: VisualDensity.compact,
    onPressed: onPressed,
    onDeleted: onDeleted,
  );
}

/// Chip input with suggestions from the bundled ingredient database and the
/// user's own earlier entries. Saves canonical INCI names when known.
class IngredientInput extends ConsumerStatefulWidget {
  const IngredientInput({
    super.key,
    required this.values,
    required this.onChanged,
    this.categories = const [],
    this.usedBefore = const [],
  });

  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  /// Drives the "common in ..." quick-add chips.
  final List<ProductCategory> categories;

  /// Names the user typed on other products (also suggested).
  final List<String> usedBefore;

  @override
  ConsumerState<IngredientInput> createState() => _IngredientInputState();
}

/// An autocomplete option: a database entry or a free-text name.
typedef _Option = ({String name, Ingredient? known, bool custom});

class _IngredientInputState extends ConsumerState<IngredientInput> {
  final _text = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  bool _has(String name) {
    final n = IngredientDb.normalize(name);
    return widget.values.any((v) => IngredientDb.normalize(v) == n);
  }

  /// Adds names (canonicalised via the database), skipping duplicates.
  void _add(Iterable<String> names) {
    final db = ref.read(ingredientDbProvider).value;
    final next = [...widget.values];
    for (final raw in names) {
      final trimmed = raw.trim();
      if (trimmed.isEmpty) continue;
      final name = db?.lookup(trimmed)?.inci ?? trimmed;
      final n = IngredientDb.normalize(name);
      if (next.any((v) => IngredientDb.normalize(v) == n)) continue;
      next.add(name);
    }
    if (next.length != widget.values.length) widget.onChanged(next);
  }

  void _remove(String name) =>
      widget.onChanged([...widget.values]..remove(name));

  static final _commas = RegExp(r'[,،、;]');

  /// Splits a pasted list. Labels separate ingredients with commas and wrap
  /// long names onto the next line, so with commas present line breaks are
  /// just spaces; without commas, one ingredient per line.
  static List<String> _split(String text) => text.contains(_commas)
      ? text.replaceAll(RegExp(r'\s*\n\s*'), ' ').split(_commas)
      : text.split('\n');

  /// Pasting "Water, Glycerin, ..." adds every complete name at once.
  void _onTextChanged(String text) {
    if (!text.contains(_commas) && !text.contains('\n')) return;
    final parts = _split(text);
    _add(parts.take(parts.length - 1));
    _text.text = parts.last.trimLeft();
  }

  void _submit(String text) {
    _add(_split(text));
    _text.clear();
    _focus.requestFocus();
  }

  Iterable<_Option> _options(TextEditingValue value) {
    final query = value.text.trim();
    if (query.isEmpty) return const [];
    final db = ref.read(ingredientDbProvider).value;
    final q = IngredientDb.normalize(query);
    final options = <_Option>[
      for (final i in db?.search(query, limit: 8) ?? const <Ingredient>[])
        if (!_has(i.inci)) (name: i.inci, known: i, custom: false),
      for (final name in widget.usedBefore)
        if (db?.lookup(name) == null &&
            IngredientDb.normalize(name).contains(q) &&
            !_has(name))
          (name: name, known: null, custom: false),
    ];
    final exact = options.any(
      (o) =>
          IngredientDb.normalize(o.name) == q ||
          (o.known?.thai != null && IngredientDb.normalize(o.known!.thai) == q),
    );
    if (!exact && !_has(query)) {
      options.add((name: query, known: null, custom: true));
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final db = ref.watch(ingredientDbProvider).value;
    final categories = widget.categories;
    final popular = <Ingredient>{
      if (db != null)
        for (final c in categories)
          for (final i in db.popularFor(c))
            if (!_has(i.inci)) i,
    }.take(12).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.fieldIngredients, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (widget.values.isNotEmpty) ...[
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final name in widget.values)
                _chip(
                  context,
                  name,
                  db?.lookup(name),
                  onPressed: () => showIngredientInfo(context, name),
                  onDeleted: () => _remove(name),
                ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        LayoutBuilder(
          builder: (context, constraints) => RawAutocomplete<_Option>(
            textEditingController: _text,
            focusNode: _focus,
            displayStringForOption: (o) => o.name,
            optionsBuilder: _options,
            onSelected: (o) {
              _add([o.name]);
              _text.clear();
              _focus.requestFocus();
            },
            fieldViewBuilder: (context, controller, focusNode, onSubmit) =>
                TextField(
                  key: const Key('ingredientField'),
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.done,
                  onChanged: _onTextChanged,
                  onSubmitted: _submit,
                  decoration: InputDecoration(
                    hintText: l10n.ingredientsSearchHint,
                    helperText: l10n.fieldIngredientsHelp,
                    helperMaxLines: 3,
                    prefixIcon: const Icon(Icons.search_rounded),
                    isDense: true,
                  ),
                ),
            optionsViewBuilder: (context, onSelected, options) => Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                    maxHeight: 280,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    shrinkWrap: true,
                    children: [
                      for (final o in options)
                        ListTile(
                          dense: true,
                          leading: o.custom
                              ? const Icon(Icons.add_rounded)
                              : null,
                          title: Text(
                            o.custom
                                ? l10n.ingredientsAddCustom(o.name)
                                : o.name,
                          ),
                          subtitle: Text(switch (o) {
                            (known: final i?, name: _, custom: _) =>
                              '${i.thai} · ${l10n.ingredientFunction(i.function)}',
                            (custom: true, name: _, known: _) =>
                              l10n.ingredientsCustomSubtitle,
                            _ => l10n.ingredientsUsedBefore,
                          }),
                          onTap: () => onSelected(o),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (popular.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            l10n.ingredientsCommonIn(categories.map(l10n.category).join(' · ')),
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final i in popular)
                ActionChip(
                  avatar: const Icon(Icons.add_rounded, size: 16),
                  label: Text(i.inci),
                  tooltip: i.thai,
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _add([i.inci]),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

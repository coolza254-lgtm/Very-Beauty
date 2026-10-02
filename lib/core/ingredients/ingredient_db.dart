import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/enums.dart';

/// What an ingredient mainly does in a formula. Names match the `fn` codes in
/// `assets/data/ingredients.json`.
enum IngredientFunction {
  surfactant,
  uvChemical,
  uvMineral,
  humectant,
  emollient,
  occlusive,
  barrier,
  brightening,
  antioxidant,
  exfoliant,
  antiAcne,
  retinoid,
  antiAging,
  soothing,
  absorbent,
  filmFormer,
  emulsifier,
  thickener,
  preservative,
  chelating,
  phAdjuster,
  solvent,
  fragrance,
  other;

  static IngredientFunction parse(String? code) => values.firstWhere(
    (f) => f.name == code,
    orElse: () => IngredientFunction.other,
  );
}

/// One entry of the bundled ingredient reference.
class Ingredient {
  const Ingredient({
    required this.inci,
    required this.thai,
    required this.function,
    this.aliases = const [],
    this.usedIn = const {},
    this.note,
    this.noteEn,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    inci: json['inci'] as String,
    thai: json['th'] as String,
    function: IngredientFunction.parse(json['fn'] as String?),
    aliases: [...?(json['aka'] as List?)?.cast<String>()],
    usedIn: {...?(json['use'] as List?)?.cast<String>()},
    note: json['note'] as String?,
    noteEn: json['noteEn'] as String?,
  );

  /// Canonical INCI name, as printed on the package. This is what gets saved.
  final String inci;
  final String thai;
  final IngredientFunction function;

  /// Common short or trade names (e.g. "Vitamin C", "SLS").
  final List<String> aliases;

  /// Product category names this ingredient is typical in.
  final Set<String> usedIn;

  /// A caution worth knowing (irritation, sun sensitivity, ...).
  final String? note;
  final String? noteEn;

  String? noteFor(String languageCode) => languageCode == 'th' ? note : noteEn;

  /// All names to match against, including the Thai name without its
  /// bracketed explanation ("เรตินอล (วิตามินเอ)" → "เรตินอล").
  Iterable<String> get _names => [
    inci,
    thai,
    if (thai.contains(' (')) thai.substring(0, thai.indexOf(' (')),
    ...aliases,
  ];
}

/// Offline ingredient reference loaded from `assets/data/ingredients.json`.
class IngredientDb {
  IngredientDb(this.all, {this.popular = const {}}) {
    for (final i in all) {
      for (final n in i._names) {
        _byName.putIfAbsent(normalize(n), () => i);
      }
    }
  }

  factory IngredientDb.fromJsonString(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return IngredientDb(
      [
        for (final e in json['ingredients'] as List)
          Ingredient.fromJson(e as Map<String, dynamic>),
      ],
      popular: {
        for (final MapEntry(:key, :value)
            in (json['popular'] as Map<String, dynamic>? ?? {}).entries)
          key: (value as List).cast<String>(),
      },
    );
  }

  static const assetPath = 'assets/data/ingredients.json';

  final List<Ingredient> all;

  /// Category name → key INCI names, most typical first.
  final Map<String, List<String>> popular;
  final _byName = <String, Ingredient>{};

  /// Lower-case, without spaces and punctuation, so "Hyaluronic acid",
  /// "hyaluronic-acid" and "HYALURONICACID" all match.
  static String normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[\s\-_,.()/\[\]]+'), '');

  /// Finds an ingredient by INCI, Thai or alias name (exact, normalized).
  Ingredient? lookup(String name) => _byName[normalize(name)];

  /// Ingredients matching [query] anywhere in their names. Exact matches come
  /// first, then names starting with the query, then the rest.
  List<Ingredient> search(String query, {int limit = 20}) {
    final q = normalize(query);
    if (q.isEmpty) return const [];
    final ranked = <(int, Ingredient)>[];
    for (final i in all) {
      var best = 99;
      for (final n in i._names) {
        final name = normalize(n);
        final rank = name == q
            ? 0
            : name.startsWith(q)
            ? 1
            : name.contains(q)
            ? 2
            : 99;
        if (rank < best) best = rank;
      }
      if (best < 99) ranked.add((best, i));
    }
    ranked.sort((a, b) {
      final byRank = a.$1.compareTo(b.$1);
      return byRank != 0 ? byRank : a.$2.inci.compareTo(b.$2.inci);
    });
    return [for (final (_, i) in ranked.take(limit)) i];
  }

  /// Key ingredients often found in [category], most typical first.
  List<Ingredient> popularFor(ProductCategory category) => [
    for (final name in popular[category.name] ?? const <String>[])
      ?lookup(name),
  ];
}

final ingredientDbProvider = FutureProvider<IngredientDb>((ref) async {
  // Decode ourselves: rootBundle.loadString hands large files to an isolate.
  final data = await rootBundle.load(IngredientDb.assetPath);
  return IngredientDb.fromJsonString(utf8.decode(data.buffer.asUint8List()));
});

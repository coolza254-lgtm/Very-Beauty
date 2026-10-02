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
  colorant,
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
    required this.functions,
    this.aliases = const [],
    this.usedIn = const {},
    this.note,
    this.noteEn,
    this.what,
    this.good,
    this.tips,
    this.summaryEn,
    this.formula,
    this.molecularWeight,
    this.kind,
    this.molecule,
  }) : assert(functions.length > 0);

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final fn = json['fn'];
    final mol = json['mol'] as Map<String, dynamic>?;
    return Ingredient(
      inci: json['inci'] as String,
      thai: json['th'] as String,
      functions: [
        for (final code in fn is List ? fn : [fn])
          IngredientFunction.parse(code as String?),
      ],
      aliases: [...?(json['aka'] as List?)?.cast<String>()],
      usedIn: {...?(json['use'] as List?)?.cast<String>()},
      note: json['note'] as String?,
      noteEn: json['noteEn'] as String?,
      what: json['what'] as String?,
      good: json['good'] as String?,
      tips: json['tips'] as String?,
      summaryEn: json['en'] as String?,
      formula: json['formula'] as String?,
      molecularWeight: (json['mw'] as num?)?.toDouble(),
      kind: json['kind'] as String?,
      molecule: mol == null ? null : Molecule.fromJson(mol),
    );
  }

  /// Canonical INCI name, as printed on the package. This is what gets saved.
  final String inci;
  final String thai;

  /// What it does, main function first.
  final List<IngredientFunction> functions;
  IngredientFunction get function => functions.first;

  /// Common short or trade names (e.g. "Vitamin C", "SLS").
  final List<String> aliases;

  /// Product category names this ingredient is typical in.
  final Set<String> usedIn;

  /// A caution worth knowing (irritation, sun sensitivity, ...).
  final String? note;
  final String? noteEn;

  String? noteFor(String languageCode) => languageCode == 'th' ? note : noteEn;

  /// Thai article: what it is, what it does, how to use it.
  final String? what;
  final String? good;
  final String? tips;

  /// One-line English summary (English UI).
  final String? summaryEn;

  /// Molecular formula, e.g. "C6H6N2O" (or a mineral formula).
  final String? formula;
  final double? molecularWeight;

  /// Why there is no single structure: polymer, extract, oil, mixture,
  /// mineral, protein, ferment, peptide or water.
  final String? kind;

  /// 2D skeletal structure, when the ingredient is one defined molecule.
  final Molecule? molecule;

  /// All names to match against, including the Thai name without its
  /// bracketed explanation ("เรตินอล (วิตามินเอ)" → "เรตินอล").
  Iterable<String> get _names => [
    inci,
    thai,
    if (thai.contains(' (')) thai.substring(0, thai.indexOf(' (')),
    ...aliases,
  ];
}

/// A 2D skeletal structure laid out offline by tool/ingredients/build.py.
class Molecule {
  const Molecule(this.atoms, this.bonds);

  factory Molecule.fromJson(Map<String, dynamic> json) => Molecule(
    [
      for (final a in json['a'] as List)
        MoleculeAtom.fromJson((a as List).cast<Object>()),
    ],
    [
      for (final b in json['b'] as List)
        MoleculeBond.fromJson((b as List).cast<num>()),
    ],
  );

  final List<MoleculeAtom> atoms;
  final List<MoleculeBond> bonds;
}

/// Atom position in bond-length units (y grows downwards). Carbon atoms have
/// no [element] and are drawn as plain vertices.
class MoleculeAtom {
  const MoleculeAtom(
    this.x,
    this.y, {
    this.element,
    this.hydrogens = 0,
    this.charge = 0,
  });

  /// `[x, y]` or `[x, y, element, hydrogens?, charge?]`.
  factory MoleculeAtom.fromJson(List<Object> row) => MoleculeAtom(
    (row[0] as num).toDouble(),
    (row[1] as num).toDouble(),
    element: row.length > 2 ? row[2] as String : null,
    hydrogens: row.length > 3 ? (row[3] as num).toInt() : 0,
    charge: row.length > 4 ? (row[4] as num).toInt() : 0,
  );

  final double x;
  final double y;
  final String? element;
  final int hydrogens;
  final int charge;
}

class MoleculeBond {
  const MoleculeBond(this.from, this.to, this.order, {this.side = 0});

  /// `[from, to, order, side?]`.
  factory MoleculeBond.fromJson(List<num> row) => MoleculeBond(
    row[0].toInt(),
    row[1].toInt(),
    row[2].toInt(),
    side: row.length > 3 ? row[3].toInt() : 0,
  );

  final int from;
  final int to;

  /// 1, 2 or 3.
  final int order;

  /// For ring double bonds: which side (+1 left / −1 right of from→to) the
  /// inner line goes. 0 draws a centred double bond.
  final int side;
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

  static final _parenthetical = RegExp(r'\([^)]*\)');

  /// Finds an ingredient by INCI, Thai or alias name (exact, normalized).
  /// Labels often add a common name in brackets, e.g. "Melaleuca
  /// Alternifolia (Tea Tree) Leaf Extract"; those are ignored as a fallback.
  Ingredient? lookup(String name) =>
      _byName[normalize(name)] ??
      (name.contains('(')
          ? _byName[normalize(name.replaceAll(_parenthetical, ' '))]
          : null);

  /// Ingredients matching [query] anywhere in their names. Exact matches come
  /// first, then names starting with the query (shortest first, so "glycer"
  /// finds Glycerin before Glycereth-26), then the rest.
  List<Ingredient> search(String query, {int limit = 20}) {
    final q = normalize(query);
    if (q.isEmpty) return const [];
    final ranked = <(int, int, Ingredient)>[];
    for (final i in all) {
      var best = 99;
      var bestLength = 0;
      for (final n in i._names) {
        final name = normalize(n);
        final rank = name == q
            ? 0
            : name.startsWith(q)
            ? 1
            : name.contains(q)
            ? 2
            : 99;
        if (rank < best || (rank == best && name.length < bestLength)) {
          best = rank;
          bestLength = name.length;
        }
      }
      if (best < 99) ranked.add((best, bestLength, i));
    }
    ranked.sort((a, b) {
      final byRank = a.$1.compareTo(b.$1);
      if (byRank != 0) return byRank;
      final byLength = a.$2.compareTo(b.$2);
      return byLength != 0 ? byLength : a.$3.inci.compareTo(b.$3.inci);
    });
    return [for (final (_, _, i) in ranked.take(limit)) i];
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

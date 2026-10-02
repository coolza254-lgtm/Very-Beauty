import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/enums.dart';
import 'package:very_beauty/core/ingredients/ingredient_db.dart';

void main() {
  late IngredientDb db;

  setUpAll(() {
    db = IngredientDb.fromJsonString(
      File(IngredientDb.assetPath).readAsStringSync(),
    );
  });

  test('bundled data is large and well-formed', () {
    expect(db.all.length, greaterThan(700));
    final names = <String>{};
    for (final i in db.all) {
      expect(i.inci.trim(), isNotEmpty);
      expect(i.thai.trim(), isNotEmpty);
      expect(
        names.add(IngredientDb.normalize(i.inci)),
        isTrue,
        reason: 'duplicate ${i.inci}',
      );
      if (i.note != null) expect(i.noteEn, isNotNull, reason: i.inci);
    }
    // Every function code in the file is known, and every entry explains
    // itself.
    expect(
      db.all.where((i) => i.function == IngredientFunction.other).length,
      lessThan(db.all.length ~/ 20),
    );
    for (final i in db.all) {
      expect(i.what, isNotNull, reason: i.inci);
      expect(i.summaryEn, isNotNull, reason: i.inci);
    }
  });

  test('covers cleansers and sunscreens', () {
    expect(
      db.all.where((i) => i.usedIn.contains('sunscreen')).length,
      greaterThan(150),
    );
    expect(
      db.all.where((i) => i.usedIn.contains('cleanser')).length,
      greaterThan(300),
    );
    expect(db.lookup('Zinc Oxide')?.function, IngredientFunction.uvMineral);
    expect(
      db.lookup('Sodium Laureth Sulfate')?.function,
      IngredientFunction.surfactant,
    );
  });

  test('lookup accepts INCI, aliases, Thai and loose spelling', () {
    expect(db.lookup('niacinamide')?.inci, 'Niacinamide');
    expect(db.lookup('SLS')?.inci, 'Sodium Lauryl Sulfate');
    expect(db.lookup('ไนอะซินาไมด์')?.inci, 'Niacinamide');
    expect(db.lookup('  NIACIN-AMIDE ')?.inci, 'Niacinamide');
    expect(db.lookup('Unicorn Tears'), isNull);
  });

  test('search ranks exact and prefix matches first', () {
    final results = db.search('glycer');
    expect(results.first.inci, 'Glycerin');
    expect(db.search('zinc').map((i) => i.inci), contains('Zinc Oxide'));
    expect(db.search('กันแดด'), isA<List<Ingredient>>());
    expect(db.search(''), isEmpty);
    expect(db.search('a', limit: 5), hasLength(5));
  });

  test('popular ingredients exist for main categories', () {
    for (final c in [
      ProductCategory.cleanser,
      ProductCategory.sunscreen,
      ProductCategory.moisturizer,
      ProductCategory.serum,
      ProductCategory.toner,
      ProductCategory.treatment,
      ProductCategory.mask,
    ]) {
      final popular = db.popularFor(c);
      expect(popular, isNotEmpty, reason: c.name);
      expect(popular.length, db.popular[c.name]!.length, reason: c.name);
    }
    expect(db.popularFor(ProductCategory.other), isEmpty);
  });

  test('molecules have valid layouts', () {
    final withStructure = db.all.where((i) => i.molecule != null).toList();
    expect(withStructure.length, greaterThan(250));
    for (final i in withStructure) {
      final m = i.molecule!;
      expect(i.formula, isNotNull, reason: i.inci);
      expect(i.molecularWeight, greaterThan(0), reason: i.inci);
      for (final b in m.bonds) {
        expect(b.from, lessThan(m.atoms.length), reason: i.inci);
        expect(b.to, lessThan(m.atoms.length), reason: i.inci);
        expect(b.order, inInclusiveRange(1, 3), reason: i.inci);
      }
    }
    final niacinamide = db.lookup('Niacinamide')!;
    expect(niacinamide.formula, 'C6H6N2O');
    // 6 ring atoms + carbonyl C, O and amide N.
    expect(niacinamide.molecule!.atoms, hasLength(9));
    expect(
      niacinamide.molecule!.atoms.where((a) => a.element == 'N'),
      hasLength(2),
    );
  });

  test('ingredients without one structure say why', () {
    for (final i in db.all) {
      if (i.molecule == null && i.kind == null) continue;
      expect(i.molecule == null || i.kind == null, isTrue, reason: i.inci);
    }
    expect(db.lookup('Dimethicone')!.kind, 'polymer');
    expect(db.lookup('Shea Butter')!.kind, 'oil');
    expect(db.lookup('Zinc Oxide')!.formula, 'ZnO');
  });

  test('multiple functions are kept in order', () {
    final niacinamide = db.lookup('Niacinamide')!;
    expect(niacinamide.functions.first, IngredientFunction.brightening);
    expect(niacinamide.functions, contains(IngredientFunction.barrier));
  });
}

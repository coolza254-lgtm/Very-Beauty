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
    expect(db.all.length, greaterThan(250));
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
    // Every function code in the file is known.
    expect(
      db.all.where((i) => i.function == IngredientFunction.other).length,
      lessThan(db.all.length ~/ 5),
    );
  });

  test('covers cleansers and sunscreens', () {
    expect(
      db.all.where((i) => i.usedIn.contains('sunscreen')).length,
      greaterThan(80),
    );
    expect(
      db.all.where((i) => i.usedIn.contains('cleanser')).length,
      greaterThan(100),
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
    ]) {
      final popular = db.popularFor(c);
      expect(popular, isNotEmpty, reason: c.name);
      expect(popular.length, db.popular[c.name]!.length, reason: c.name);
    }
    expect(db.popularFor(ProductCategory.other), isEmpty);
  });
}

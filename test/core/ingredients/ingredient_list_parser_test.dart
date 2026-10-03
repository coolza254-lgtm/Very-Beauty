import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/ingredients/ingredient_db.dart';
import 'package:very_beauty/core/ingredients/ingredient_list_parser.dart';

void main() {
  group('parseIngredientList', () {
    test('website text with heading, footnotes and directions', () {
      const text = '''
Key benefits: calms skin.
Ingredients: Water (Aqua/Eau), Glycerin, Niacinamide 5%, Butylene Glycol,
Sodium Hyaluronate*, Centella Asiatica Extract†, Phenoxyethanol.
*Organic ingredient
How to use: apply morning and night.''';
      expect(parseIngredientList(text), [
        'Water (Aqua/Eau)',
        'Glycerin',
        'Niacinamide',
        'Butylene Glycol',
        'Sodium Hyaluronate',
        'Centella Asiatica Extract',
        'Phenoxyethanol',
      ]);
    });

    test('names wrapped over lines stay whole (label/OCR)', () {
      const text = '''
INGREDIENTS: AQUA, BIS-ETHYLHEXYLOXYPHENOL METHOXY-
PHENYL TRIAZINE, POLYACRYLATE
CROSSPOLYMER-6, PEG-
100 STEARATE, ETHYLHEXYL
TRIAZONE.''';
      expect(parseIngredientList(text), [
        'AQUA',
        'BIS-ETHYLHEXYLOXYPHENOL METHOXY-PHENYL TRIAZINE',
        'POLYACRYLATE CROSSPOLYMER-6',
        'PEG-100 STEARATE',
        'ETHYLHEXYL TRIAZONE',
      ]);
    });

    test('Thai heading, bullets, may-contain and one-per-line lists', () {
      expect(parseIngredientList('ส่วนประกอบ: Aqua • Glycerin • Allantoin'), [
        'Aqua',
        'Glycerin',
        'Allantoin',
      ]);
      expect(parseIngredientList('Squalane\nTocopherol\n\nBisabolol'), [
        'Squalane',
        'Tocopherol',
        'Bisabolol',
      ]);
      expect(parseIngredientList('Talc, Mica [+/-: CI 77891, CI 77491]'), [
        'Talc',
        'Mica',
        'CI 77891',
        'CI 77491',
      ]);
      expect(parseIngredientList('Glycerin, glycerin, 12, , .'), ['Glycerin']);
    });
  });

  group('IngredientDb.match', () {
    late IngredientDb db;
    setUpAll(() {
      db = IngredientDb.fromJsonString(
        File(IngredientDb.assetPath).readAsStringSync(),
      );
    });

    test('exact, alias, bracket and slash forms', () {
      expect(db.match('Water (Aqua/Eau)').ingredient?.inci, 'Aqua');
      expect(db.match('Aqua/Water/Eau').ingredient?.inci, 'Aqua');
      expect(db.match('Fragrance (Parfum)').ingredient?.inci, 'Parfum');
      expect(db.match('NIACINAMIDE').ingredient?.inci, 'Niacinamide');
      expect(db.match('NIACINAMIDE').approximate, isFalse);
    });

    test('typos and OCR slips are matched approximately', () {
      final glycerine = db.match('Glycerine');
      expect(glycerine.ingredient?.inci, 'Glycerin');
      expect(glycerine.approximate, isTrue);
      expect(db.match('Niacinarnide').ingredient?.inci, 'Niacinamide');
      expect(
        db
            .match('BIS-ETHYLHEXYLOXYPHENOL METHOXY-PHENYL TRIAZINE')
            .ingredient
            ?.inci,
        'Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine',
      );
      expect(db.match('Unicorn Tears').ingredient, isNull);
      expect(db.match('Zz').ingredient, isNull);
    });
  });
}

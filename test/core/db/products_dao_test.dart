import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';

import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late ProductsDao dao;

  setUp(() {
    db = createTestDatabase();
    dao = ProductsDao(db);
  });
  tearDown(() => db.close());

  test('create with start weight records the first weighing', () async {
    final id = await dao.createProduct(
      ProductDraft(
        name: ' Vitamin C ',
        category: ProductCategory.serum,
        price: 900,
        netContent: 30,
        openedDate: DateTime(2026, 1, 1),
        startWeight: 80,
        emptyBottleWeight: 50,
        ingredients: const ['Vitamin C', 'Ferulic acid', ' '],
      ),
    );
    final d = (await dao.loadDetails(id))!;
    expect(d.product.name, 'Vitamin C');
    expect(d.weighings.single.weight, 80);
    expect(d.metrics.remaining!.percent, 100);
    expect(d.ingredients, ['Ferulic acid', 'Vitamin C']);
  });

  test('name + category alone is enough', () async {
    final id = await dao.createProduct(
      const ProductDraft(name: 'Toner', category: ProductCategory.toner),
    );
    final all = await dao.loadAll();
    expect(all.single.product.id, id);
    expect(all.single.metrics.pricePerUnit, isNull);
  });

  test('weighings, usage and skin scores feed the metrics', () async {
    final id = await dao.createProduct(
      ProductDraft(
        name: 'Cream',
        category: ProductCategory.moisturizer,
        price: 500,
        netContent: 50,
        openedDate: DateTime(2026, 3, 1),
        startWeight: 120,
      ),
    );
    await dao.addWeighing(id, 110, at: DateTime(2026, 3, 11));
    for (final day in [1, 2]) {
      await db
          .into(db.usageLogs)
          .insert(
            UsageLogsCompanion.insert(
              productId: id,
              usedAt: DateTime(2026, 3, day, 8).millisecondsSinceEpoch,
            ),
          );
    }
    await db
        .into(db.dailyEntries)
        .insert(
          DailyEntriesCompanion.insert(
            date: '2026-03-01',
            scoreMoisture: const Value(4),
          ),
        );
    await db
        .into(db.dailyEntries)
        .insert(
          DailyEntriesCompanion.insert(
            date: '2026-03-02',
            scoreMoisture: const Value(2),
            scoreOil: const Value(3),
          ),
        );
    // A day without usage must not count.
    await db
        .into(db.dailyEntries)
        .insert(
          DailyEntriesCompanion.insert(
            date: '2026-03-05',
            scoreMoisture: const Value(5),
          ),
        );

    final d = (await dao.loadDetails(id))!;
    expect(d.metrics.usedGrams, 10);
    expect(d.metrics.dailyUsage, 1);
    expect(d.metrics.costUsed, 100);
    expect(d.usageCount, 2);
    expect(d.metrics.costPerUse, 50);
    expect(d.skinScores.moisture, 3);
    expect(d.skinScores.oil, 3);
    expect(d.skinScores.acne, isNull);
    expect(d.daysWithSkinLog, 2);
  });

  test('first weighing sets start weight and opened date', () async {
    final id = await dao.createProduct(
      const ProductDraft(name: 'Gel', category: ProductCategory.cleanser),
    );
    await dao.addWeighing(id, 95, at: DateTime(2026, 5, 5));
    final p = (await dao.loadDetails(id))!.product;
    expect(p.startWeight, 95);
    expect(p.openedDate, DateTime(2026, 5, 5).millisecondsSinceEpoch);
  });

  test('finish and reopen', () async {
    final id = await dao.createProduct(
      const ProductDraft(name: 'SPF', category: ProductCategory.sunscreen),
    );
    await dao.finishProduct(id, rating: 5, repurchase: true);
    var p = (await dao.loadDetails(id))!.product;
    expect(p.status, ProductStatus.finished);
    expect(p.rating, 5);
    expect(p.repurchase, isTrue);
    expect(p.finishedDate, isNotNull);

    await dao.setStatus(id, ProductStatus.inUse);
    p = (await dao.loadDetails(id))!.product;
    expect(p.status, ProductStatus.inUse);
    expect(p.finishedDate, isNull);
  });

  test('watchAll re-emits when a weighing is added', () async {
    final id = await dao.createProduct(
      const ProductDraft(
        name: 'Oil',
        category: ProductCategory.cleanser,
        netContent: 100,
        startWeight: 200,
      ),
    );
    final stream = dao.watchAll();
    final expectation = expectLater(
      stream.map((l) => l.single.metrics.latestWeight),
      emitsInOrder([200, 150]),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await dao.addWeighing(id, 150);
    await expectation;
  });

  test('editing replaces ingredients', () async {
    final id = await dao.createProduct(
      const ProductDraft(
        name: 'A',
        category: ProductCategory.serum,
        ingredients: ['Niacinamide'],
      ),
    );
    await dao.updateProduct(
      id,
      const ProductDraft(
        name: 'A',
        category: ProductCategory.serum,
        ingredients: ['Retinal'],
      ),
    );
    expect(await dao.ingredientsOf(id), ['Retinal']);
  });

  test('extra categories and photo paths round-trip', () async {
    final id = await dao.createProduct(
      const ProductDraft(
        name: 'Sun Serum',
        category: ProductCategory.sunscreen,
        // Duplicates and the main category are dropped.
        extraCategories: [
          ProductCategory.serum,
          ProductCategory.sunscreen,
          ProductCategory.serum,
        ],
        photoPath: 'photos/products/1.jpg',
        photoThumbPath: 'photos/thumbs/products/1.jpg',
      ),
    );
    final p = (await dao.loadAll())
        .singleWhere((x) => x.product.id == id)
        .product;
    expect(p.categories, [ProductCategory.sunscreen, ProductCategory.serum]);
    expect(p.photoPath, 'photos/products/1.jpg');
    expect(p.photoThumbPath, 'photos/thumbs/products/1.jpg');

    await dao.updateProduct(
      id,
      const ProductDraft(name: 'Sun Serum', category: ProductCategory.serum),
    );
    final updated = (await dao.loadAll())
        .singleWhere((x) => x.product.id == id)
        .product;
    expect(updated.categories, [ProductCategory.serum]);
    expect(updated.extraCategories, isNull);
    expect(updated.photoPath, isNull);
  });

  test('renaming an ingredient merges it on every product', () async {
    final a = await dao.createProduct(
      const ProductDraft(
        name: 'A',
        category: ProductCategory.serum,
        ingredients: ['Polyacrylate', 'Crosspolymer-6', 'Glycerin'],
      ),
    );
    final b = await dao.createProduct(
      const ProductDraft(
        name: 'B',
        category: ProductCategory.serum,
        ingredients: ['Crosspolymer-6'],
      ),
    );
    await dao.renameIngredient('Crosspolymer-6', 'Polyacrylate Crosspolymer-6');
    await dao.renameIngredient('Polyacrylate', 'Polyacrylate Crosspolymer-6');
    expect(await dao.ingredientsOf(a), [
      'Glycerin',
      'Polyacrylate Crosspolymer-6',
    ]);
    expect(await dao.ingredientsOf(b), ['Polyacrylate Crosspolymer-6']);
    expect(await dao.usedIngredientNames(), isNot(contains('Crosspolymer-6')));
  });
}

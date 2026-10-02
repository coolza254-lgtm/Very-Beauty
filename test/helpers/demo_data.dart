import 'package:drift/drift.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

/// Realistic sample data for screenshots and widget tests.
Future<void> seedDemoData(AppDatabase db, {DateTime? now}) async {
  final today = now ?? DateTime.now();
  DateTime daysAgo(int d) =>
      DateTime(today.year, today.month, today.day - d, 21);
  final dao = ProductsDao(db);

  final serum = await dao.createProduct(
    ProductDraft(
      name: 'Vitamin C Glow Serum',
      brand: 'Lumière',
      category: ProductCategory.serum,
      price: 890,
      netContent: 30,
      netUnit: NetUnit.ml,
      openedDate: daysAgo(40),
      paoMonths: 6,
      startWeight: 96,
      emptyBottleWeight: 64,
      ingredients: const ['Ascorbic Acid', 'Ferulic Acid', 'Tocopherol'],
    ),
  );
  await dao.addWeighing(serum, 88.5, at: daysAgo(26));
  await dao.addWeighing(serum, 80.2, at: daysAgo(12));
  await dao.addWeighing(serum, 74.6, at: daysAgo(1));

  final cream = await dao.createProduct(
    ProductDraft(
      name: 'Ceramide Barrier Cream',
      brand: 'Softly',
      category: ProductCategory.moisturizer,
      price: 650,
      netContent: 50,
      openedDate: daysAgo(20),
      startWeight: 140,
    ),
  );
  await dao.addWeighing(cream, 128, at: daysAgo(3));

  final spf = await dao.createProduct(
    ProductDraft(
      name: 'Airy Sun Milk SPF50+',
      brand: 'Sola',
      category: ProductCategory.sunscreen,
      price: 450,
      netContent: 60,
      netUnit: NetUnit.ml,
      openedDate: daysAgo(30),
      startWeight: 95,
      emptyBottleWeight: 30,
    ),
  );
  await dao.addWeighing(spf, 44, at: daysAgo(2));

  final cleanser = await dao.createProduct(
    ProductDraft(
      name: 'Gentle Foam Cleanser',
      brand: 'Pure',
      category: ProductCategory.cleanser,
      price: 320,
      netContent: 150,
      openedDate: daysAgo(15),
    ),
  );
  await dao.createProduct(
    const ProductDraft(
      name: 'Retinal Night Serum',
      brand: 'Lumière',
      category: ProductCategory.serum,
      price: 1290,
      netContent: 30,
      status: ProductStatus.wishlist,
    ),
  );
  final toner = await dao.createProduct(
    ProductDraft(
      name: 'Hydrating Toner',
      category: ProductCategory.toner,
      price: 390,
      netContent: 200,
      openedDate: daysAgo(90),
    ),
  );
  await dao.finishProduct(toner, rating: 4, repurchase: true, at: daysAgo(5));

  // Routine steps and usage.
  final routines = await db.select(db.routines).get();
  final morning = routines.firstWhere(
    (r) => r.timeOfDay == TimeOfDaySlot.morning,
  );
  final evening = routines.firstWhere(
    (r) => r.timeOfDay == TimeOfDaySlot.evening,
  );
  final steps = {
    morning.id: [cleanser, serum, cream, spf],
    evening.id: [cleanser, cream],
  };
  for (final MapEntry(key: routineId, value: ids) in steps.entries) {
    for (final (i, productId) in ids.indexed) {
      await db
          .into(db.routineSteps)
          .insert(
            RoutineStepsCompanion.insert(
              routineId: routineId,
              productId: productId,
              stepOrder: i,
            ),
          );
    }
  }
  for (var d = 1; d <= 30; d++) {
    for (final MapEntry(key: routineId, value: ids) in steps.entries) {
      for (final productId in ids) {
        await db
            .into(db.usageLogs)
            .insert(
              UsageLogsCompanion.insert(
                productId: productId,
                routineId: Value(routineId),
                usedAt: daysAgo(d).millisecondsSinceEpoch,
              ),
            );
      }
    }
    await db
        .into(db.dailyEntries)
        .insert(
          DailyEntriesCompanion.insert(
            date: toDateKey(daysAgo(d)),
            scoreOil: Value(2 + d % 3),
            scoreMoisture: Value(3 + (d % 4 == 0 ? 1 : 0) + (d < 10 ? 1 : 0)),
            scoreAcne: Value(d % 5 == 0 ? 3 : 1 + d % 2),
            scoreRedness: Value(1 + d % 2),
            scoreDullness: Value(d < 10 ? 2 : 3),
            sleepHours: Value(6.0 + d % 3),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/daily_log_dao.dart';
import 'package:very_beauty/core/db/products_dao.dart';
import 'package:very_beauty/core/db/routines_dao.dart';

import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late RoutinesDao routines;
  late ProductsDao products;
  late int morningId;
  late int a, b, c;

  setUp(() async {
    db = createTestDatabase();
    routines = RoutinesDao(db);
    products = ProductsDao(db);
    morningId = (await routines.loadAll()).first.routine.id;
    a = await products.createProduct(
      const ProductDraft(name: 'A', category: ProductCategory.cleanser),
    );
    b = await products.createProduct(
      const ProductDraft(name: 'B', category: ProductCategory.serum),
    );
    c = await products.createProduct(
      const ProductDraft(name: 'C', category: ProductCategory.sunscreen),
    );
  });
  tearDown(() => db.close());

  Future<RoutineWithSteps> morning() async =>
      (await routines.loadAll()).firstWhere((r) => r.routine.id == morningId);

  test('add, dedupe, reorder and remove steps', () async {
    await routines.addSteps(morningId, [a, b]);
    await routines.addSteps(morningId, [b, c]); // b is skipped
    var r = await morning();
    expect(r.steps.map((s) => s.product.name), ['A', 'B', 'C']);

    await routines.reorderSteps([
      r.steps[2].step.id,
      r.steps[0].step.id,
      r.steps[1].step.id,
    ]);
    r = await morning();
    expect(r.steps.map((s) => s.product.name), ['C', 'A', 'B']);

    await routines.removeStep(r.steps.first.step.id);
    r = await morning();
    expect(r.steps.map((s) => s.product.name), ['A', 'B']);
  });

  test('only in-use products count as active steps', () async {
    await routines.addSteps(morningId, [a, b]);
    await products.finishProduct(b);
    expect((await morning()).activeSteps.map((s) => s.product.name), ['A']);
  });

  test('toggle usage and "done as usual" for a day', () async {
    await routines.addSteps(morningId, [a, b, c]);
    final day = DateTime(2026, 3, 4);
    final r = await morning();

    await routines.toggleUsage(routineId: morningId, productId: a, day: day);
    var progress = await routines.watchProgress(day).first;
    var p = progress.firstWhere((x) => x.routine.routine.id == morningId);
    expect(p.done, 1);
    expect(p.total, 3);

    await routines.completeRoutine(r, day);
    progress = await routines.watchProgress(day).first;
    p = progress.firstWhere((x) => x.routine.routine.id == morningId);
    expect(p.isComplete, isTrue);
    expect(await db.select(db.usageLogs).get(), hasLength(3)); // no duplicates

    await routines.toggleUsage(routineId: morningId, productId: a, day: day);
    expect(await db.select(db.usageLogs).get(), hasLength(2));

    // Other days are independent.
    final other = await routines.watchProgress(DateTime(2026, 3, 5)).first;
    expect(other.firstWhere((x) => x.routine.routine.id == morningId).done, 0);
  });

  test('deleting a routine keeps usage history', () async {
    await routines.addSteps(morningId, [a]);
    await routines.toggleUsage(
      routineId: morningId,
      productId: a,
      day: DateTime(2026, 3, 4),
    );
    await routines.deleteRoutine(morningId);
    final logs = await db.select(db.usageLogs).get();
    expect(logs.single.routineId, isNull);
  });

  group('daily log', () {
    test('partial save, update and tags', () async {
      final dao = DailyLogDao(db);
      final tags = await dao.watchTags().first;
      final irritation = tags.firstWhere((t) => t.name == 'ระคายเคือง').id;
      final custom = await dao.addTag('ผิวแห้งตึง', TagType.symptom);
      expect(await dao.addTag(' ผิวแห้งตึง ', TagType.symptom), custom);

      await dao.saveEntry(
        '2026-03-04',
        DailyLogDraft(scoreOil: 3, tagIds: {irritation, custom}),
      );
      var e = (await dao.loadEntry('2026-03-04'))!;
      expect(e.entry.scoreOil, 3);
      expect(e.entry.scoreAcne, isNull);
      expect(e.tagIds, {irritation, custom});

      await dao.saveEntry(
        '2026-03-04',
        const DailyLogDraft(
          scoreAcne: 2,
          periodPhase: PeriodPhase.luteal,
          note: '  ',
        ),
      );
      e = (await dao.loadEntry('2026-03-04'))!;
      expect(e.entry.scoreOil, isNull);
      expect(e.entry.scoreAcne, 2);
      expect(e.entry.periodPhase, 'luteal');
      expect(e.entry.note, isNull);
      expect(e.tagIds, isEmpty);
      expect(await db.select(db.dailyEntries).get(), hasLength(1));
      expect(DailyLogDraft.fromEntry(e).periodPhase, PeriodPhase.luteal);
    });

    test('ensureEntry is idempotent', () async {
      final dao = DailyLogDao(db);
      final id = await dao.ensureEntry('2026-03-04');
      expect(await dao.ensureEntry('2026-03-04'), id);
    });
  });
}

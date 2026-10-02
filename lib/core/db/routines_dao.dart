import 'package:drift/drift.dart';

import '../utils/date_utils.dart';
import 'app_database.dart';
import 'tables.dart';

part 'routines_dao.g.dart';

class RoutineStepItem {
  const RoutineStepItem({required this.step, required this.product});

  final RoutineStep step;
  final Product product;
}

class RoutineWithSteps {
  const RoutineWithSteps({required this.routine, required this.steps});

  final Routine routine;

  /// In step order.
  final List<RoutineStepItem> steps;

  /// Steps whose product is currently in use — what Today shows.
  List<RoutineStepItem> get activeSteps =>
      steps.where((s) => s.product.status == ProductStatus.inUse).toList();
}

/// A routine with today's progress, for the Today checklist.
class RoutineProgress {
  const RoutineProgress({required this.routine, required this.usedProductIds});

  final RoutineWithSteps routine;

  /// Products already logged for this routine on the day.
  final Set<int> usedProductIds;

  int get total => routine.activeSteps.length;
  int get done => routine.activeSteps
      .where((s) => usedProductIds.contains(s.product.id))
      .length;
  bool get isComplete => total > 0 && done == total;
}

@DriftAccessor(tables: [Routines, RoutineSteps, Products, UsageLogs])
class RoutinesDao extends DatabaseAccessor<AppDatabase>
    with _$RoutinesDaoMixin {
  RoutinesDao(super.attachedDatabase);

  Stream<List<RoutineWithSteps>> watchAll() =>
      attachedDatabase.watchTables([routines, routineSteps, products], loadAll);

  Future<List<RoutineWithSteps>> loadAll() async {
    final all = await (select(
      routines,
    )..orderBy([(r) => OrderingTerm.asc(r.id)])).get();
    final rows = await (select(routineSteps).join([
      innerJoin(products, products.id.equalsExp(routineSteps.productId)),
    ])..orderBy([OrderingTerm.asc(routineSteps.stepOrder)])).get();
    final byRoutine = <int, List<RoutineStepItem>>{};
    for (final row in rows) {
      final step = row.readTable(routineSteps);
      byRoutine
          .putIfAbsent(step.routineId, () => [])
          .add(RoutineStepItem(step: step, product: row.readTable(products)));
    }
    return [
      for (final r in all)
        RoutineWithSteps(routine: r, steps: byRoutine[r.id] ?? const []),
    ];
  }

  Stream<RoutineWithSteps?> watchOne(int id) =>
      watchAll().map((all) => all.where((r) => r.routine.id == id).firstOrNull);

  /// Routines with the products already used on [day] (local date).
  Stream<List<RoutineProgress>> watchProgress(DateTime day) => attachedDatabase
      .watchTables([routines, routineSteps, products, usageLogs], () async {
        final all = await loadAll();
        final used = await _usedOn(day);
        return [
          for (final r in all)
            RoutineProgress(
              routine: r,
              usedProductIds: used[r.routine.id] ?? const {},
            ),
        ];
      });

  Future<int> createRoutine(String name, TimeOfDaySlot slot) =>
      into(routines)
          .insert(RoutinesCompanion.insert(name: name.trim(), timeOfDay: slot));

  Future<void> updateRoutine(
    int id, {
    required String name,
    required TimeOfDaySlot slot,
    required String? reminderTime,
    required bool reminderEnabled,
  }) => (update(routines)..where((r) => r.id.equals(id))).write(
    RoutinesCompanion(
      name: Value(name.trim()),
      timeOfDay: Value(slot),
      reminderTime: Value(reminderTime),
      reminderEnabled: Value(reminderEnabled),
      updatedAt: Value(nowEpochMs()),
    ),
  );

  Future<void> deleteRoutine(int id) =>
      (delete(routines)..where((r) => r.id.equals(id))).go();

  /// Appends products to the end of a routine, skipping ones already in it.
  Future<void> addSteps(int routineId, List<int> productIds) =>
      transaction(() async {
        final existing = await (select(
          routineSteps,
        )..where((s) => s.routineId.equals(routineId))).get();
        final present = existing.map((s) => s.productId).toSet();
        var order = existing.fold<int>(
          -1,
          (m, s) => s.stepOrder > m ? s.stepOrder : m,
        );
        for (final productId in productIds) {
          if (!present.add(productId)) continue;
          await into(routineSteps).insert(
            RoutineStepsCompanion.insert(
              routineId: routineId,
              productId: productId,
              stepOrder: ++order,
            ),
          );
        }
      });

  Future<void> removeStep(int stepId) =>
      (delete(routineSteps)..where((s) => s.id.equals(stepId))).go();

  /// Persists a new order given step ids from first to last.
  Future<void> reorderSteps(List<int> stepIds) => batch((b) {
    for (final (i, id) in stepIds.indexed) {
      b.update(
        routineSteps,
        RoutineStepsCompanion(stepOrder: Value(i)),
        where: (s) => s.id.equals(id),
      );
    }
  });

  /// Ticks or unticks one product for a routine on [day].
  Future<void> toggleUsage({
    required int routineId,
    required int productId,
    required DateTime day,
  }) => transaction(() async {
    final existing = await _usageQuery(routineId, productId, day).get();
    if (existing.isNotEmpty) {
      await (delete(
        usageLogs,
      )..where((u) => u.id.isIn(existing.map((e) => e.id)))).go();
    } else {
      await into(usageLogs).insert(
        UsageLogsCompanion.insert(
          productId: productId,
          routineId: Value(routineId),
          usedAt: _timestampFor(day),
        ),
      );
    }
  });

  /// "ใช้ตามปกติ": logs every active step not yet logged on [day].
  Future<void> completeRoutine(RoutineWithSteps routine, DateTime day) =>
      transaction(() async {
        for (final s in routine.activeSteps) {
          final existing = await _usageQuery(
            routine.routine.id,
            s.product.id,
            day,
          ).get();
          if (existing.isEmpty) {
            await into(usageLogs).insert(
              UsageLogsCompanion.insert(
                productId: s.product.id,
                routineId: Value(routine.routine.id),
                usedAt: _timestampFor(day),
              ),
            );
          }
        }
      });

  SimpleSelectStatement<$UsageLogsTable, UsageLog> _usageQuery(
    int routineId,
    int productId,
    DateTime day,
  ) {
    final (start, end) = dayRangeMs(day);
    return select(usageLogs)..where(
      (u) =>
          u.routineId.equals(routineId) &
          u.productId.equals(productId) &
          u.usedAt.isBetweenValues(start, end - 1),
    );
  }

  Future<Map<int, Set<int>>> _usedOn(DateTime day) async {
    final (start, end) = dayRangeMs(day);
    final logs = await (select(
      usageLogs,
    )..where((u) => u.usedAt.isBetweenValues(start, end - 1))).get();
    final result = <int, Set<int>>{};
    for (final l in logs) {
      if (l.routineId == null) continue;
      result.putIfAbsent(l.routineId!, () => {}).add(l.productId);
    }
    return result;
  }

  /// Now when logging today; midday when back-filling another day.
  int _timestampFor(DateTime day) {
    final now = DateTime.now();
    if (toDateKey(now) == toDateKey(day)) return now.millisecondsSinceEpoch;
    return DateTime(day.year, day.month, day.day, 12).millisecondsSinceEpoch;
  }
}

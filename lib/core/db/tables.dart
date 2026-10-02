// Drift column checks reference the column getter itself by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'enums.dart';

/// Current time as epoch milliseconds (UTC), the storage format for all
/// timestamps except `daily_entries.date`.
int nowEpochMs() => DateTime.now().millisecondsSinceEpoch;

/// Columns shared by every table: `id`, `created_at`, `updated_at`.
mixin BaseColumns on Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get createdAt => integer().clientDefault(nowEpochMs)();
  IntColumn get updatedAt => integer().clientDefault(nowEpochMs)();
}

@DataClassName('Product')
class Products extends Table with BaseColumns {
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get brand => text().nullable()();
  TextColumn get category => text().map(productCategoryConverter)();
  RealColumn get price => real().nullable()();
  RealColumn get netContent => real().nullable()();
  TextColumn get netUnit =>
      text().map(netUnitConverter).withDefault(const Constant('g'))();
  TextColumn get purchasePlace => text().nullable()();
  IntColumn get purchaseDate => integer().nullable()();
  IntColumn get openedDate => integer().nullable()();
  IntColumn get paoMonths => integer().nullable()();
  IntColumn get expiryDate => integer().nullable()();

  /// Weight in grams including the container, recorded once when opened.
  RealColumn get startWeight => real().nullable()();

  /// Weight of the empty container in grams, if known.
  RealColumn get emptyBottleWeight => real().nullable()();
  TextColumn get status => text()
      .map(productStatusConverter)
      .withDefault(const Constant('in_use'))();
  IntColumn get rating =>
      integer().nullable().check(rating.isBetweenValues(1, 5))();
  BoolColumn get repurchase => boolean().nullable()();
  TextColumn get note => text().nullable()();

  /// When the product was closed as finished. Added in schema v2.
  IntColumn get finishedDate => integer().nullable()();

  /// Added in schema v3 for barcode scanning, which was later removed at the
  /// user's request. Kept (unused) so existing v3 databases stay valid.
  TextColumn get barcode => text().nullable()();

  /// More categories besides [category] (the main one, used for the icon),
  /// e.g. a sunscreen that is also a serum. Added in schema v4.
  TextColumn get extraCategories =>
      text().map(const ProductCategoryListConverter()).nullable()();

  /// Product photo and its thumbnail, relative to the documents directory
  /// (under `photos/products/`). Added in schema v4.
  TextColumn get photoPath => text().nullable()();
  TextColumn get photoThumbPath => text().nullable()();
}

@DataClassName('WeightLog')
@TableIndex(name: 'idx_weight_logs_product', columns: {#productId, #weighedAt})
class WeightLogs extends Table with BaseColumns {
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get weighedAt => integer()();

  /// Grams, including the container.
  RealColumn get weight => real()();
  TextColumn get note => text().nullable()();
}

@DataClassName('Routine')
class Routines extends Table with BaseColumns {
  TextColumn get name => text()();
  TextColumn get timeOfDay => text().map(timeOfDaySlotConverter)();

  /// Local time as `HH:mm`.
  TextColumn get reminderTime => text().nullable()();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();
}

@DataClassName('RoutineStep')
@TableIndex(
  name: 'idx_routine_steps_routine',
  columns: {#routineId, #stepOrder},
)
class RoutineSteps extends Table with BaseColumns {
  IntColumn get routineId =>
      integer().references(Routines, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get stepOrder => integer()();
}

/// One row = one product used once.
@DataClassName('UsageLog')
@TableIndex(name: 'idx_usage_logs_product', columns: {#productId, #usedAt})
@TableIndex(name: 'idx_usage_logs_used_at', columns: {#usedAt})
class UsageLogs extends Table with BaseColumns {
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get routineId => integer().nullable().references(
    Routines,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get usedAt => integer()();
  TextColumn get area => text().nullable()();
  TextColumn get note => text().nullable()();
}

/// One row = one day. All scores are 1–5 and optional.
@DataClassName('DailyEntry')
class DailyEntries extends Table with BaseColumns {
  /// Local date as `YYYY-MM-DD`.
  TextColumn get date => text().unique().withLength(min: 10, max: 10)();
  IntColumn get scoreOil =>
      integer().nullable().check(scoreOil.isBetweenValues(1, 5))();
  IntColumn get scoreMoisture =>
      integer().nullable().check(scoreMoisture.isBetweenValues(1, 5))();
  IntColumn get scoreAcne =>
      integer().nullable().check(scoreAcne.isBetweenValues(1, 5))();
  IntColumn get scoreRedness =>
      integer().nullable().check(scoreRedness.isBetweenValues(1, 5))();
  IntColumn get scoreDullness =>
      integer().nullable().check(scoreDullness.isBetweenValues(1, 5))();
  RealColumn get sleepHours => real().nullable()();
  IntColumn get stressLevel =>
      integer().nullable().check(stressLevel.isBetweenValues(1, 5))();
  TextColumn get sunExposure => text().map(sunExposureConverter).nullable()();
  TextColumn get periodPhase => text().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('Photo')
@TableIndex(name: 'idx_photos_taken_at', columns: {#takenAt})
class Photos extends Table with BaseColumns {
  IntColumn get dailyEntryId =>
      integer().references(DailyEntries, #id, onDelete: KeyAction.restrict)();
  IntColumn get takenAt => integer()();

  /// Path relative to the app documents directory.
  TextColumn get filePath => text()();

  /// Path relative to the app documents directory.
  TextColumn get thumbPath => text()();
  TextColumn get session => text().map(timeOfDaySlotConverter)();
  TextColumn get note => text().nullable()();
}

@DataClassName('Tag')
class Tags extends Table with BaseColumns {
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get type => text().map(tagTypeConverter)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, type},
  ];
}

@DataClassName('EntryTag')
class EntryTags extends Table {
  IntColumn get entryId =>
      integer().references(DailyEntries, #id, onDelete: KeyAction.cascade)();
  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {entryId, tagId};
}

@DataClassName('ProductTag')
class ProductTags extends Table {
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {productId, tagId};
}

@DataClassName('AppSetting')
class AppSettings extends Table with BaseColumns {
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

import 'package:drift/drift.dart';

import '../utils/calculations.dart';
import '../utils/date_utils.dart';
import 'app_database.dart';
import 'tables.dart';

part 'products_dao.g.dart';

/// A product with the numbers derived from its weighings and usage.
class ProductWithMetrics {
  const ProductWithMetrics({
    required this.product,
    required this.metrics,
    required this.usageCount,
  });

  final Product product;
  final ProductMetrics metrics;
  final int usageCount;
}

/// Everything shown on the product detail screen.
class ProductDetails {
  const ProductDetails({
    required this.product,
    required this.metrics,
    required this.weighings,
    required this.usageCount,
    required this.ingredients,
    required this.skinScores,
    required this.daysWithSkinLog,
  });

  final Product product;
  final ProductMetrics metrics;

  /// Oldest first.
  final List<WeightLog> weighings;
  final int usageCount;
  final List<String> ingredients;

  /// Average of each `score_*` on days the product was used.
  final SkinScoreAverages skinScores;
  final int daysWithSkinLog;
}

class SkinScoreAverages {
  const SkinScoreAverages({
    this.oil,
    this.moisture,
    this.acne,
    this.redness,
    this.dullness,
  });

  final double? oil;
  final double? moisture;
  final double? acne;
  final double? redness;
  final double? dullness;

  bool get isEmpty =>
      oil == null &&
      moisture == null &&
      acne == null &&
      redness == null &&
      dullness == null;

  factory SkinScoreAverages.of(List<DailyEntry> entries) => SkinScoreAverages(
    oil: average(entries.map((e) => e.scoreOil)),
    moisture: average(entries.map((e) => e.scoreMoisture)),
    acne: average(entries.map((e) => e.scoreAcne)),
    redness: average(entries.map((e) => e.scoreRedness)),
    dullness: average(entries.map((e) => e.scoreDullness)),
  );
}

/// Form values for creating or editing a product.
class ProductDraft {
  const ProductDraft({
    required this.name,
    required this.category,
    this.brand,
    this.price,
    this.netContent,
    this.netUnit = NetUnit.g,
    this.status = ProductStatus.inUse,
    this.purchasePlace,
    this.purchaseDate,
    this.openedDate,
    this.paoMonths,
    this.expiryDate,
    this.startWeight,
    this.emptyBottleWeight,
    this.note,
    this.ingredients = const [],
    this.extraCategories = const [],
    this.photoPath,
    this.photoThumbPath,
  });

  final String name;

  /// Main category (drives the icon and colour).
  final ProductCategory category;

  /// Further categories the product also belongs to.
  final List<ProductCategory> extraCategories;

  /// Photo paths relative to the documents directory.
  final String? photoPath;
  final String? photoThumbPath;
  final String? brand;
  final double? price;
  final double? netContent;
  final NetUnit netUnit;
  final ProductStatus status;
  final String? purchasePlace;
  final DateTime? purchaseDate;
  final DateTime? openedDate;
  final int? paoMonths;
  final DateTime? expiryDate;
  final double? startWeight;
  final double? emptyBottleWeight;
  final String? note;
  final List<String> ingredients;

  ProductsCompanion toCompanion() => ProductsCompanion(
    name: Value(name.trim()),
    category: Value(category),
    brand: Value(_blankToNull(brand)),
    price: Value(price),
    netContent: Value(netContent),
    netUnit: Value(netUnit),
    status: Value(status),
    purchasePlace: Value(_blankToNull(purchasePlace)),
    purchaseDate: Value(purchaseDate?.millisecondsSinceEpoch),
    openedDate: Value(openedDate?.millisecondsSinceEpoch),
    paoMonths: Value(paoMonths),
    expiryDate: Value(expiryDate?.millisecondsSinceEpoch),
    startWeight: Value(startWeight),
    emptyBottleWeight: Value(emptyBottleWeight),
    note: Value(_blankToNull(note)),
    extraCategories: Value(_extras.isEmpty ? null : _extras),
    photoPath: Value(photoPath),
    photoThumbPath: Value(photoThumbPath),
  );

  List<ProductCategory> get _extras => [
    for (final c in extraCategories.toSet())
      if (c != category) c,
  ];
}

extension ProductCategories on Product {
  /// Main category first, then the extra ones.
  List<ProductCategory> get categories => [
    category,
    for (final c in extraCategories ?? const <ProductCategory>[])
      if (c != category) c,
  ];
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return t == null || t.isEmpty ? null : t;
}

@DriftAccessor(
  tables: [Products, WeightLogs, UsageLogs, Tags, ProductTags, DailyEntries],
)
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  ProductsDao(super.attachedDatabase);

  late final _watched = <TableInfo<Table, dynamic>>[
    products,
    weightLogs,
    usageLogs,
  ];

  /// All products with metrics, newest first. Filtering happens in Dart
  /// because a personal shelf is small.
  Stream<List<ProductWithMetrics>> watchAll() =>
      attachedDatabase.watchTables(_watched, loadAll);

  Future<List<ProductWithMetrics>> loadAll() async {
    final all = await (select(
      products,
    )..orderBy([(p) => OrderingTerm.desc(p.createdAt)])).get();
    if (all.isEmpty) return const [];

    final logs = await (select(
      weightLogs,
    )..orderBy([(w) => OrderingTerm.asc(w.weighedAt)])).get();
    final logsByProduct = <int, List<WeightLog>>{};
    for (final log in logs) {
      logsByProduct.putIfAbsent(log.productId, () => []).add(log);
    }
    final counts = await _usageCounts();

    return [
      for (final p in all)
        ProductWithMetrics(
          product: p,
          metrics: _metrics(p, logsByProduct[p.id] ?? const [], counts[p.id]),
          usageCount: counts[p.id] ?? 0,
        ),
    ];
  }

  Stream<ProductDetails?> watchDetails(int id) => attachedDatabase.watchTables([
    ..._watched,
    productTags,
    tags,
    dailyEntries,
  ], () => loadDetails(id));

  Future<ProductDetails?> loadDetails(int id) async {
    final product = await (select(
      products,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    if (product == null) return null;

    final logs =
        await (select(weightLogs)
              ..where((w) => w.productId.equals(id))
              ..orderBy([(w) => OrderingTerm.asc(w.weighedAt)]))
            .get();
    final usedAt =
        await (selectOnly(usageLogs)
              ..addColumns([usageLogs.usedAt])
              ..where(usageLogs.productId.equals(id)))
            .map((r) => r.read(usageLogs.usedAt)!)
            .get();
    final dateKeys = {for (final ms in usedAt) toDateKey(fromEpochMs(ms))};
    final entries = dateKeys.isEmpty
        ? const <DailyEntry>[]
        : await (select(
            dailyEntries,
          )..where((e) => e.date.isIn(dateKeys))).get();

    return ProductDetails(
      product: product,
      metrics: _metrics(product, logs, usedAt.length),
      weighings: logs,
      usageCount: usedAt.length,
      ingredients: await ingredientsOf(id),
      skinScores: SkinScoreAverages.of(entries),
      daysWithSkinLog: entries.length,
    );
  }

  Future<List<String>> ingredientsOf(int productId) {
    final query =
        select(
            tags,
          ).join([innerJoin(productTags, productTags.tagId.equalsExp(tags.id))])
          ..where(productTags.productId.equals(productId))
          ..orderBy([OrderingTerm.asc(tags.name)]);
    return query.map((row) => row.readTable(tags).name).get();
  }

  /// Ingredient names the user has saved on any product, for suggestions.
  Future<List<String>> usedIngredientNames() {
    final query = selectOnly(tags, distinct: true)
      ..addColumns([tags.name])
      ..join([innerJoin(productTags, productTags.tagId.equalsExp(tags.id))])
      ..where(tags.type.equals(tagTypeConverter.toSql(TagType.ingredient)))
      ..orderBy([OrderingTerm.asc(tags.name)]);
    return query.map((row) => row.read(tags.name)!).get();
  }

  /// Products whose ingredients include any of [names] (case-insensitive).
  Stream<List<Product>> watchProductsWithIngredient(Iterable<String> names) {
    final lower = {for (final n in names) n.toLowerCase()};
    final query =
        select(products).join([
            innerJoin(
              productTags,
              productTags.productId.equalsExp(products.id),
            ),
            innerJoin(tags, tags.id.equalsExp(productTags.tagId)),
          ])
          ..where(
            tags.type.equals(tagTypeConverter.toSql(TagType.ingredient)) &
                tags.name.lower().isIn(lower),
          )
          ..orderBy([OrderingTerm.asc(products.name)]);
    return query.watch().map(
      (rows) => {
        for (final r in rows) r.readTable(products).id: r.readTable(products),
      }.values.toList(),
    );
  }

  /// Inserts a product. If a start weight is given, also records the first
  /// weighing (docs/SPEC.md §5 weight_logs).
  Future<int> createProduct(ProductDraft draft) => transaction(() async {
    final id = await into(products).insert(draft.toCompanion());
    if (draft.startWeight != null) {
      await into(weightLogs).insert(
        WeightLogsCompanion.insert(
          productId: id,
          weighedAt:
              (draft.openedDate ?? DateTime.now()).millisecondsSinceEpoch,
          weight: draft.startWeight!,
        ),
      );
    }
    await _setIngredients(id, draft.ingredients);
    return id;
  });

  Future<void> updateProduct(
    int id,
    ProductDraft draft,
  ) => transaction(() async {
    final previous = await (select(
      products,
    )..where((p) => p.id.equals(id))).getSingle();
    await (update(products)..where((p) => p.id.equals(id))).write(
      draft.toCompanion().copyWith(updatedAt: Value(nowEpochMs())),
    );
    final hasLogs = await (select(
      weightLogs,
    )..where((w) => w.productId.equals(id))).get().then((l) => l.isNotEmpty);
    if (previous.startWeight == null && draft.startWeight != null && !hasLogs) {
      await into(weightLogs).insert(
        WeightLogsCompanion.insert(
          productId: id,
          weighedAt:
              (draft.openedDate ?? DateTime.now()).millisecondsSinceEpoch,
          weight: draft.startWeight!,
        ),
      );
    }
    await _setIngredients(id, draft.ingredients);
  });

  Future<void> deleteProduct(int id) =>
      (delete(products)..where((p) => p.id.equals(id))).go();

  /// Records a weighing. The first weighing of a product also becomes its
  /// start weight, and opening date if none was set.
  Future<void> addWeighing(
    int productId,
    double grams, {
    DateTime? at,
    String? note,
  }) => transaction(() async {
    final when = at ?? DateTime.now();
    await into(weightLogs).insert(
      WeightLogsCompanion.insert(
        productId: productId,
        weighedAt: when.millisecondsSinceEpoch,
        weight: grams,
        note: Value(_blankToNull(note)),
      ),
    );
    final product = await (select(
      products,
    )..where((p) => p.id.equals(productId))).getSingle();
    if (product.startWeight == null) {
      await (update(products)..where((p) => p.id.equals(productId))).write(
        ProductsCompanion(
          startWeight: Value(grams),
          openedDate: Value(product.openedDate ?? when.millisecondsSinceEpoch),
          updatedAt: Value(nowEpochMs()),
        ),
      );
    }
  });

  Future<void> deleteWeighing(int id) =>
      (delete(weightLogs)..where((w) => w.id.equals(id))).go();

  /// Closes a product as used up, with an optional rating and repurchase
  /// decision.
  Future<void> finishProduct(
    int id, {
    int? rating,
    bool? repurchase,
    DateTime? at,
  }) => (update(products)..where((p) => p.id.equals(id))).write(
    ProductsCompanion(
      status: const Value(ProductStatus.finished),
      rating: Value(rating),
      repurchase: Value(repurchase),
      finishedDate: Value((at ?? DateTime.now()).millisecondsSinceEpoch),
      updatedAt: Value(nowEpochMs()),
    ),
  );

  /// Moves a product to another status; leaving "finished" clears its
  /// finish date. Opening a wishlist item for use stamps today's date.
  Future<void> setStatus(int id, ProductStatus status) async {
    final product = await (select(
      products,
    )..where((p) => p.id.equals(id))).getSingle();
    await (update(products)..where((p) => p.id.equals(id))).write(
      ProductsCompanion(
        status: Value(status),
        finishedDate: status == ProductStatus.finished
            ? Value(product.finishedDate ?? nowEpochMs())
            : const Value(null),
        openedDate: status == ProductStatus.inUse && product.openedDate == null
            ? Value(nowEpochMs())
            : Value(product.openedDate),
        updatedAt: Value(nowEpochMs()),
      ),
    );
  }

  Future<void> _setIngredients(int productId, List<String> names) async {
    await (delete(
      productTags,
    )..where((t) => t.productId.equals(productId))).go();
    final cleaned = {
      for (final n in names)
        if (n.trim().isNotEmpty) n.trim(),
    };
    for (final name in cleaned) {
      final tagId = await _tagId(name, TagType.ingredient);
      await into(productTags).insert(
        ProductTagsCompanion.insert(productId: productId, tagId: tagId),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }

  Future<int> _tagId(String name, TagType type) async {
    final existing =
        await (select(tags)..where(
              (t) =>
                  t.name.equals(name) &
                  t.type.equals(tagTypeConverter.toSql(type)),
            ))
            .getSingleOrNull();
    return existing?.id ??
        into(tags).insert(TagsCompanion.insert(name: name, type: type));
  }

  Future<Map<int, int>> _usageCounts() async {
    final count = usageLogs.id.count();
    final rows =
        await (selectOnly(usageLogs)
              ..addColumns([usageLogs.productId, count])
              ..groupBy([usageLogs.productId]))
            .get();
    return {for (final r in rows) r.read(usageLogs.productId)!: r.read(count)!};
  }

  ProductMetrics _metrics(Product p, List<WeightLog> logs, int? usageCount) =>
      computeProductMetrics(
        ProductInputs(
          price: p.price,
          netContent: p.netContent,
          isMillilitres: p.netUnit == NetUnit.ml,
          startWeight: p.startWeight,
          emptyBottleWeight: p.emptyBottleWeight,
          openedDate: p.openedDate == null ? null : fromEpochMs(p.openedDate!),
          weighings: [
            for (final l in logs)
              WeighPoint(fromEpochMs(l.weighedAt), l.weight),
          ],
          usageCount: usageCount ?? 0,
        ),
      );
}

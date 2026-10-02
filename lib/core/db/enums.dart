import 'package:drift/drift.dart';

/// Enums stored in the database as snake_case text (see docs/SPEC.md §5).
///
/// Never rename a value's [Enum.name] without a migration: the stored text
/// is derived from it.

enum ProductCategory {
  cleanser,
  toner,
  serum,
  moisturizer,
  sunscreen,
  treatment,
  mask,
  other,
}

enum NetUnit { g, ml }

enum ProductStatus { inUse, finished, paused, wishlist }

enum TimeOfDaySlot { morning, evening, other }

enum SunExposure { none, low, high }

enum TagType { symptom, factor, ingredient }

String _toSnakeCase(String camel) => camel.replaceAllMapped(
  RegExp('[A-Z]'),
  (m) => '_${m.group(0)!.toLowerCase()}',
);

/// Maps an enum to/from its snake_case name, e.g. `ProductStatus.inUse` <->
/// `'in_use'`.
class SnakeCaseEnumConverter<T extends Enum> extends TypeConverter<T, String> {
  const SnakeCaseEnumConverter(this.values);

  final List<T> values;

  @override
  T fromSql(String fromDb) => values.firstWhere(
    (v) => _toSnakeCase(v.name) == fromDb,
    orElse: () => throw ArgumentError.value(
      fromDb,
      'fromDb',
      'Unknown value for ${T.toString()}',
    ),
  );

  @override
  String toSql(T value) => _toSnakeCase(value.name);
}

const productCategoryConverter = SnakeCaseEnumConverter<ProductCategory>(
  ProductCategory.values,
);
const netUnitConverter = SnakeCaseEnumConverter<NetUnit>(NetUnit.values);
const productStatusConverter = SnakeCaseEnumConverter<ProductStatus>(
  ProductStatus.values,
);
const timeOfDaySlotConverter = SnakeCaseEnumConverter<TimeOfDaySlot>(
  TimeOfDaySlot.values,
);
const sunExposureConverter = SnakeCaseEnumConverter<SunExposure>(
  SunExposure.values,
);
const tagTypeConverter = SnakeCaseEnumConverter<TagType>(TagType.values);

/// Extra product categories stored as comma-separated snake_case names, e.g.
/// `'serum,moisturizer'`. Unknown names (from a newer app) are skipped.
class ProductCategoryListConverter
    extends TypeConverter<List<ProductCategory>, String> {
  const ProductCategoryListConverter();

  @override
  List<ProductCategory> fromSql(String fromDb) => [
    for (final part in fromDb.split(','))
      if (part.trim().isNotEmpty)
        ?ProductCategory.values
            .where((c) => productCategoryConverter.toSql(c) == part.trim())
            .firstOrNull,
  ];

  @override
  String toSql(List<ProductCategory> value) =>
      value.map(productCategoryConverter.toSql).join(',');
}

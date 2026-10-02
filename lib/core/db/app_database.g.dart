// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProductCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ProductCategory>($ProductsTable.$convertercategory);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _netContentMeta = const VerificationMeta(
    'netContent',
  );
  @override
  late final GeneratedColumn<double> netContent = GeneratedColumn<double>(
    'net_content',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NetUnit, String> netUnit =
      GeneratedColumn<String>(
        'net_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('g'),
      ).withConverter<NetUnit>($ProductsTable.$converternetUnit);
  static const VerificationMeta _purchasePlaceMeta = const VerificationMeta(
    'purchasePlace',
  );
  @override
  late final GeneratedColumn<String> purchasePlace = GeneratedColumn<String>(
    'purchase_place',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<int> purchaseDate = GeneratedColumn<int>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openedDateMeta = const VerificationMeta(
    'openedDate',
  );
  @override
  late final GeneratedColumn<int> openedDate = GeneratedColumn<int>(
    'opened_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paoMonthsMeta = const VerificationMeta(
    'paoMonths',
  );
  @override
  late final GeneratedColumn<int> paoMonths = GeneratedColumn<int>(
    'pao_months',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<int> expiryDate = GeneratedColumn<int>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startWeightMeta = const VerificationMeta(
    'startWeight',
  );
  @override
  late final GeneratedColumn<double> startWeight = GeneratedColumn<double>(
    'start_weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emptyBottleWeightMeta = const VerificationMeta(
    'emptyBottleWeight',
  );
  @override
  late final GeneratedColumn<double> emptyBottleWeight =
      GeneratedColumn<double>(
        'empty_bottle_weight',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ProductStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('in_use'),
      ).withConverter<ProductStatus>($ProductsTable.$converterstatus);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    check: () => ComparableExpr(rating).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repurchaseMeta = const VerificationMeta(
    'repurchase',
  );
  @override
  late final GeneratedColumn<bool> repurchase = GeneratedColumn<bool>(
    'repurchase',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("repurchase" IN (0, 1))',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finishedDateMeta = const VerificationMeta(
    'finishedDate',
  );
  @override
  late final GeneratedColumn<int> finishedDate = GeneratedColumn<int>(
    'finished_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    brand,
    category,
    price,
    netContent,
    netUnit,
    purchasePlace,
    purchaseDate,
    openedDate,
    paoMonths,
    expiryDate,
    startWeight,
    emptyBottleWeight,
    status,
    rating,
    repurchase,
    note,
    finishedDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('net_content')) {
      context.handle(
        _netContentMeta,
        netContent.isAcceptableOrUnknown(data['net_content']!, _netContentMeta),
      );
    }
    if (data.containsKey('purchase_place')) {
      context.handle(
        _purchasePlaceMeta,
        purchasePlace.isAcceptableOrUnknown(
          data['purchase_place']!,
          _purchasePlaceMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('opened_date')) {
      context.handle(
        _openedDateMeta,
        openedDate.isAcceptableOrUnknown(data['opened_date']!, _openedDateMeta),
      );
    }
    if (data.containsKey('pao_months')) {
      context.handle(
        _paoMonthsMeta,
        paoMonths.isAcceptableOrUnknown(data['pao_months']!, _paoMonthsMeta),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('start_weight')) {
      context.handle(
        _startWeightMeta,
        startWeight.isAcceptableOrUnknown(
          data['start_weight']!,
          _startWeightMeta,
        ),
      );
    }
    if (data.containsKey('empty_bottle_weight')) {
      context.handle(
        _emptyBottleWeightMeta,
        emptyBottleWeight.isAcceptableOrUnknown(
          data['empty_bottle_weight']!,
          _emptyBottleWeightMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('repurchase')) {
      context.handle(
        _repurchaseMeta,
        repurchase.isAcceptableOrUnknown(data['repurchase']!, _repurchaseMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('finished_date')) {
      context.handle(
        _finishedDateMeta,
        finishedDate.isAcceptableOrUnknown(
          data['finished_date']!,
          _finishedDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      category: $ProductsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      netContent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_content'],
      ),
      netUnit: $ProductsTable.$converternetUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}net_unit'],
        )!,
      ),
      purchasePlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_place'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_date'],
      ),
      openedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opened_date'],
      ),
      paoMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pao_months'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expiry_date'],
      ),
      startWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_weight'],
      ),
      emptyBottleWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}empty_bottle_weight'],
      ),
      status: $ProductsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      repurchase: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}repurchase'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      finishedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}finished_date'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductCategory, String> $convertercategory =
      productCategoryConverter;
  static TypeConverter<NetUnit, String> $converternetUnit = netUnitConverter;
  static TypeConverter<ProductStatus, String> $converterstatus =
      productStatusConverter;
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final String name;
  final String? brand;
  final ProductCategory category;
  final double? price;
  final double? netContent;
  final NetUnit netUnit;
  final String? purchasePlace;
  final int? purchaseDate;
  final int? openedDate;
  final int? paoMonths;
  final int? expiryDate;

  /// Weight in grams including the container, recorded once when opened.
  final double? startWeight;

  /// Weight of the empty container in grams, if known.
  final double? emptyBottleWeight;
  final ProductStatus status;
  final int? rating;
  final bool? repurchase;
  final String? note;

  /// When the product was closed as finished. Added in schema v2.
  final int? finishedDate;
  const Product({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.brand,
    required this.category,
    this.price,
    this.netContent,
    required this.netUnit,
    this.purchasePlace,
    this.purchaseDate,
    this.openedDate,
    this.paoMonths,
    this.expiryDate,
    this.startWeight,
    this.emptyBottleWeight,
    required this.status,
    this.rating,
    this.repurchase,
    this.note,
    this.finishedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    {
      map['category'] = Variable<String>(
        $ProductsTable.$convertercategory.toSql(category),
      );
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || netContent != null) {
      map['net_content'] = Variable<double>(netContent);
    }
    {
      map['net_unit'] = Variable<String>(
        $ProductsTable.$converternetUnit.toSql(netUnit),
      );
    }
    if (!nullToAbsent || purchasePlace != null) {
      map['purchase_place'] = Variable<String>(purchasePlace);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<int>(purchaseDate);
    }
    if (!nullToAbsent || openedDate != null) {
      map['opened_date'] = Variable<int>(openedDate);
    }
    if (!nullToAbsent || paoMonths != null) {
      map['pao_months'] = Variable<int>(paoMonths);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<int>(expiryDate);
    }
    if (!nullToAbsent || startWeight != null) {
      map['start_weight'] = Variable<double>(startWeight);
    }
    if (!nullToAbsent || emptyBottleWeight != null) {
      map['empty_bottle_weight'] = Variable<double>(emptyBottleWeight);
    }
    {
      map['status'] = Variable<String>(
        $ProductsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || repurchase != null) {
      map['repurchase'] = Variable<bool>(repurchase);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || finishedDate != null) {
      map['finished_date'] = Variable<int>(finishedDate);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      category: Value(category),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      netContent: netContent == null && nullToAbsent
          ? const Value.absent()
          : Value(netContent),
      netUnit: Value(netUnit),
      purchasePlace: purchasePlace == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePlace),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      openedDate: openedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(openedDate),
      paoMonths: paoMonths == null && nullToAbsent
          ? const Value.absent()
          : Value(paoMonths),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      startWeight: startWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(startWeight),
      emptyBottleWeight: emptyBottleWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(emptyBottleWeight),
      status: Value(status),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      repurchase: repurchase == null && nullToAbsent
          ? const Value.absent()
          : Value(repurchase),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      finishedDate: finishedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedDate),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      category: serializer.fromJson<ProductCategory>(json['category']),
      price: serializer.fromJson<double?>(json['price']),
      netContent: serializer.fromJson<double?>(json['netContent']),
      netUnit: serializer.fromJson<NetUnit>(json['netUnit']),
      purchasePlace: serializer.fromJson<String?>(json['purchasePlace']),
      purchaseDate: serializer.fromJson<int?>(json['purchaseDate']),
      openedDate: serializer.fromJson<int?>(json['openedDate']),
      paoMonths: serializer.fromJson<int?>(json['paoMonths']),
      expiryDate: serializer.fromJson<int?>(json['expiryDate']),
      startWeight: serializer.fromJson<double?>(json['startWeight']),
      emptyBottleWeight: serializer.fromJson<double?>(
        json['emptyBottleWeight'],
      ),
      status: serializer.fromJson<ProductStatus>(json['status']),
      rating: serializer.fromJson<int?>(json['rating']),
      repurchase: serializer.fromJson<bool?>(json['repurchase']),
      note: serializer.fromJson<String?>(json['note']),
      finishedDate: serializer.fromJson<int?>(json['finishedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'category': serializer.toJson<ProductCategory>(category),
      'price': serializer.toJson<double?>(price),
      'netContent': serializer.toJson<double?>(netContent),
      'netUnit': serializer.toJson<NetUnit>(netUnit),
      'purchasePlace': serializer.toJson<String?>(purchasePlace),
      'purchaseDate': serializer.toJson<int?>(purchaseDate),
      'openedDate': serializer.toJson<int?>(openedDate),
      'paoMonths': serializer.toJson<int?>(paoMonths),
      'expiryDate': serializer.toJson<int?>(expiryDate),
      'startWeight': serializer.toJson<double?>(startWeight),
      'emptyBottleWeight': serializer.toJson<double?>(emptyBottleWeight),
      'status': serializer.toJson<ProductStatus>(status),
      'rating': serializer.toJson<int?>(rating),
      'repurchase': serializer.toJson<bool?>(repurchase),
      'note': serializer.toJson<String?>(note),
      'finishedDate': serializer.toJson<int?>(finishedDate),
    };
  }

  Product copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    String? name,
    Value<String?> brand = const Value.absent(),
    ProductCategory? category,
    Value<double?> price = const Value.absent(),
    Value<double?> netContent = const Value.absent(),
    NetUnit? netUnit,
    Value<String?> purchasePlace = const Value.absent(),
    Value<int?> purchaseDate = const Value.absent(),
    Value<int?> openedDate = const Value.absent(),
    Value<int?> paoMonths = const Value.absent(),
    Value<int?> expiryDate = const Value.absent(),
    Value<double?> startWeight = const Value.absent(),
    Value<double?> emptyBottleWeight = const Value.absent(),
    ProductStatus? status,
    Value<int?> rating = const Value.absent(),
    Value<bool?> repurchase = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<int?> finishedDate = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    category: category ?? this.category,
    price: price.present ? price.value : this.price,
    netContent: netContent.present ? netContent.value : this.netContent,
    netUnit: netUnit ?? this.netUnit,
    purchasePlace: purchasePlace.present
        ? purchasePlace.value
        : this.purchasePlace,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    openedDate: openedDate.present ? openedDate.value : this.openedDate,
    paoMonths: paoMonths.present ? paoMonths.value : this.paoMonths,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    startWeight: startWeight.present ? startWeight.value : this.startWeight,
    emptyBottleWeight: emptyBottleWeight.present
        ? emptyBottleWeight.value
        : this.emptyBottleWeight,
    status: status ?? this.status,
    rating: rating.present ? rating.value : this.rating,
    repurchase: repurchase.present ? repurchase.value : this.repurchase,
    note: note.present ? note.value : this.note,
    finishedDate: finishedDate.present ? finishedDate.value : this.finishedDate,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      netContent: data.netContent.present
          ? data.netContent.value
          : this.netContent,
      netUnit: data.netUnit.present ? data.netUnit.value : this.netUnit,
      purchasePlace: data.purchasePlace.present
          ? data.purchasePlace.value
          : this.purchasePlace,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      openedDate: data.openedDate.present
          ? data.openedDate.value
          : this.openedDate,
      paoMonths: data.paoMonths.present ? data.paoMonths.value : this.paoMonths,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      startWeight: data.startWeight.present
          ? data.startWeight.value
          : this.startWeight,
      emptyBottleWeight: data.emptyBottleWeight.present
          ? data.emptyBottleWeight.value
          : this.emptyBottleWeight,
      status: data.status.present ? data.status.value : this.status,
      rating: data.rating.present ? data.rating.value : this.rating,
      repurchase: data.repurchase.present
          ? data.repurchase.value
          : this.repurchase,
      note: data.note.present ? data.note.value : this.note,
      finishedDate: data.finishedDate.present
          ? data.finishedDate.value
          : this.finishedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('netContent: $netContent, ')
          ..write('netUnit: $netUnit, ')
          ..write('purchasePlace: $purchasePlace, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('openedDate: $openedDate, ')
          ..write('paoMonths: $paoMonths, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('startWeight: $startWeight, ')
          ..write('emptyBottleWeight: $emptyBottleWeight, ')
          ..write('status: $status, ')
          ..write('rating: $rating, ')
          ..write('repurchase: $repurchase, ')
          ..write('note: $note, ')
          ..write('finishedDate: $finishedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    name,
    brand,
    category,
    price,
    netContent,
    netUnit,
    purchasePlace,
    purchaseDate,
    openedDate,
    paoMonths,
    expiryDate,
    startWeight,
    emptyBottleWeight,
    status,
    rating,
    repurchase,
    note,
    finishedDate,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.category == this.category &&
          other.price == this.price &&
          other.netContent == this.netContent &&
          other.netUnit == this.netUnit &&
          other.purchasePlace == this.purchasePlace &&
          other.purchaseDate == this.purchaseDate &&
          other.openedDate == this.openedDate &&
          other.paoMonths == this.paoMonths &&
          other.expiryDate == this.expiryDate &&
          other.startWeight == this.startWeight &&
          other.emptyBottleWeight == this.emptyBottleWeight &&
          other.status == this.status &&
          other.rating == this.rating &&
          other.repurchase == this.repurchase &&
          other.note == this.note &&
          other.finishedDate == this.finishedDate);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> name;
  final Value<String?> brand;
  final Value<ProductCategory> category;
  final Value<double?> price;
  final Value<double?> netContent;
  final Value<NetUnit> netUnit;
  final Value<String?> purchasePlace;
  final Value<int?> purchaseDate;
  final Value<int?> openedDate;
  final Value<int?> paoMonths;
  final Value<int?> expiryDate;
  final Value<double?> startWeight;
  final Value<double?> emptyBottleWeight;
  final Value<ProductStatus> status;
  final Value<int?> rating;
  final Value<bool?> repurchase;
  final Value<String?> note;
  final Value<int?> finishedDate;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.netContent = const Value.absent(),
    this.netUnit = const Value.absent(),
    this.purchasePlace = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.openedDate = const Value.absent(),
    this.paoMonths = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.startWeight = const Value.absent(),
    this.emptyBottleWeight = const Value.absent(),
    this.status = const Value.absent(),
    this.rating = const Value.absent(),
    this.repurchase = const Value.absent(),
    this.note = const Value.absent(),
    this.finishedDate = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    this.brand = const Value.absent(),
    required ProductCategory category,
    this.price = const Value.absent(),
    this.netContent = const Value.absent(),
    this.netUnit = const Value.absent(),
    this.purchasePlace = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.openedDate = const Value.absent(),
    this.paoMonths = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.startWeight = const Value.absent(),
    this.emptyBottleWeight = const Value.absent(),
    this.status = const Value.absent(),
    this.rating = const Value.absent(),
    this.repurchase = const Value.absent(),
    this.note = const Value.absent(),
    this.finishedDate = const Value.absent(),
  }) : name = Value(name),
       category = Value(category);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? category,
    Expression<double>? price,
    Expression<double>? netContent,
    Expression<String>? netUnit,
    Expression<String>? purchasePlace,
    Expression<int>? purchaseDate,
    Expression<int>? openedDate,
    Expression<int>? paoMonths,
    Expression<int>? expiryDate,
    Expression<double>? startWeight,
    Expression<double>? emptyBottleWeight,
    Expression<String>? status,
    Expression<int>? rating,
    Expression<bool>? repurchase,
    Expression<String>? note,
    Expression<int>? finishedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (netContent != null) 'net_content': netContent,
      if (netUnit != null) 'net_unit': netUnit,
      if (purchasePlace != null) 'purchase_place': purchasePlace,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (openedDate != null) 'opened_date': openedDate,
      if (paoMonths != null) 'pao_months': paoMonths,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (startWeight != null) 'start_weight': startWeight,
      if (emptyBottleWeight != null) 'empty_bottle_weight': emptyBottleWeight,
      if (status != null) 'status': status,
      if (rating != null) 'rating': rating,
      if (repurchase != null) 'repurchase': repurchase,
      if (note != null) 'note': note,
      if (finishedDate != null) 'finished_date': finishedDate,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? name,
    Value<String?>? brand,
    Value<ProductCategory>? category,
    Value<double?>? price,
    Value<double?>? netContent,
    Value<NetUnit>? netUnit,
    Value<String?>? purchasePlace,
    Value<int?>? purchaseDate,
    Value<int?>? openedDate,
    Value<int?>? paoMonths,
    Value<int?>? expiryDate,
    Value<double?>? startWeight,
    Value<double?>? emptyBottleWeight,
    Value<ProductStatus>? status,
    Value<int?>? rating,
    Value<bool?>? repurchase,
    Value<String?>? note,
    Value<int?>? finishedDate,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      price: price ?? this.price,
      netContent: netContent ?? this.netContent,
      netUnit: netUnit ?? this.netUnit,
      purchasePlace: purchasePlace ?? this.purchasePlace,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      openedDate: openedDate ?? this.openedDate,
      paoMonths: paoMonths ?? this.paoMonths,
      expiryDate: expiryDate ?? this.expiryDate,
      startWeight: startWeight ?? this.startWeight,
      emptyBottleWeight: emptyBottleWeight ?? this.emptyBottleWeight,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      repurchase: repurchase ?? this.repurchase,
      note: note ?? this.note,
      finishedDate: finishedDate ?? this.finishedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ProductsTable.$convertercategory.toSql(category.value),
      );
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (netContent.present) {
      map['net_content'] = Variable<double>(netContent.value);
    }
    if (netUnit.present) {
      map['net_unit'] = Variable<String>(
        $ProductsTable.$converternetUnit.toSql(netUnit.value),
      );
    }
    if (purchasePlace.present) {
      map['purchase_place'] = Variable<String>(purchasePlace.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<int>(purchaseDate.value);
    }
    if (openedDate.present) {
      map['opened_date'] = Variable<int>(openedDate.value);
    }
    if (paoMonths.present) {
      map['pao_months'] = Variable<int>(paoMonths.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<int>(expiryDate.value);
    }
    if (startWeight.present) {
      map['start_weight'] = Variable<double>(startWeight.value);
    }
    if (emptyBottleWeight.present) {
      map['empty_bottle_weight'] = Variable<double>(emptyBottleWeight.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ProductsTable.$converterstatus.toSql(status.value),
      );
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (repurchase.present) {
      map['repurchase'] = Variable<bool>(repurchase.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (finishedDate.present) {
      map['finished_date'] = Variable<int>(finishedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('netContent: $netContent, ')
          ..write('netUnit: $netUnit, ')
          ..write('purchasePlace: $purchasePlace, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('openedDate: $openedDate, ')
          ..write('paoMonths: $paoMonths, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('startWeight: $startWeight, ')
          ..write('emptyBottleWeight: $emptyBottleWeight, ')
          ..write('status: $status, ')
          ..write('rating: $rating, ')
          ..write('repurchase: $repurchase, ')
          ..write('note: $note, ')
          ..write('finishedDate: $finishedDate')
          ..write(')'))
        .toString();
  }
}

class $WeightLogsTable extends WeightLogs
    with TableInfo<$WeightLogsTable, WeightLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weighedAtMeta = const VerificationMeta(
    'weighedAt',
  );
  @override
  late final GeneratedColumn<int> weighedAt = GeneratedColumn<int>(
    'weighed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    productId,
    weighedAt,
    weight,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('weighed_at')) {
      context.handle(
        _weighedAtMeta,
        weighedAt.isAcceptableOrUnknown(data['weighed_at']!, _weighedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_weighedAtMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      weighedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weighed_at'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WeightLogsTable createAlias(String alias) {
    return $WeightLogsTable(attachedDatabase, alias);
  }
}

class WeightLog extends DataClass implements Insertable<WeightLog> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final int productId;
  final int weighedAt;

  /// Grams, including the container.
  final double weight;
  final String? note;
  const WeightLog({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.weighedAt,
    required this.weight,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['product_id'] = Variable<int>(productId);
    map['weighed_at'] = Variable<int>(weighedAt);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WeightLogsCompanion toCompanion(bool nullToAbsent) {
    return WeightLogsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      productId: Value(productId),
      weighedAt: Value(weighedAt),
      weight: Value(weight),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WeightLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightLog(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      productId: serializer.fromJson<int>(json['productId']),
      weighedAt: serializer.fromJson<int>(json['weighedAt']),
      weight: serializer.fromJson<double>(json['weight']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'productId': serializer.toJson<int>(productId),
      'weighedAt': serializer.toJson<int>(weighedAt),
      'weight': serializer.toJson<double>(weight),
      'note': serializer.toJson<String?>(note),
    };
  }

  WeightLog copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    int? productId,
    int? weighedAt,
    double? weight,
    Value<String?> note = const Value.absent(),
  }) => WeightLog(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    productId: productId ?? this.productId,
    weighedAt: weighedAt ?? this.weighedAt,
    weight: weight ?? this.weight,
    note: note.present ? note.value : this.note,
  );
  WeightLog copyWithCompanion(WeightLogsCompanion data) {
    return WeightLog(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      weighedAt: data.weighedAt.present ? data.weighedAt.value : this.weighedAt,
      weight: data.weight.present ? data.weight.value : this.weight,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightLog(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('productId: $productId, ')
          ..write('weighedAt: $weighedAt, ')
          ..write('weight: $weight, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, productId, weighedAt, weight, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightLog &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.productId == this.productId &&
          other.weighedAt == this.weighedAt &&
          other.weight == this.weight &&
          other.note == this.note);
}

class WeightLogsCompanion extends UpdateCompanion<WeightLog> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> productId;
  final Value<int> weighedAt;
  final Value<double> weight;
  final Value<String?> note;
  const WeightLogsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.weighedAt = const Value.absent(),
    this.weight = const Value.absent(),
    this.note = const Value.absent(),
  });
  WeightLogsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int productId,
    required int weighedAt,
    required double weight,
    this.note = const Value.absent(),
  }) : productId = Value(productId),
       weighedAt = Value(weighedAt),
       weight = Value(weight);
  static Insertable<WeightLog> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? productId,
    Expression<int>? weighedAt,
    Expression<double>? weight,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (productId != null) 'product_id': productId,
      if (weighedAt != null) 'weighed_at': weighedAt,
      if (weight != null) 'weight': weight,
      if (note != null) 'note': note,
    });
  }

  WeightLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? productId,
    Value<int>? weighedAt,
    Value<double>? weight,
    Value<String?>? note,
  }) {
    return WeightLogsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productId: productId ?? this.productId,
      weighedAt: weighedAt ?? this.weighedAt,
      weight: weight ?? this.weight,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (weighedAt.present) {
      map['weighed_at'] = Variable<int>(weighedAt.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightLogsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('productId: $productId, ')
          ..write('weighedAt: $weighedAt, ')
          ..write('weight: $weight, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDaySlot, String> timeOfDay =
      GeneratedColumn<String>(
        'time_of_day',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDaySlot>($RoutinesTable.$convertertimeOfDay);
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    timeOfDay,
    reminderTime,
    reminderEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      timeOfDay: $RoutinesTable.$convertertimeOfDay.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}time_of_day'],
        )!,
      ),
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time'],
      ),
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeOfDaySlot, String> $convertertimeOfDay =
      timeOfDaySlotConverter;
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final String name;
  final TimeOfDaySlot timeOfDay;

  /// Local time as `HH:mm`.
  final String? reminderTime;
  final bool reminderEnabled;
  const Routine({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.timeOfDay,
    this.reminderTime,
    required this.reminderEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['name'] = Variable<String>(name);
    {
      map['time_of_day'] = Variable<String>(
        $RoutinesTable.$convertertimeOfDay.toSql(timeOfDay),
      );
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      timeOfDay: Value(timeOfDay),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      reminderEnabled: Value(reminderEnabled),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      timeOfDay: serializer.fromJson<TimeOfDaySlot>(json['timeOfDay']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'name': serializer.toJson<String>(name),
      'timeOfDay': serializer.toJson<TimeOfDaySlot>(timeOfDay),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
    };
  }

  Routine copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    String? name,
    TimeOfDaySlot? timeOfDay,
    Value<String?> reminderTime = const Value.absent(),
    bool? reminderEnabled,
  }) => Routine(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderEnabled: $reminderEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    timeOfDay,
    reminderTime,
    reminderEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.timeOfDay == this.timeOfDay &&
          other.reminderTime == this.reminderTime &&
          other.reminderEnabled == this.reminderEnabled);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> name;
  final Value<TimeOfDaySlot> timeOfDay;
  final Value<String?> reminderTime;
  final Value<bool> reminderEnabled;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required TimeOfDaySlot timeOfDay,
    this.reminderTime = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
  }) : name = Value(name),
       timeOfDay = Value(timeOfDay);
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? name,
    Expression<String>? timeOfDay,
    Expression<String>? reminderTime,
    Expression<bool>? reminderEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
    });
  }

  RoutinesCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? name,
    Value<TimeOfDaySlot>? timeOfDay,
    Value<String?>? reminderTime,
    Value<bool>? reminderEnabled,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(
        $RoutinesTable.$convertertimeOfDay.toSql(timeOfDay.value),
      );
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderEnabled: $reminderEnabled')
          ..write(')'))
        .toString();
  }
}

class $RoutineStepsTable extends RoutineSteps
    with TableInfo<$RoutineStepsTable, RoutineStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepOrderMeta = const VerificationMeta(
    'stepOrder',
  );
  @override
  late final GeneratedColumn<int> stepOrder = GeneratedColumn<int>(
    'step_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    routineId,
    productId,
    stepOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('step_order')) {
      context.handle(
        _stepOrderMeta,
        stepOrder.isAcceptableOrUnknown(data['step_order']!, _stepOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_stepOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      stepOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_order'],
      )!,
    );
  }

  @override
  $RoutineStepsTable createAlias(String alias) {
    return $RoutineStepsTable(attachedDatabase, alias);
  }
}

class RoutineStep extends DataClass implements Insertable<RoutineStep> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final int routineId;
  final int productId;
  final int stepOrder;
  const RoutineStep({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.routineId,
    required this.productId,
    required this.stepOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['routine_id'] = Variable<int>(routineId);
    map['product_id'] = Variable<int>(productId);
    map['step_order'] = Variable<int>(stepOrder);
    return map;
  }

  RoutineStepsCompanion toCompanion(bool nullToAbsent) {
    return RoutineStepsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      routineId: Value(routineId),
      productId: Value(productId),
      stepOrder: Value(stepOrder),
    );
  }

  factory RoutineStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineStep(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      routineId: serializer.fromJson<int>(json['routineId']),
      productId: serializer.fromJson<int>(json['productId']),
      stepOrder: serializer.fromJson<int>(json['stepOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'routineId': serializer.toJson<int>(routineId),
      'productId': serializer.toJson<int>(productId),
      'stepOrder': serializer.toJson<int>(stepOrder),
    };
  }

  RoutineStep copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    int? routineId,
    int? productId,
    int? stepOrder,
  }) => RoutineStep(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    routineId: routineId ?? this.routineId,
    productId: productId ?? this.productId,
    stepOrder: stepOrder ?? this.stepOrder,
  );
  RoutineStep copyWithCompanion(RoutineStepsCompanion data) {
    return RoutineStep(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      productId: data.productId.present ? data.productId.value : this.productId,
      stepOrder: data.stepOrder.present ? data.stepOrder.value : this.stepOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineStep(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routineId: $routineId, ')
          ..write('productId: $productId, ')
          ..write('stepOrder: $stepOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, routineId, productId, stepOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineStep &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.routineId == this.routineId &&
          other.productId == this.productId &&
          other.stepOrder == this.stepOrder);
}

class RoutineStepsCompanion extends UpdateCompanion<RoutineStep> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> routineId;
  final Value<int> productId;
  final Value<int> stepOrder;
  const RoutineStepsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.routineId = const Value.absent(),
    this.productId = const Value.absent(),
    this.stepOrder = const Value.absent(),
  });
  RoutineStepsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int routineId,
    required int productId,
    required int stepOrder,
  }) : routineId = Value(routineId),
       productId = Value(productId),
       stepOrder = Value(stepOrder);
  static Insertable<RoutineStep> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? routineId,
    Expression<int>? productId,
    Expression<int>? stepOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (routineId != null) 'routine_id': routineId,
      if (productId != null) 'product_id': productId,
      if (stepOrder != null) 'step_order': stepOrder,
    });
  }

  RoutineStepsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? routineId,
    Value<int>? productId,
    Value<int>? stepOrder,
  }) {
    return RoutineStepsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      routineId: routineId ?? this.routineId,
      productId: productId ?? this.productId,
      stepOrder: stepOrder ?? this.stepOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (stepOrder.present) {
      map['step_order'] = Variable<int>(stepOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineStepsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routineId: $routineId, ')
          ..write('productId: $productId, ')
          ..write('stepOrder: $stepOrder')
          ..write(')'))
        .toString();
  }
}

class $UsageLogsTable extends UsageLogs
    with TableInfo<$UsageLogsTable, UsageLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  @override
  late final GeneratedColumn<int> usedAt = GeneratedColumn<int>(
    'used_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    productId,
    routineId,
    usedAt,
    area,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsageLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    }
    if (data.containsKey('used_at')) {
      context.handle(
        _usedAtMeta,
        usedAt.isAcceptableOrUnknown(data['used_at']!, _usedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_usedAtMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      ),
      usedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}used_at'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $UsageLogsTable createAlias(String alias) {
    return $UsageLogsTable(attachedDatabase, alias);
  }
}

class UsageLog extends DataClass implements Insertable<UsageLog> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final int productId;
  final int? routineId;
  final int usedAt;
  final String? area;
  final String? note;
  const UsageLog({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    this.routineId,
    required this.usedAt,
    this.area,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<int>(routineId);
    }
    map['used_at'] = Variable<int>(usedAt);
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  UsageLogsCompanion toCompanion(bool nullToAbsent) {
    return UsageLogsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      productId: Value(productId),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      usedAt: Value(usedAt),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory UsageLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageLog(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      productId: serializer.fromJson<int>(json['productId']),
      routineId: serializer.fromJson<int?>(json['routineId']),
      usedAt: serializer.fromJson<int>(json['usedAt']),
      area: serializer.fromJson<String?>(json['area']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'productId': serializer.toJson<int>(productId),
      'routineId': serializer.toJson<int?>(routineId),
      'usedAt': serializer.toJson<int>(usedAt),
      'area': serializer.toJson<String?>(area),
      'note': serializer.toJson<String?>(note),
    };
  }

  UsageLog copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    int? productId,
    Value<int?> routineId = const Value.absent(),
    int? usedAt,
    Value<String?> area = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => UsageLog(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    productId: productId ?? this.productId,
    routineId: routineId.present ? routineId.value : this.routineId,
    usedAt: usedAt ?? this.usedAt,
    area: area.present ? area.value : this.area,
    note: note.present ? note.value : this.note,
  );
  UsageLog copyWithCompanion(UsageLogsCompanion data) {
    return UsageLog(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      usedAt: data.usedAt.present ? data.usedAt.value : this.usedAt,
      area: data.area.present ? data.area.value : this.area,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageLog(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('productId: $productId, ')
          ..write('routineId: $routineId, ')
          ..write('usedAt: $usedAt, ')
          ..write('area: $area, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    productId,
    routineId,
    usedAt,
    area,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageLog &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.productId == this.productId &&
          other.routineId == this.routineId &&
          other.usedAt == this.usedAt &&
          other.area == this.area &&
          other.note == this.note);
}

class UsageLogsCompanion extends UpdateCompanion<UsageLog> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> productId;
  final Value<int?> routineId;
  final Value<int> usedAt;
  final Value<String?> area;
  final Value<String?> note;
  const UsageLogsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.usedAt = const Value.absent(),
    this.area = const Value.absent(),
    this.note = const Value.absent(),
  });
  UsageLogsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int productId,
    this.routineId = const Value.absent(),
    required int usedAt,
    this.area = const Value.absent(),
    this.note = const Value.absent(),
  }) : productId = Value(productId),
       usedAt = Value(usedAt);
  static Insertable<UsageLog> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? productId,
    Expression<int>? routineId,
    Expression<int>? usedAt,
    Expression<String>? area,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (productId != null) 'product_id': productId,
      if (routineId != null) 'routine_id': routineId,
      if (usedAt != null) 'used_at': usedAt,
      if (area != null) 'area': area,
      if (note != null) 'note': note,
    });
  }

  UsageLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? productId,
    Value<int?>? routineId,
    Value<int>? usedAt,
    Value<String?>? area,
    Value<String?>? note,
  }) {
    return UsageLogsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productId: productId ?? this.productId,
      routineId: routineId ?? this.routineId,
      usedAt: usedAt ?? this.usedAt,
      area: area ?? this.area,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (usedAt.present) {
      map['used_at'] = Variable<int>(usedAt.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageLogsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('productId: $productId, ')
          ..write('routineId: $routineId, ')
          ..write('usedAt: $usedAt, ')
          ..write('area: $area, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $DailyEntriesTable extends DailyEntries
    with TableInfo<$DailyEntriesTable, DailyEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _scoreOilMeta = const VerificationMeta(
    'scoreOil',
  );
  @override
  late final GeneratedColumn<int> scoreOil = GeneratedColumn<int>(
    'score_oil',
    aliasedName,
    true,
    check: () => ComparableExpr(scoreOil).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreMoistureMeta = const VerificationMeta(
    'scoreMoisture',
  );
  @override
  late final GeneratedColumn<int> scoreMoisture = GeneratedColumn<int>(
    'score_moisture',
    aliasedName,
    true,
    check: () => ComparableExpr(scoreMoisture).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreAcneMeta = const VerificationMeta(
    'scoreAcne',
  );
  @override
  late final GeneratedColumn<int> scoreAcne = GeneratedColumn<int>(
    'score_acne',
    aliasedName,
    true,
    check: () => ComparableExpr(scoreAcne).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreRednessMeta = const VerificationMeta(
    'scoreRedness',
  );
  @override
  late final GeneratedColumn<int> scoreRedness = GeneratedColumn<int>(
    'score_redness',
    aliasedName,
    true,
    check: () => ComparableExpr(scoreRedness).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreDullnessMeta = const VerificationMeta(
    'scoreDullness',
  );
  @override
  late final GeneratedColumn<int> scoreDullness = GeneratedColumn<int>(
    'score_dullness',
    aliasedName,
    true,
    check: () => ComparableExpr(scoreDullness).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepHoursMeta = const VerificationMeta(
    'sleepHours',
  );
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
    'sleep_hours',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stressLevelMeta = const VerificationMeta(
    'stressLevel',
  );
  @override
  late final GeneratedColumn<int> stressLevel = GeneratedColumn<int>(
    'stress_level',
    aliasedName,
    true,
    check: () => ComparableExpr(stressLevel).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SunExposure?, String>
  sunExposure = GeneratedColumn<String>(
    'sun_exposure',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<SunExposure?>($DailyEntriesTable.$convertersunExposuren);
  static const VerificationMeta _periodPhaseMeta = const VerificationMeta(
    'periodPhase',
  );
  @override
  late final GeneratedColumn<String> periodPhase = GeneratedColumn<String>(
    'period_phase',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    date,
    scoreOil,
    scoreMoisture,
    scoreAcne,
    scoreRedness,
    scoreDullness,
    sleepHours,
    stressLevel,
    sunExposure,
    periodPhase,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('score_oil')) {
      context.handle(
        _scoreOilMeta,
        scoreOil.isAcceptableOrUnknown(data['score_oil']!, _scoreOilMeta),
      );
    }
    if (data.containsKey('score_moisture')) {
      context.handle(
        _scoreMoistureMeta,
        scoreMoisture.isAcceptableOrUnknown(
          data['score_moisture']!,
          _scoreMoistureMeta,
        ),
      );
    }
    if (data.containsKey('score_acne')) {
      context.handle(
        _scoreAcneMeta,
        scoreAcne.isAcceptableOrUnknown(data['score_acne']!, _scoreAcneMeta),
      );
    }
    if (data.containsKey('score_redness')) {
      context.handle(
        _scoreRednessMeta,
        scoreRedness.isAcceptableOrUnknown(
          data['score_redness']!,
          _scoreRednessMeta,
        ),
      );
    }
    if (data.containsKey('score_dullness')) {
      context.handle(
        _scoreDullnessMeta,
        scoreDullness.isAcceptableOrUnknown(
          data['score_dullness']!,
          _scoreDullnessMeta,
        ),
      );
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
        _sleepHoursMeta,
        sleepHours.isAcceptableOrUnknown(data['sleep_hours']!, _sleepHoursMeta),
      );
    }
    if (data.containsKey('stress_level')) {
      context.handle(
        _stressLevelMeta,
        stressLevel.isAcceptableOrUnknown(
          data['stress_level']!,
          _stressLevelMeta,
        ),
      );
    }
    if (data.containsKey('period_phase')) {
      context.handle(
        _periodPhaseMeta,
        periodPhase.isAcceptableOrUnknown(
          data['period_phase']!,
          _periodPhaseMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      scoreOil: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_oil'],
      ),
      scoreMoisture: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_moisture'],
      ),
      scoreAcne: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_acne'],
      ),
      scoreRedness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_redness'],
      ),
      scoreDullness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_dullness'],
      ),
      sleepHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sleep_hours'],
      ),
      stressLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stress_level'],
      ),
      sunExposure: $DailyEntriesTable.$convertersunExposuren.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sun_exposure'],
        ),
      ),
      periodPhase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_phase'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $DailyEntriesTable createAlias(String alias) {
    return $DailyEntriesTable(attachedDatabase, alias);
  }

  static TypeConverter<SunExposure, String> $convertersunExposure =
      sunExposureConverter;
  static TypeConverter<SunExposure?, String?> $convertersunExposuren =
      NullAwareTypeConverter.wrap($convertersunExposure);
}

class DailyEntry extends DataClass implements Insertable<DailyEntry> {
  final int id;
  final int createdAt;
  final int updatedAt;

  /// Local date as `YYYY-MM-DD`.
  final String date;
  final int? scoreOil;
  final int? scoreMoisture;
  final int? scoreAcne;
  final int? scoreRedness;
  final int? scoreDullness;
  final double? sleepHours;
  final int? stressLevel;
  final SunExposure? sunExposure;
  final String? periodPhase;
  final String? note;
  const DailyEntry({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    this.scoreOil,
    this.scoreMoisture,
    this.scoreAcne,
    this.scoreRedness,
    this.scoreDullness,
    this.sleepHours,
    this.stressLevel,
    this.sunExposure,
    this.periodPhase,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || scoreOil != null) {
      map['score_oil'] = Variable<int>(scoreOil);
    }
    if (!nullToAbsent || scoreMoisture != null) {
      map['score_moisture'] = Variable<int>(scoreMoisture);
    }
    if (!nullToAbsent || scoreAcne != null) {
      map['score_acne'] = Variable<int>(scoreAcne);
    }
    if (!nullToAbsent || scoreRedness != null) {
      map['score_redness'] = Variable<int>(scoreRedness);
    }
    if (!nullToAbsent || scoreDullness != null) {
      map['score_dullness'] = Variable<int>(scoreDullness);
    }
    if (!nullToAbsent || sleepHours != null) {
      map['sleep_hours'] = Variable<double>(sleepHours);
    }
    if (!nullToAbsent || stressLevel != null) {
      map['stress_level'] = Variable<int>(stressLevel);
    }
    if (!nullToAbsent || sunExposure != null) {
      map['sun_exposure'] = Variable<String>(
        $DailyEntriesTable.$convertersunExposuren.toSql(sunExposure),
      );
    }
    if (!nullToAbsent || periodPhase != null) {
      map['period_phase'] = Variable<String>(periodPhase);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  DailyEntriesCompanion toCompanion(bool nullToAbsent) {
    return DailyEntriesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      date: Value(date),
      scoreOil: scoreOil == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreOil),
      scoreMoisture: scoreMoisture == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreMoisture),
      scoreAcne: scoreAcne == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreAcne),
      scoreRedness: scoreRedness == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreRedness),
      scoreDullness: scoreDullness == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreDullness),
      sleepHours: sleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHours),
      stressLevel: stressLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(stressLevel),
      sunExposure: sunExposure == null && nullToAbsent
          ? const Value.absent()
          : Value(sunExposure),
      periodPhase: periodPhase == null && nullToAbsent
          ? const Value.absent()
          : Value(periodPhase),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory DailyEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyEntry(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      date: serializer.fromJson<String>(json['date']),
      scoreOil: serializer.fromJson<int?>(json['scoreOil']),
      scoreMoisture: serializer.fromJson<int?>(json['scoreMoisture']),
      scoreAcne: serializer.fromJson<int?>(json['scoreAcne']),
      scoreRedness: serializer.fromJson<int?>(json['scoreRedness']),
      scoreDullness: serializer.fromJson<int?>(json['scoreDullness']),
      sleepHours: serializer.fromJson<double?>(json['sleepHours']),
      stressLevel: serializer.fromJson<int?>(json['stressLevel']),
      sunExposure: serializer.fromJson<SunExposure?>(json['sunExposure']),
      periodPhase: serializer.fromJson<String?>(json['periodPhase']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'date': serializer.toJson<String>(date),
      'scoreOil': serializer.toJson<int?>(scoreOil),
      'scoreMoisture': serializer.toJson<int?>(scoreMoisture),
      'scoreAcne': serializer.toJson<int?>(scoreAcne),
      'scoreRedness': serializer.toJson<int?>(scoreRedness),
      'scoreDullness': serializer.toJson<int?>(scoreDullness),
      'sleepHours': serializer.toJson<double?>(sleepHours),
      'stressLevel': serializer.toJson<int?>(stressLevel),
      'sunExposure': serializer.toJson<SunExposure?>(sunExposure),
      'periodPhase': serializer.toJson<String?>(periodPhase),
      'note': serializer.toJson<String?>(note),
    };
  }

  DailyEntry copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    String? date,
    Value<int?> scoreOil = const Value.absent(),
    Value<int?> scoreMoisture = const Value.absent(),
    Value<int?> scoreAcne = const Value.absent(),
    Value<int?> scoreRedness = const Value.absent(),
    Value<int?> scoreDullness = const Value.absent(),
    Value<double?> sleepHours = const Value.absent(),
    Value<int?> stressLevel = const Value.absent(),
    Value<SunExposure?> sunExposure = const Value.absent(),
    Value<String?> periodPhase = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => DailyEntry(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    date: date ?? this.date,
    scoreOil: scoreOil.present ? scoreOil.value : this.scoreOil,
    scoreMoisture: scoreMoisture.present
        ? scoreMoisture.value
        : this.scoreMoisture,
    scoreAcne: scoreAcne.present ? scoreAcne.value : this.scoreAcne,
    scoreRedness: scoreRedness.present ? scoreRedness.value : this.scoreRedness,
    scoreDullness: scoreDullness.present
        ? scoreDullness.value
        : this.scoreDullness,
    sleepHours: sleepHours.present ? sleepHours.value : this.sleepHours,
    stressLevel: stressLevel.present ? stressLevel.value : this.stressLevel,
    sunExposure: sunExposure.present ? sunExposure.value : this.sunExposure,
    periodPhase: periodPhase.present ? periodPhase.value : this.periodPhase,
    note: note.present ? note.value : this.note,
  );
  DailyEntry copyWithCompanion(DailyEntriesCompanion data) {
    return DailyEntry(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      date: data.date.present ? data.date.value : this.date,
      scoreOil: data.scoreOil.present ? data.scoreOil.value : this.scoreOil,
      scoreMoisture: data.scoreMoisture.present
          ? data.scoreMoisture.value
          : this.scoreMoisture,
      scoreAcne: data.scoreAcne.present ? data.scoreAcne.value : this.scoreAcne,
      scoreRedness: data.scoreRedness.present
          ? data.scoreRedness.value
          : this.scoreRedness,
      scoreDullness: data.scoreDullness.present
          ? data.scoreDullness.value
          : this.scoreDullness,
      sleepHours: data.sleepHours.present
          ? data.sleepHours.value
          : this.sleepHours,
      stressLevel: data.stressLevel.present
          ? data.stressLevel.value
          : this.stressLevel,
      sunExposure: data.sunExposure.present
          ? data.sunExposure.value
          : this.sunExposure,
      periodPhase: data.periodPhase.present
          ? data.periodPhase.value
          : this.periodPhase,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyEntry(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('scoreOil: $scoreOil, ')
          ..write('scoreMoisture: $scoreMoisture, ')
          ..write('scoreAcne: $scoreAcne, ')
          ..write('scoreRedness: $scoreRedness, ')
          ..write('scoreDullness: $scoreDullness, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('sunExposure: $sunExposure, ')
          ..write('periodPhase: $periodPhase, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    date,
    scoreOil,
    scoreMoisture,
    scoreAcne,
    scoreRedness,
    scoreDullness,
    sleepHours,
    stressLevel,
    sunExposure,
    periodPhase,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyEntry &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.date == this.date &&
          other.scoreOil == this.scoreOil &&
          other.scoreMoisture == this.scoreMoisture &&
          other.scoreAcne == this.scoreAcne &&
          other.scoreRedness == this.scoreRedness &&
          other.scoreDullness == this.scoreDullness &&
          other.sleepHours == this.sleepHours &&
          other.stressLevel == this.stressLevel &&
          other.sunExposure == this.sunExposure &&
          other.periodPhase == this.periodPhase &&
          other.note == this.note);
}

class DailyEntriesCompanion extends UpdateCompanion<DailyEntry> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> date;
  final Value<int?> scoreOil;
  final Value<int?> scoreMoisture;
  final Value<int?> scoreAcne;
  final Value<int?> scoreRedness;
  final Value<int?> scoreDullness;
  final Value<double?> sleepHours;
  final Value<int?> stressLevel;
  final Value<SunExposure?> sunExposure;
  final Value<String?> periodPhase;
  final Value<String?> note;
  const DailyEntriesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.scoreOil = const Value.absent(),
    this.scoreMoisture = const Value.absent(),
    this.scoreAcne = const Value.absent(),
    this.scoreRedness = const Value.absent(),
    this.scoreDullness = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.sunExposure = const Value.absent(),
    this.periodPhase = const Value.absent(),
    this.note = const Value.absent(),
  });
  DailyEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String date,
    this.scoreOil = const Value.absent(),
    this.scoreMoisture = const Value.absent(),
    this.scoreAcne = const Value.absent(),
    this.scoreRedness = const Value.absent(),
    this.scoreDullness = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.sunExposure = const Value.absent(),
    this.periodPhase = const Value.absent(),
    this.note = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyEntry> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? date,
    Expression<int>? scoreOil,
    Expression<int>? scoreMoisture,
    Expression<int>? scoreAcne,
    Expression<int>? scoreRedness,
    Expression<int>? scoreDullness,
    Expression<double>? sleepHours,
    Expression<int>? stressLevel,
    Expression<String>? sunExposure,
    Expression<String>? periodPhase,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (date != null) 'date': date,
      if (scoreOil != null) 'score_oil': scoreOil,
      if (scoreMoisture != null) 'score_moisture': scoreMoisture,
      if (scoreAcne != null) 'score_acne': scoreAcne,
      if (scoreRedness != null) 'score_redness': scoreRedness,
      if (scoreDullness != null) 'score_dullness': scoreDullness,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (sunExposure != null) 'sun_exposure': sunExposure,
      if (periodPhase != null) 'period_phase': periodPhase,
      if (note != null) 'note': note,
    });
  }

  DailyEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? date,
    Value<int?>? scoreOil,
    Value<int?>? scoreMoisture,
    Value<int?>? scoreAcne,
    Value<int?>? scoreRedness,
    Value<int?>? scoreDullness,
    Value<double?>? sleepHours,
    Value<int?>? stressLevel,
    Value<SunExposure?>? sunExposure,
    Value<String?>? periodPhase,
    Value<String?>? note,
  }) {
    return DailyEntriesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      scoreOil: scoreOil ?? this.scoreOil,
      scoreMoisture: scoreMoisture ?? this.scoreMoisture,
      scoreAcne: scoreAcne ?? this.scoreAcne,
      scoreRedness: scoreRedness ?? this.scoreRedness,
      scoreDullness: scoreDullness ?? this.scoreDullness,
      sleepHours: sleepHours ?? this.sleepHours,
      stressLevel: stressLevel ?? this.stressLevel,
      sunExposure: sunExposure ?? this.sunExposure,
      periodPhase: periodPhase ?? this.periodPhase,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (scoreOil.present) {
      map['score_oil'] = Variable<int>(scoreOil.value);
    }
    if (scoreMoisture.present) {
      map['score_moisture'] = Variable<int>(scoreMoisture.value);
    }
    if (scoreAcne.present) {
      map['score_acne'] = Variable<int>(scoreAcne.value);
    }
    if (scoreRedness.present) {
      map['score_redness'] = Variable<int>(scoreRedness.value);
    }
    if (scoreDullness.present) {
      map['score_dullness'] = Variable<int>(scoreDullness.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<int>(stressLevel.value);
    }
    if (sunExposure.present) {
      map['sun_exposure'] = Variable<String>(
        $DailyEntriesTable.$convertersunExposuren.toSql(sunExposure.value),
      );
    }
    if (periodPhase.present) {
      map['period_phase'] = Variable<String>(periodPhase.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyEntriesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('scoreOil: $scoreOil, ')
          ..write('scoreMoisture: $scoreMoisture, ')
          ..write('scoreAcne: $scoreAcne, ')
          ..write('scoreRedness: $scoreRedness, ')
          ..write('scoreDullness: $scoreDullness, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('sunExposure: $sunExposure, ')
          ..write('periodPhase: $periodPhase, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _dailyEntryIdMeta = const VerificationMeta(
    'dailyEntryId',
  );
  @override
  late final GeneratedColumn<int> dailyEntryId = GeneratedColumn<int>(
    'daily_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_entries (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<int> takenAt = GeneratedColumn<int>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbPathMeta = const VerificationMeta(
    'thumbPath',
  );
  @override
  late final GeneratedColumn<String> thumbPath = GeneratedColumn<String>(
    'thumb_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDaySlot, String> session =
      GeneratedColumn<String>(
        'session',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDaySlot>($PhotosTable.$convertersession);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    dailyEntryId,
    takenAt,
    filePath,
    thumbPath,
    session,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Photo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('daily_entry_id')) {
      context.handle(
        _dailyEntryIdMeta,
        dailyEntryId.isAcceptableOrUnknown(
          data['daily_entry_id']!,
          _dailyEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyEntryIdMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('thumb_path')) {
      context.handle(
        _thumbPathMeta,
        thumbPath.isAcceptableOrUnknown(data['thumb_path']!, _thumbPathMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbPathMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      dailyEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_entry_id'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}taken_at'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      thumbPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumb_path'],
      )!,
      session: $PhotosTable.$convertersession.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}session'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeOfDaySlot, String> $convertersession =
      timeOfDaySlotConverter;
}

class Photo extends DataClass implements Insertable<Photo> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final int dailyEntryId;
  final int takenAt;

  /// Path relative to the app documents directory.
  final String filePath;

  /// Path relative to the app documents directory.
  final String thumbPath;
  final TimeOfDaySlot session;
  final String? note;
  const Photo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.dailyEntryId,
    required this.takenAt,
    required this.filePath,
    required this.thumbPath,
    required this.session,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['daily_entry_id'] = Variable<int>(dailyEntryId);
    map['taken_at'] = Variable<int>(takenAt);
    map['file_path'] = Variable<String>(filePath);
    map['thumb_path'] = Variable<String>(thumbPath);
    {
      map['session'] = Variable<String>(
        $PhotosTable.$convertersession.toSql(session),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      dailyEntryId: Value(dailyEntryId),
      takenAt: Value(takenAt),
      filePath: Value(filePath),
      thumbPath: Value(thumbPath),
      session: Value(session),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Photo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      dailyEntryId: serializer.fromJson<int>(json['dailyEntryId']),
      takenAt: serializer.fromJson<int>(json['takenAt']),
      filePath: serializer.fromJson<String>(json['filePath']),
      thumbPath: serializer.fromJson<String>(json['thumbPath']),
      session: serializer.fromJson<TimeOfDaySlot>(json['session']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'dailyEntryId': serializer.toJson<int>(dailyEntryId),
      'takenAt': serializer.toJson<int>(takenAt),
      'filePath': serializer.toJson<String>(filePath),
      'thumbPath': serializer.toJson<String>(thumbPath),
      'session': serializer.toJson<TimeOfDaySlot>(session),
      'note': serializer.toJson<String?>(note),
    };
  }

  Photo copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    int? dailyEntryId,
    int? takenAt,
    String? filePath,
    String? thumbPath,
    TimeOfDaySlot? session,
    Value<String?> note = const Value.absent(),
  }) => Photo(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    dailyEntryId: dailyEntryId ?? this.dailyEntryId,
    takenAt: takenAt ?? this.takenAt,
    filePath: filePath ?? this.filePath,
    thumbPath: thumbPath ?? this.thumbPath,
    session: session ?? this.session,
    note: note.present ? note.value : this.note,
  );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dailyEntryId: data.dailyEntryId.present
          ? data.dailyEntryId.value
          : this.dailyEntryId,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      thumbPath: data.thumbPath.present ? data.thumbPath.value : this.thumbPath,
      session: data.session.present ? data.session.value : this.session,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dailyEntryId: $dailyEntryId, ')
          ..write('takenAt: $takenAt, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('session: $session, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    dailyEntryId,
    takenAt,
    filePath,
    thumbPath,
    session,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.dailyEntryId == this.dailyEntryId &&
          other.takenAt == this.takenAt &&
          other.filePath == this.filePath &&
          other.thumbPath == this.thumbPath &&
          other.session == this.session &&
          other.note == this.note);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> dailyEntryId;
  final Value<int> takenAt;
  final Value<String> filePath;
  final Value<String> thumbPath;
  final Value<TimeOfDaySlot> session;
  final Value<String?> note;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dailyEntryId = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.filePath = const Value.absent(),
    this.thumbPath = const Value.absent(),
    this.session = const Value.absent(),
    this.note = const Value.absent(),
  });
  PhotosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int dailyEntryId,
    required int takenAt,
    required String filePath,
    required String thumbPath,
    required TimeOfDaySlot session,
    this.note = const Value.absent(),
  }) : dailyEntryId = Value(dailyEntryId),
       takenAt = Value(takenAt),
       filePath = Value(filePath),
       thumbPath = Value(thumbPath),
       session = Value(session);
  static Insertable<Photo> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? dailyEntryId,
    Expression<int>? takenAt,
    Expression<String>? filePath,
    Expression<String>? thumbPath,
    Expression<String>? session,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dailyEntryId != null) 'daily_entry_id': dailyEntryId,
      if (takenAt != null) 'taken_at': takenAt,
      if (filePath != null) 'file_path': filePath,
      if (thumbPath != null) 'thumb_path': thumbPath,
      if (session != null) 'session': session,
      if (note != null) 'note': note,
    });
  }

  PhotosCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? dailyEntryId,
    Value<int>? takenAt,
    Value<String>? filePath,
    Value<String>? thumbPath,
    Value<TimeOfDaySlot>? session,
    Value<String?>? note,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dailyEntryId: dailyEntryId ?? this.dailyEntryId,
      takenAt: takenAt ?? this.takenAt,
      filePath: filePath ?? this.filePath,
      thumbPath: thumbPath ?? this.thumbPath,
      session: session ?? this.session,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dailyEntryId.present) {
      map['daily_entry_id'] = Variable<int>(dailyEntryId.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<int>(takenAt.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (thumbPath.present) {
      map['thumb_path'] = Variable<String>(thumbPath.value);
    }
    if (session.present) {
      map['session'] = Variable<String>(
        $PhotosTable.$convertersession.toSql(session.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dailyEntryId: $dailyEntryId, ')
          ..write('takenAt: $takenAt, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('session: $session, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TagType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TagType>($TagsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name, type},
  ];
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $TagsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }

  static TypeConverter<TagType, String> $convertertype = tagTypeConverter;
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final String name;
  final TagType type;
  const Tag({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>($TagsTable.$convertertype.toSql(type));
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      type: Value(type),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<TagType>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<TagType>(type),
    };
  }

  Tag copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    String? name,
    TagType? type,
  }) => Tag(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    type: type ?? this.type,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.type == this.type);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> name;
  final Value<TagType> type;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required TagType type,
  }) : name = Value(name),
       type = Value(type);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? name,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? name,
    Value<TagType>? type,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TagsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $EntryTagsTable extends EntryTags
    with TableInfo<$EntryTagsTable, EntryTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [entryId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, tagId};
  @override
  EntryTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryTag(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $EntryTagsTable createAlias(String alias) {
    return $EntryTagsTable(attachedDatabase, alias);
  }
}

class EntryTag extends DataClass implements Insertable<EntryTag> {
  final int entryId;
  final int tagId;
  const EntryTag({required this.entryId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<int>(entryId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  EntryTagsCompanion toCompanion(bool nullToAbsent) {
    return EntryTagsCompanion(entryId: Value(entryId), tagId: Value(tagId));
  }

  factory EntryTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryTag(
      entryId: serializer.fromJson<int>(json['entryId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<int>(entryId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  EntryTag copyWith({int? entryId, int? tagId}) =>
      EntryTag(entryId: entryId ?? this.entryId, tagId: tagId ?? this.tagId);
  EntryTag copyWithCompanion(EntryTagsCompanion data) {
    return EntryTag(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryTag(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryTag &&
          other.entryId == this.entryId &&
          other.tagId == this.tagId);
}

class EntryTagsCompanion extends UpdateCompanion<EntryTag> {
  final Value<int> entryId;
  final Value<int> tagId;
  final Value<int> rowid;
  const EntryTagsCompanion({
    this.entryId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryTagsCompanion.insert({
    required int entryId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       tagId = Value(tagId);
  static Insertable<EntryTag> custom({
    Expression<int>? entryId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryTagsCompanion copyWith({
    Value<int>? entryId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return EntryTagsCompanion(
      entryId: entryId ?? this.entryId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTagsCompanion(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductTagsTable extends ProductTags
    with TableInfo<$ProductTagsTable, ProductTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [productId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, tagId};
  @override
  ProductTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTag(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ProductTagsTable createAlias(String alias) {
    return $ProductTagsTable(attachedDatabase, alias);
  }
}

class ProductTag extends DataClass implements Insertable<ProductTag> {
  final int productId;
  final int tagId;
  const ProductTag({required this.productId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  ProductTagsCompanion toCompanion(bool nullToAbsent) {
    return ProductTagsCompanion(
      productId: Value(productId),
      tagId: Value(tagId),
    );
  }

  factory ProductTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTag(
      productId: serializer.fromJson<int>(json['productId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  ProductTag copyWith({int? productId, int? tagId}) => ProductTag(
    productId: productId ?? this.productId,
    tagId: tagId ?? this.tagId,
  );
  ProductTag copyWithCompanion(ProductTagsCompanion data) {
    return ProductTag(
      productId: data.productId.present ? data.productId.value : this.productId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTag(')
          ..write('productId: $productId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTag &&
          other.productId == this.productId &&
          other.tagId == this.tagId);
}

class ProductTagsCompanion extends UpdateCompanion<ProductTag> {
  final Value<int> productId;
  final Value<int> tagId;
  final Value<int> rowid;
  const ProductTagsCompanion({
    this.productId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductTagsCompanion.insert({
    required int productId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       tagId = Value(tagId);
  static Insertable<ProductTag> custom({
    Expression<int>? productId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductTagsCompanion copyWith({
    Value<int>? productId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return ProductTagsCompanion(
      productId: productId ?? this.productId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTagsCompanion(')
          ..write('productId: $productId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: nowEpochMs,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final String key;
  final String value;
  const AppSetting({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({
    int? id,
    int? createdAt,
    int? updatedAt,
    String? key,
    String? value,
  }) => AppSetting(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    key: key ?? this.key,
    value: value ?? this.value,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> key;
  final Value<String> value;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String key,
    required String value,
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? key,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? key,
    Value<String>? value,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $WeightLogsTable weightLogs = $WeightLogsTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $RoutineStepsTable routineSteps = $RoutineStepsTable(this);
  late final $UsageLogsTable usageLogs = $UsageLogsTable(this);
  late final $DailyEntriesTable dailyEntries = $DailyEntriesTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $EntryTagsTable entryTags = $EntryTagsTable(this);
  late final $ProductTagsTable productTags = $ProductTagsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final Index idxWeightLogsProduct = Index(
    'idx_weight_logs_product',
    'CREATE INDEX idx_weight_logs_product ON weight_logs (product_id, weighed_at)',
  );
  late final Index idxRoutineStepsRoutine = Index(
    'idx_routine_steps_routine',
    'CREATE INDEX idx_routine_steps_routine ON routine_steps (routine_id, step_order)',
  );
  late final Index idxUsageLogsProduct = Index(
    'idx_usage_logs_product',
    'CREATE INDEX idx_usage_logs_product ON usage_logs (product_id, used_at)',
  );
  late final Index idxUsageLogsUsedAt = Index(
    'idx_usage_logs_used_at',
    'CREATE INDEX idx_usage_logs_used_at ON usage_logs (used_at)',
  );
  late final Index idxPhotosTakenAt = Index(
    'idx_photos_taken_at',
    'CREATE INDEX idx_photos_taken_at ON photos (taken_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    weightLogs,
    routines,
    routineSteps,
    usageLogs,
    dailyEntries,
    photos,
    tags,
    entryTags,
    productTags,
    appSettings,
    idxWeightLogsProduct,
    idxRoutineStepsRoutine,
    idxUsageLogsProduct,
    idxUsageLogsUsedAt,
    idxPhotosTakenAt,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weight_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('usage_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('usage_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required String name,
  Value<String?> brand,
  required ProductCategory category,
  Value<double?> price,
  Value<double?> netContent,
  Value<NetUnit> netUnit,
  Value<String?> purchasePlace,
  Value<int?> purchaseDate,
  Value<int?> openedDate,
  Value<int?> paoMonths,
  Value<int?> expiryDate,
  Value<double?> startWeight,
  Value<double?> emptyBottleWeight,
  Value<ProductStatus> status,
  Value<int?> rating,
  Value<bool?> repurchase,
  Value<String?> note,
  Value<int?> finishedDate,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String> name,
  Value<String?> brand,
  Value<ProductCategory> category,
  Value<double?> price,
  Value<double?> netContent,
  Value<NetUnit> netUnit,
  Value<String?> purchasePlace,
  Value<int?> purchaseDate,
  Value<int?> openedDate,
  Value<int?> paoMonths,
  Value<int?> expiryDate,
  Value<double?> startWeight,
  Value<double?> emptyBottleWeight,
  Value<ProductStatus> status,
  Value<int?> rating,
  Value<bool?> repurchase,
  Value<String?> note,
  Value<int?> finishedDate,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeightLogsTable, List<WeightLog>>
  _weightLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weightLogs,
    aliasName: 'products__id__weight_logs__product_id',
  );

  $$WeightLogsTableProcessedTableManager get weightLogsRefs {
    final manager = $$WeightLogsTableTableManager(
      $_db,
      $_db.weightLogs,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weightLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoutineStepsTable, List<RoutineStep>>
  _routineStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineSteps,
    aliasName: 'products__id__routine_steps__product_id',
  );

  $$RoutineStepsTableProcessedTableManager get routineStepsRefs {
    final manager = $$RoutineStepsTableTableManager(
      $_db,
      $_db.routineSteps,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsageLogsTable, List<UsageLog>>
  _usageLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.usageLogs,
    aliasName: 'products__id__usage_logs__product_id',
  );

  $$UsageLogsTableProcessedTableManager get usageLogsRefs {
    final manager = $$UsageLogsTableTableManager(
      $_db,
      $_db.usageLogs,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_usageLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductTagsTable, List<ProductTag>>
  _productTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productTags,
    aliasName: 'products__id__product_tags__product_id',
  );

  $$ProductTagsTableProcessedTableManager get productTagsRefs {
    final manager = $$ProductTagsTableTableManager(
      $_db,
      $_db.productTags,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProductCategory, ProductCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netContent => $composableBuilder(
    column: $table.netContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NetUnit, NetUnit, String> get netUnit =>
      $composableBuilder(
        column: $table.netUnit,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get purchasePlace => $composableBuilder(
    column: $table.purchasePlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openedDate => $composableBuilder(
    column: $table.openedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paoMonths => $composableBuilder(
    column: $table.paoMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startWeight => $composableBuilder(
    column: $table.startWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get emptyBottleWeight => $composableBuilder(
    column: $table.emptyBottleWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProductStatus, ProductStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get repurchase => $composableBuilder(
    column: $table.repurchase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finishedDate => $composableBuilder(
    column: $table.finishedDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weightLogsRefs(
    Expression<bool> Function($$WeightLogsTableFilterComposer f) f,
  ) {
    final $$WeightLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightLogs,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightLogsTableFilterComposer(
            $db: $db,
            $table: $db.weightLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> routineStepsRefs(
    Expression<bool> Function($$RoutineStepsTableFilterComposer f) f,
  ) {
    final $$RoutineStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineSteps,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineStepsTableFilterComposer(
            $db: $db,
            $table: $db.routineSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usageLogsRefs(
    Expression<bool> Function($$UsageLogsTableFilterComposer f) f,
  ) {
    final $$UsageLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableFilterComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productTagsRefs(
    Expression<bool> Function($$ProductTagsTableFilterComposer f) f,
  ) {
    final $$ProductTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTags,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTagsTableFilterComposer(
            $db: $db,
            $table: $db.productTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netContent => $composableBuilder(
    column: $table.netContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get netUnit => $composableBuilder(
    column: $table.netUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchasePlace => $composableBuilder(
    column: $table.purchasePlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openedDate => $composableBuilder(
    column: $table.openedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paoMonths => $composableBuilder(
    column: $table.paoMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startWeight => $composableBuilder(
    column: $table.startWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get emptyBottleWeight => $composableBuilder(
    column: $table.emptyBottleWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get repurchase => $composableBuilder(
    column: $table.repurchase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finishedDate => $composableBuilder(
    column: $table.finishedDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get netContent => $composableBuilder(
    column: $table.netContent,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<NetUnit, String> get netUnit =>
      $composableBuilder(column: $table.netUnit, builder: (column) => column);

  GeneratedColumn<String> get purchasePlace => $composableBuilder(
    column: $table.purchasePlace,
    builder: (column) => column,
  );

  GeneratedColumn<int> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get openedDate => $composableBuilder(
    column: $table.openedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paoMonths =>
      $composableBuilder(column: $table.paoMonths, builder: (column) => column);

  GeneratedColumn<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startWeight => $composableBuilder(
    column: $table.startWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get emptyBottleWeight => $composableBuilder(
    column: $table.emptyBottleWeight,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ProductStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<bool> get repurchase => $composableBuilder(
    column: $table.repurchase,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get finishedDate => $composableBuilder(
    column: $table.finishedDate,
    builder: (column) => column,
  );

  Expression<T> weightLogsRefs<T extends Object>(
    Expression<T> Function($$WeightLogsTableAnnotationComposer a) f,
  ) {
    final $$WeightLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightLogs,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.weightLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> routineStepsRefs<T extends Object>(
    Expression<T> Function($$RoutineStepsTableAnnotationComposer a) f,
  ) {
    final $$RoutineStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineSteps,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.routineSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usageLogsRefs<T extends Object>(
    Expression<T> Function($$UsageLogsTableAnnotationComposer a) f,
  ) {
    final $$UsageLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productTagsRefs<T extends Object>(
    Expression<T> Function($$ProductTagsTableAnnotationComposer a) f,
  ) {
    final $$ProductTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTags,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.productTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool weightLogsRefs,
            bool routineStepsRefs,
            bool usageLogsRefs,
            bool productTagsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<ProductCategory> category = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<double?> netContent = const Value.absent(),
                Value<NetUnit> netUnit = const Value.absent(),
                Value<String?> purchasePlace = const Value.absent(),
                Value<int?> purchaseDate = const Value.absent(),
                Value<int?> openedDate = const Value.absent(),
                Value<int?> paoMonths = const Value.absent(),
                Value<int?> expiryDate = const Value.absent(),
                Value<double?> startWeight = const Value.absent(),
                Value<double?> emptyBottleWeight = const Value.absent(),
                Value<ProductStatus> status = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<bool?> repurchase = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> finishedDate = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                brand: brand,
                category: category,
                price: price,
                netContent: netContent,
                netUnit: netUnit,
                purchasePlace: purchasePlace,
                purchaseDate: purchaseDate,
                openedDate: openedDate,
                paoMonths: paoMonths,
                expiryDate: expiryDate,
                startWeight: startWeight,
                emptyBottleWeight: emptyBottleWeight,
                status: status,
                rating: rating,
                repurchase: repurchase,
                note: note,
                finishedDate: finishedDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required String name,
                Value<String?> brand = const Value.absent(),
                required ProductCategory category,
                Value<double?> price = const Value.absent(),
                Value<double?> netContent = const Value.absent(),
                Value<NetUnit> netUnit = const Value.absent(),
                Value<String?> purchasePlace = const Value.absent(),
                Value<int?> purchaseDate = const Value.absent(),
                Value<int?> openedDate = const Value.absent(),
                Value<int?> paoMonths = const Value.absent(),
                Value<int?> expiryDate = const Value.absent(),
                Value<double?> startWeight = const Value.absent(),
                Value<double?> emptyBottleWeight = const Value.absent(),
                Value<ProductStatus> status = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<bool?> repurchase = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> finishedDate = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                brand: brand,
                category: category,
                price: price,
                netContent: netContent,
                netUnit: netUnit,
                purchasePlace: purchasePlace,
                purchaseDate: purchaseDate,
                openedDate: openedDate,
                paoMonths: paoMonths,
                expiryDate: expiryDate,
                startWeight: startWeight,
                emptyBottleWeight: emptyBottleWeight,
                status: status,
                rating: rating,
                repurchase: repurchase,
                note: note,
                finishedDate: finishedDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                weightLogsRefs = false,
                routineStepsRefs = false,
                usageLogsRefs = false,
                productTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weightLogsRefs) db.weightLogs,
                    if (routineStepsRefs) db.routineSteps,
                    if (usageLogsRefs) db.usageLogs,
                    if (productTagsRefs) db.productTags,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weightLogsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          WeightLog
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._weightLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).weightLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (routineStepsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          RoutineStep
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._routineStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).routineStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usageLogsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          UsageLog
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._usageLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).usageLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productTagsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          ProductTag
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool weightLogsRefs,
        bool routineStepsRefs,
        bool usageLogsRefs,
        bool productTagsRefs,
      })
    >;
typedef $$WeightLogsTableCreateCompanionBuilder = WeightLogsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required int productId,
  required int weighedAt,
  required double weight,
  Value<String?> note,
});
typedef $$WeightLogsTableUpdateCompanionBuilder = WeightLogsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> productId,
  Value<int> weighedAt,
  Value<double> weight,
  Value<String?> note,
});

final class $$WeightLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog> {
  $$WeightLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('weight_logs__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeightLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weighedAt => $composableBuilder(
    column: $table.weighedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weighedAt => $composableBuilder(
    column: $table.weighedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get weighedAt =>
      $composableBuilder(column: $table.weighedAt, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightLogsTable,
          WeightLog,
          $$WeightLogsTableFilterComposer,
          $$WeightLogsTableOrderingComposer,
          $$WeightLogsTableAnnotationComposer,
          $$WeightLogsTableCreateCompanionBuilder,
          $$WeightLogsTableUpdateCompanionBuilder,
          (WeightLog, $$WeightLogsTableReferences),
          WeightLog,
          PrefetchHooks Function({bool productId})
        > {
  $$WeightLogsTableTableManager(_$AppDatabase db, $WeightLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> weighedAt = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WeightLogsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                productId: productId,
                weighedAt: weighedAt,
                weight: weight,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required int productId,
                required int weighedAt,
                required double weight,
                Value<String?> note = const Value.absent(),
              }) => WeightLogsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                productId: productId,
                weighedAt: weighedAt,
                weight: weight,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeightLogsTable, WeightLog>(table),
                  $$WeightLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$WeightLogsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$WeightLogsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeightLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightLogsTable,
      WeightLog,
      $$WeightLogsTableFilterComposer,
      $$WeightLogsTableOrderingComposer,
      $$WeightLogsTableAnnotationComposer,
      $$WeightLogsTableCreateCompanionBuilder,
      $$WeightLogsTableUpdateCompanionBuilder,
      (WeightLog, $$WeightLogsTableReferences),
      WeightLog,
      PrefetchHooks Function({bool productId})
    >;
typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required String name,
  required TimeOfDaySlot timeOfDay,
  Value<String?> reminderTime,
  Value<bool> reminderEnabled,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String> name,
  Value<TimeOfDaySlot> timeOfDay,
  Value<String?> reminderTime,
  Value<bool> reminderEnabled,
});

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, Routine> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutineStepsTable, List<RoutineStep>>
  _routineStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineSteps,
    aliasName: 'routines__id__routine_steps__routine_id',
  );

  $$RoutineStepsTableProcessedTableManager get routineStepsRefs {
    final manager = $$RoutineStepsTableTableManager(
      $_db,
      $_db.routineSteps,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsageLogsTable, List<UsageLog>>
  _usageLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.usageLogs,
    aliasName: 'routines__id__usage_logs__routine_id',
  );

  $$UsageLogsTableProcessedTableManager get usageLogsRefs {
    final manager = $$UsageLogsTableTableManager(
      $_db,
      $_db.usageLogs,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_usageLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDaySlot, TimeOfDaySlot, String>
  get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineStepsRefs(
    Expression<bool> Function($$RoutineStepsTableFilterComposer f) f,
  ) {
    final $$RoutineStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineSteps,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineStepsTableFilterComposer(
            $db: $db,
            $table: $db.routineSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usageLogsRefs(
    Expression<bool> Function($$UsageLogsTableFilterComposer f) f,
  ) {
    final $$UsageLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableFilterComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDaySlot, String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  Expression<T> routineStepsRefs<T extends Object>(
    Expression<T> Function($$RoutineStepsTableAnnotationComposer a) f,
  ) {
    final $$RoutineStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineSteps,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.routineSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usageLogsRefs<T extends Object>(
    Expression<T> Function($$UsageLogsTableAnnotationComposer a) f,
  ) {
    final $$UsageLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, $$RoutinesTableReferences),
          Routine,
          PrefetchHooks Function({bool routineStepsRefs, bool usageLogsRefs})
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<TimeOfDaySlot> timeOfDay = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                timeOfDay: timeOfDay,
                reminderTime: reminderTime,
                reminderEnabled: reminderEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required String name,
                required TimeOfDaySlot timeOfDay,
                Value<String?> reminderTime = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                timeOfDay: timeOfDay,
                reminderTime: reminderTime,
                reminderEnabled: reminderEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutinesTable, Routine>(table),
                  $$RoutinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({routineStepsRefs = false, usageLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (routineStepsRefs) db.routineSteps,
                    if (usageLogsRefs) db.usageLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (routineStepsRefs)
                        await $_getPrefetchedData<
                          Routine,
                          $RoutinesTable,
                          RoutineStep
                        >(
                          currentTable: table,
                          referencedTable: $$RoutinesTableReferences
                              ._routineStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutinesTableReferences(
                                db,
                                table,
                                p0,
                              ).routineStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usageLogsRefs)
                        await $_getPrefetchedData<
                          Routine,
                          $RoutinesTable,
                          UsageLog
                        >(
                          currentTable: table,
                          referencedTable: $$RoutinesTableReferences
                              ._usageLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutinesTableReferences(
                                db,
                                table,
                                p0,
                              ).usageLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, $$RoutinesTableReferences),
      Routine,
      PrefetchHooks Function({bool routineStepsRefs, bool usageLogsRefs})
    >;
typedef $$RoutineStepsTableCreateCompanionBuilder =
    RoutineStepsCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      required int routineId,
      required int productId,
      required int stepOrder,
    });
typedef $$RoutineStepsTableUpdateCompanionBuilder =
    RoutineStepsCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> routineId,
      Value<int> productId,
      Value<int> stepOrder,
    });

final class $$RoutineStepsTableReferences
    extends BaseReferences<_$AppDatabase, $RoutineStepsTable, RoutineStep> {
  $$RoutineStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('routine_steps__routine_id__routines__id');

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('routine_steps__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoutineStepsTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineStepsTable> {
  $$RoutineStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepOrder => $composableBuilder(
    column: $table.stepOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineStepsTable> {
  $$RoutineStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepOrder => $composableBuilder(
    column: $table.stepOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineStepsTable> {
  $$RoutineStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get stepOrder =>
      $composableBuilder(column: $table.stepOrder, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineStepsTable,
          RoutineStep,
          $$RoutineStepsTableFilterComposer,
          $$RoutineStepsTableOrderingComposer,
          $$RoutineStepsTableAnnotationComposer,
          $$RoutineStepsTableCreateCompanionBuilder,
          $$RoutineStepsTableUpdateCompanionBuilder,
          (RoutineStep, $$RoutineStepsTableReferences),
          RoutineStep,
          PrefetchHooks Function({bool routineId, bool productId})
        > {
  $$RoutineStepsTableTableManager(_$AppDatabase db, $RoutineStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> stepOrder = const Value.absent(),
              }) => RoutineStepsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                routineId: routineId,
                productId: productId,
                stepOrder: stepOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required int routineId,
                required int productId,
                required int stepOrder,
              }) => RoutineStepsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                routineId: routineId,
                productId: productId,
                stepOrder: stepOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineStepsTable, RoutineStep>(table),
                  $$RoutineStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.routineId,
                        referencedTable: $$RoutineStepsTableReferences
                            ._routineIdTable(db),
                        referencedColumn: $$RoutineStepsTableReferences
                            ._routineIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$RoutineStepsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$RoutineStepsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoutineStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineStepsTable,
      RoutineStep,
      $$RoutineStepsTableFilterComposer,
      $$RoutineStepsTableOrderingComposer,
      $$RoutineStepsTableAnnotationComposer,
      $$RoutineStepsTableCreateCompanionBuilder,
      $$RoutineStepsTableUpdateCompanionBuilder,
      (RoutineStep, $$RoutineStepsTableReferences),
      RoutineStep,
      PrefetchHooks Function({bool routineId, bool productId})
    >;
typedef $$UsageLogsTableCreateCompanionBuilder = UsageLogsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required int productId,
  Value<int?> routineId,
  required int usedAt,
  Value<String?> area,
  Value<String?> note,
});
typedef $$UsageLogsTableUpdateCompanionBuilder = UsageLogsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> productId,
  Value<int?> routineId,
  Value<int> usedAt,
  Value<String?> area,
  Value<String?> note,
});

final class $$UsageLogsTableReferences
    extends BaseReferences<_$AppDatabase, $UsageLogsTable, UsageLog> {
  $$UsageLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('usage_logs__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('usage_logs__routine_id__routines__id');

  $$RoutinesTableProcessedTableManager? get routineId {
    final $_column = $_itemColumn<int>('routine_id');
    if ($_column == null) return null;
    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsageLogsTableFilterComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get usedAt =>
      $composableBuilder(column: $table.usedAt, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsageLogsTable,
          UsageLog,
          $$UsageLogsTableFilterComposer,
          $$UsageLogsTableOrderingComposer,
          $$UsageLogsTableAnnotationComposer,
          $$UsageLogsTableCreateCompanionBuilder,
          $$UsageLogsTableUpdateCompanionBuilder,
          (UsageLog, $$UsageLogsTableReferences),
          UsageLog,
          PrefetchHooks Function({bool productId, bool routineId})
        > {
  $$UsageLogsTableTableManager(_$AppDatabase db, $UsageLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> routineId = const Value.absent(),
                Value<int> usedAt = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => UsageLogsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                productId: productId,
                routineId: routineId,
                usedAt: usedAt,
                area: area,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required int productId,
                Value<int?> routineId = const Value.absent(),
                required int usedAt,
                Value<String?> area = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => UsageLogsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                productId: productId,
                routineId: routineId,
                usedAt: usedAt,
                area: area,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsageLogsTable, UsageLog>(table),
                  $$UsageLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$UsageLogsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$UsageLogsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (routineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.routineId,
                        referencedTable: $$UsageLogsTableReferences
                            ._routineIdTable(db),
                        referencedColumn: $$UsageLogsTableReferences
                            ._routineIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UsageLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsageLogsTable,
      UsageLog,
      $$UsageLogsTableFilterComposer,
      $$UsageLogsTableOrderingComposer,
      $$UsageLogsTableAnnotationComposer,
      $$UsageLogsTableCreateCompanionBuilder,
      $$UsageLogsTableUpdateCompanionBuilder,
      (UsageLog, $$UsageLogsTableReferences),
      UsageLog,
      PrefetchHooks Function({bool productId, bool routineId})
    >;
typedef $$DailyEntriesTableCreateCompanionBuilder =
    DailyEntriesCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      required String date,
      Value<int?> scoreOil,
      Value<int?> scoreMoisture,
      Value<int?> scoreAcne,
      Value<int?> scoreRedness,
      Value<int?> scoreDullness,
      Value<double?> sleepHours,
      Value<int?> stressLevel,
      Value<SunExposure?> sunExposure,
      Value<String?> periodPhase,
      Value<String?> note,
    });
typedef $$DailyEntriesTableUpdateCompanionBuilder =
    DailyEntriesCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<String> date,
      Value<int?> scoreOil,
      Value<int?> scoreMoisture,
      Value<int?> scoreAcne,
      Value<int?> scoreRedness,
      Value<int?> scoreDullness,
      Value<double?> sleepHours,
      Value<int?> stressLevel,
      Value<SunExposure?> sunExposure,
      Value<String?> periodPhase,
      Value<String?> note,
    });

final class $$DailyEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $DailyEntriesTable, DailyEntry> {
  $$DailyEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PhotosTable, List<Photo>> _photosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.photos,
    aliasName: 'daily_entries__id__photos__daily_entry_id',
  );

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager(
      $_db,
      $_db.photos,
    ).filter((f) => f.dailyEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
  _entryTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTags,
    aliasName: 'daily_entries__id__entry_tags__entry_id',
  );

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager(
      $_db,
      $_db.entryTags,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DailyEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyEntriesTable> {
  $$DailyEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreOil => $composableBuilder(
    column: $table.scoreOil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreMoisture => $composableBuilder(
    column: $table.scoreMoisture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreAcne => $composableBuilder(
    column: $table.scoreAcne,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreRedness => $composableBuilder(
    column: $table.scoreRedness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreDullness => $composableBuilder(
    column: $table.scoreDullness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SunExposure?, SunExposure, String>
  get sunExposure => $composableBuilder(
    column: $table.sunExposure,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get periodPhase => $composableBuilder(
    column: $table.periodPhase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> photosRefs(
    Expression<bool> Function($$PhotosTableFilterComposer f) f,
  ) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.dailyEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableFilterComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> entryTagsRefs(
    Expression<bool> Function($$EntryTagsTableFilterComposer f) f,
  ) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableFilterComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyEntriesTable> {
  $$DailyEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreOil => $composableBuilder(
    column: $table.scoreOil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreMoisture => $composableBuilder(
    column: $table.scoreMoisture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreAcne => $composableBuilder(
    column: $table.scoreAcne,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreRedness => $composableBuilder(
    column: $table.scoreRedness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreDullness => $composableBuilder(
    column: $table.scoreDullness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sunExposure => $composableBuilder(
    column: $table.sunExposure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodPhase => $composableBuilder(
    column: $table.periodPhase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyEntriesTable> {
  $$DailyEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get scoreOil =>
      $composableBuilder(column: $table.scoreOil, builder: (column) => column);

  GeneratedColumn<int> get scoreMoisture => $composableBuilder(
    column: $table.scoreMoisture,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoreAcne =>
      $composableBuilder(column: $table.scoreAcne, builder: (column) => column);

  GeneratedColumn<int> get scoreRedness => $composableBuilder(
    column: $table.scoreRedness,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoreDullness => $composableBuilder(
    column: $table.scoreDullness,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SunExposure?, String> get sunExposure =>
      $composableBuilder(
        column: $table.sunExposure,
        builder: (column) => column,
      );

  GeneratedColumn<String> get periodPhase => $composableBuilder(
    column: $table.periodPhase,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> photosRefs<T extends Object>(
    Expression<T> Function($$PhotosTableAnnotationComposer a) f,
  ) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.dailyEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> entryTagsRefs<T extends Object>(
    Expression<T> Function($$EntryTagsTableAnnotationComposer a) f,
  ) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyEntriesTable,
          DailyEntry,
          $$DailyEntriesTableFilterComposer,
          $$DailyEntriesTableOrderingComposer,
          $$DailyEntriesTableAnnotationComposer,
          $$DailyEntriesTableCreateCompanionBuilder,
          $$DailyEntriesTableUpdateCompanionBuilder,
          (DailyEntry, $$DailyEntriesTableReferences),
          DailyEntry,
          PrefetchHooks Function({bool photosRefs, bool entryTagsRefs})
        > {
  $$DailyEntriesTableTableManager(_$AppDatabase db, $DailyEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int?> scoreOil = const Value.absent(),
                Value<int?> scoreMoisture = const Value.absent(),
                Value<int?> scoreAcne = const Value.absent(),
                Value<int?> scoreRedness = const Value.absent(),
                Value<int?> scoreDullness = const Value.absent(),
                Value<double?> sleepHours = const Value.absent(),
                Value<int?> stressLevel = const Value.absent(),
                Value<SunExposure?> sunExposure = const Value.absent(),
                Value<String?> periodPhase = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => DailyEntriesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                scoreOil: scoreOil,
                scoreMoisture: scoreMoisture,
                scoreAcne: scoreAcne,
                scoreRedness: scoreRedness,
                scoreDullness: scoreDullness,
                sleepHours: sleepHours,
                stressLevel: stressLevel,
                sunExposure: sunExposure,
                periodPhase: periodPhase,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required String date,
                Value<int?> scoreOil = const Value.absent(),
                Value<int?> scoreMoisture = const Value.absent(),
                Value<int?> scoreAcne = const Value.absent(),
                Value<int?> scoreRedness = const Value.absent(),
                Value<int?> scoreDullness = const Value.absent(),
                Value<double?> sleepHours = const Value.absent(),
                Value<int?> stressLevel = const Value.absent(),
                Value<SunExposure?> sunExposure = const Value.absent(),
                Value<String?> periodPhase = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => DailyEntriesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                scoreOil: scoreOil,
                scoreMoisture: scoreMoisture,
                scoreAcne: scoreAcne,
                scoreRedness: scoreRedness,
                scoreDullness: scoreDullness,
                sleepHours: sleepHours,
                stressLevel: stressLevel,
                sunExposure: sunExposure,
                periodPhase: periodPhase,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyEntriesTable, DailyEntry>(table),
                  $$DailyEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({photosRefs = false, entryTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (photosRefs) db.photos,
                if (entryTagsRefs) db.entryTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (photosRefs)
                    await $_getPrefetchedData<
                      DailyEntry,
                      $DailyEntriesTable,
                      Photo
                    >(
                      currentTable: table,
                      referencedTable: $$DailyEntriesTableReferences
                          ._photosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DailyEntriesTableReferences(
                            db,
                            table,
                            p0,
                          ).photosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.dailyEntryId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (entryTagsRefs)
                    await $_getPrefetchedData<
                      DailyEntry,
                      $DailyEntriesTable,
                      EntryTag
                    >(
                      currentTable: table,
                      referencedTable: $$DailyEntriesTableReferences
                          ._entryTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DailyEntriesTableReferences(
                            db,
                            table,
                            p0,
                          ).entryTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.entryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DailyEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyEntriesTable,
      DailyEntry,
      $$DailyEntriesTableFilterComposer,
      $$DailyEntriesTableOrderingComposer,
      $$DailyEntriesTableAnnotationComposer,
      $$DailyEntriesTableCreateCompanionBuilder,
      $$DailyEntriesTableUpdateCompanionBuilder,
      (DailyEntry, $$DailyEntriesTableReferences),
      DailyEntry,
      PrefetchHooks Function({bool photosRefs, bool entryTagsRefs})
    >;
typedef $$PhotosTableCreateCompanionBuilder = PhotosCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required int dailyEntryId,
  required int takenAt,
  required String filePath,
  required String thumbPath,
  required TimeOfDaySlot session,
  Value<String?> note,
});
typedef $$PhotosTableUpdateCompanionBuilder = PhotosCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> dailyEntryId,
  Value<int> takenAt,
  Value<String> filePath,
  Value<String> thumbPath,
  Value<TimeOfDaySlot> session,
  Value<String?> note,
});

final class $$PhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTable, Photo> {
  $$PhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyEntriesTable _dailyEntryIdTable(_$AppDatabase db) =>
      db.dailyEntries.createAlias('photos__daily_entry_id__daily_entries__id');

  $$DailyEntriesTableProcessedTableManager get dailyEntryId {
    final $_column = $_itemColumn<int>('daily_entry_id')!;

    final manager = $$DailyEntriesTableTableManager(
      $_db,
      $_db.dailyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbPath => $composableBuilder(
    column: $table.thumbPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDaySlot, TimeOfDaySlot, String>
  get session => $composableBuilder(
    column: $table.session,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyEntriesTableFilterComposer get dailyEntryId {
    final $$DailyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyEntryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbPath => $composableBuilder(
    column: $table.thumbPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get session => $composableBuilder(
    column: $table.session,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyEntriesTableOrderingComposer get dailyEntryId {
    final $$DailyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyEntryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get thumbPath =>
      $composableBuilder(column: $table.thumbPath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDaySlot, String> get session =>
      $composableBuilder(column: $table.session, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$DailyEntriesTableAnnotationComposer get dailyEntryId {
    final $$DailyEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyEntryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          Photo,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (Photo, $$PhotosTableReferences),
          Photo,
          PrefetchHooks Function({bool dailyEntryId})
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> dailyEntryId = const Value.absent(),
                Value<int> takenAt = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> thumbPath = const Value.absent(),
                Value<TimeOfDaySlot> session = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dailyEntryId: dailyEntryId,
                takenAt: takenAt,
                filePath: filePath,
                thumbPath: thumbPath,
                session: session,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required int dailyEntryId,
                required int takenAt,
                required String filePath,
                required String thumbPath,
                required TimeOfDaySlot session,
                Value<String?> note = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                dailyEntryId: dailyEntryId,
                takenAt: takenAt,
                filePath: filePath,
                thumbPath: thumbPath,
                session: session,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhotosTable, Photo>(table),
                  $$PhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyEntryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.dailyEntryId,
                        referencedTable: $$PhotosTableReferences
                            ._dailyEntryIdTable(db),
                        referencedColumn: $$PhotosTableReferences
                            ._dailyEntryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      Photo,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (Photo, $$PhotosTableReferences),
      Photo,
      PrefetchHooks Function({bool dailyEntryId})
    >;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  required String name,
  required TagType type,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String> name,
  Value<TagType> type,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
  _entryTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTags,
    aliasName: 'tags__id__entry_tags__tag_id',
  );

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager(
      $_db,
      $_db.entryTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductTagsTable, List<ProductTag>>
  _productTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productTags,
    aliasName: 'tags__id__product_tags__tag_id',
  );

  $$ProductTagsTableProcessedTableManager get productTagsRefs {
    final manager = $$ProductTagsTableTableManager(
      $_db,
      $_db.productTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TagType, TagType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  Expression<bool> entryTagsRefs(
    Expression<bool> Function($$EntryTagsTableFilterComposer f) f,
  ) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableFilterComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productTagsRefs(
    Expression<bool> Function($$ProductTagsTableFilterComposer f) f,
  ) {
    final $$ProductTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTagsTableFilterComposer(
            $db: $db,
            $table: $db.productTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TagType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> entryTagsRefs<T extends Object>(
    Expression<T> Function($$EntryTagsTableAnnotationComposer a) f,
  ) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productTagsRefs<T extends Object>(
    Expression<T> Function($$ProductTagsTableAnnotationComposer a) f,
  ) {
    final $$ProductTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.productTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool entryTagsRefs, bool productTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<TagType> type = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required String name,
                required TagType type,
              }) => TagsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({entryTagsRefs = false, productTagsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (entryTagsRefs) db.entryTags,
                    if (productTagsRefs) db.productTags,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (entryTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, EntryTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._entryTagsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).entryTagsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.tagId == item.id),
                          typedResults: items,
                        ),
                      if (productTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, ProductTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._productTagsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).productTagsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.tagId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool entryTagsRefs, bool productTagsRefs})
    >;
typedef $$EntryTagsTableCreateCompanionBuilder = EntryTagsCompanion Function({
  required int entryId,
  required int tagId,
  Value<int> rowid,
});
typedef $$EntryTagsTableUpdateCompanionBuilder = EntryTagsCompanion Function({
  Value<int> entryId,
  Value<int> tagId,
  Value<int> rowid,
});

final class $$EntryTagsTableReferences
    extends BaseReferences<_$AppDatabase, $EntryTagsTable, EntryTag> {
  $$EntryTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.dailyEntries.createAlias('entry_tags__entry_id__daily_entries__id');

  $$DailyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$DailyEntriesTableTableManager(
      $_db,
      $_db.dailyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('entry_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntryTagsTableFilterComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DailyEntriesTableFilterComposer get entryId {
    final $$DailyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DailyEntriesTableOrderingComposer get entryId {
    final $$DailyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DailyEntriesTableAnnotationComposer get entryId {
    final $$DailyEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dailyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntryTagsTable,
          EntryTag,
          $$EntryTagsTableFilterComposer,
          $$EntryTagsTableOrderingComposer,
          $$EntryTagsTableAnnotationComposer,
          $$EntryTagsTableCreateCompanionBuilder,
          $$EntryTagsTableUpdateCompanionBuilder,
          (EntryTag, $$EntryTagsTableReferences),
          EntryTag,
          PrefetchHooks Function({bool entryId, bool tagId})
        > {
  $$EntryTagsTableTableManager(_$AppDatabase db, $EntryTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> entryId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntryTagsCompanion(
                entryId: entryId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int entryId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => EntryTagsCompanion.insert(
                entryId: entryId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EntryTagsTable, EntryTag>(table),
                  $$EntryTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$EntryTagsTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$EntryTagsTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$EntryTagsTableReferences._tagIdTable(
                          db,
                        ),
                        referencedColumn: $$EntryTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntryTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntryTagsTable,
      EntryTag,
      $$EntryTagsTableFilterComposer,
      $$EntryTagsTableOrderingComposer,
      $$EntryTagsTableAnnotationComposer,
      $$EntryTagsTableCreateCompanionBuilder,
      $$EntryTagsTableUpdateCompanionBuilder,
      (EntryTag, $$EntryTagsTableReferences),
      EntryTag,
      PrefetchHooks Function({bool entryId, bool tagId})
    >;
typedef $$ProductTagsTableCreateCompanionBuilder =
    ProductTagsCompanion Function({
      required int productId,
      required int tagId,
      Value<int> rowid,
    });
typedef $$ProductTagsTableUpdateCompanionBuilder =
    ProductTagsCompanion Function({
      Value<int> productId,
      Value<int> tagId,
      Value<int> rowid,
    });

final class $$ProductTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTagsTable, ProductTag> {
  $$ProductTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('product_tags__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('product_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTagsTable> {
  $$ProductTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTagsTable> {
  $$ProductTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTagsTable> {
  $$ProductTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTagsTable,
          ProductTag,
          $$ProductTagsTableFilterComposer,
          $$ProductTagsTableOrderingComposer,
          $$ProductTagsTableAnnotationComposer,
          $$ProductTagsTableCreateCompanionBuilder,
          $$ProductTagsTableUpdateCompanionBuilder,
          (ProductTag, $$ProductTagsTableReferences),
          ProductTag,
          PrefetchHooks Function({bool productId, bool tagId})
        > {
  $$ProductTagsTableTableManager(_$AppDatabase db, $ProductTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductTagsCompanion(
                productId: productId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => ProductTagsCompanion.insert(
                productId: productId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductTagsTable, ProductTag>(table),
                  $$ProductTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$ProductTagsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$ProductTagsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$ProductTagsTableReferences
                            ._tagIdTable(db),
                        referencedColumn: $$ProductTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTagsTable,
      ProductTag,
      $$ProductTagsTableFilterComposer,
      $$ProductTagsTableOrderingComposer,
      $$ProductTagsTableAnnotationComposer,
      $$ProductTagsTableCreateCompanionBuilder,
      $$ProductTagsTableUpdateCompanionBuilder,
      (ProductTag, $$ProductTagsTableReferences),
      ProductTag,
      PrefetchHooks Function({bool productId, bool tagId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      required String key,
      required String value,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<String> key,
      Value<String> value,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                key: key,
                value: value,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                required String key,
                required String value,
              }) => AppSettingsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                key: key,
                value: value,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db, _db.weightLogs);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$RoutineStepsTableTableManager get routineSteps =>
      $$RoutineStepsTableTableManager(_db, _db.routineSteps);
  $$UsageLogsTableTableManager get usageLogs =>
      $$UsageLogsTableTableManager(_db, _db.usageLogs);
  $$DailyEntriesTableTableManager get dailyEntries =>
      $$DailyEntriesTableTableManager(_db, _db.dailyEntries);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$EntryTagsTableTableManager get entryTags =>
      $$EntryTagsTableTableManager(_db, _db.entryTags);
  $$ProductTagsTableTableManager get productTags =>
      $$ProductTagsTableTableManager(_db, _db.productTags);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}

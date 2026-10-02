import 'package:flutter/foundation.dart';

import '../db/app_database.dart';
import '../net/http_json.dart';

/// Product details found for a barcode. Every field is optional; the form
/// only fills fields the user left empty.
class BarcodeProductInfo {
  const BarcodeProductInfo({
    this.name,
    this.brand,
    this.category,
    this.netContent,
    this.netUnit,
    this.price,
  });

  final String? name;
  final String? brand;
  final ProductCategory? category;
  final double? netContent;
  final NetUnit? netUnit;

  /// Only known when re-buying something already in the app.
  final double? price;

  bool get isEmpty =>
      name == null && brand == null && category == null && netContent == null;
}

/// Looks a barcode up in a free, open database. Only the barcode number is
/// sent; returns null when not found, offline or on any error.
abstract class BarcodeLookupService {
  Future<BarcodeProductInfo?> lookup(String barcode);
}

/// Open Beauty Facts (https://world.openbeautyfacts.org): a free, open
/// cosmetics database (ODbL). No account or API key.
class OpenBeautyFactsLookup implements BarcodeLookupService {
  const OpenBeautyFactsLookup({this.timeout = const Duration(seconds: 8)});

  final Duration timeout;

  static const _fields = [
    'product_name',
    'product_name_th',
    'product_name_en',
    'brands',
    'product_quantity',
    'product_quantity_unit',
    'quantity',
    'categories_tags',
  ];

  @override
  Future<BarcodeProductInfo?> lookup(String barcode) async {
    final code = barcode.trim();
    if (!RegExp(r'^\d{6,14}$').hasMatch(code)) return null;
    try {
      final json = await getJson(
        Uri.https('world.openbeautyfacts.org', '/api/v2/product/$code.json', {
          'fields': _fields.join(','),
        }),
        timeout,
      );
      return parseOpenBeautyFacts(json);
    } catch (e) {
      debugPrint('Barcode lookup skipped: $e');
      return null;
    }
  }
}

/// Maps an Open Beauty Facts v2 product response to [BarcodeProductInfo].
BarcodeProductInfo? parseOpenBeautyFacts(Object? json) {
  if (json is! Map || json['status'] != 1) return null;
  final p = json['product'];
  if (p is! Map) return null;

  String? text(Object? v) {
    final s = v?.toString().trim();
    return s == null || s.isEmpty ? null : s;
  }

  final name =
      text(p['product_name_th']) ??
      text(p['product_name']) ??
      text(p['product_name_en']);
  final brand = text(p['brands'])?.split(',').first.trim();
  final (content, unit) = _quantity(p);
  final info = BarcodeProductInfo(
    name: name,
    brand: brand,
    category: _category(p['categories_tags']),
    netContent: content,
    netUnit: unit,
  );
  return info.isEmpty ? null : info;
}

(double?, NetUnit?) _quantity(Map<dynamic, dynamic> p) {
  NetUnit? unitOf(String u) => switch (u.toLowerCase()) {
    'ml' => NetUnit.ml,
    'g' || 'gr' => NetUnit.g,
    _ => null,
  };
  final amount = double.tryParse('${p['product_quantity'] ?? ''}');
  final unit = unitOf('${p['product_quantity_unit'] ?? ''}');
  if (amount != null && amount > 0 && unit != null) return (amount, unit);
  // Fall back to the free-text label, e.g. "50 ml" or "30g".
  final m = RegExp(
    r'(\d+(?:[.,]\d+)?)\s*(ml|g|gr)\b',
    caseSensitive: false,
  ).firstMatch('${p['quantity'] ?? ''}');
  if (m == null) return (null, null);
  return (
    double.tryParse(m.group(1)!.replaceAll(',', '.')),
    unitOf(m.group(2)!),
  );
}

/// Most specific match wins: sunscreen before moisturizer, etc.
const _categoryKeywords = <(ProductCategory, List<String>)>[
  (ProductCategory.sunscreen, ['sun', 'spf', 'solaire']),
  (ProductCategory.mask, ['mask', 'masque']),
  (
    ProductCategory.cleanser,
    ['cleans', 'face-wash', 'micellar', 'makeup-remover', 'soap'],
  ),
  (ProductCategory.toner, ['toner', 'tonic', 'essence', 'lotion-tonique']),
  (ProductCategory.serum, ['serum', 'ampoule']),
  (ProductCategory.treatment, ['acne', 'spot', 'peel', 'exfoli', 'treatment']),
  (
    ProductCategory.moisturizer,
    ['moistur', 'cream', 'creme', 'gel', 'balm', 'emulsion'],
  ),
];

ProductCategory? _category(Object? tags) {
  if (tags is! List) return null;
  final all = tags.map((t) => '$t'.toLowerCase()).toList();
  for (final (category, words) in _categoryKeywords) {
    if (all.any((t) => words.any(t.contains))) return category;
  }
  return null;
}

/// Details copied from a product already in the app with this barcode.
BarcodeProductInfo infoFromExisting(Product p) => BarcodeProductInfo(
  name: p.name,
  brand: p.brand,
  category: p.category,
  netContent: p.netContent,
  netUnit: p.netUnit,
  price: p.price,
);

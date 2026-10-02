import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/lookup/barcode_lookup.dart';

Map<String, Object?> _found(Map<String, Object?> product) => {
  'code': '8850000000001',
  'status': 1,
  'status_verbose': 'product found',
  'product': product,
};

void main() {
  test('maps an Open Beauty Facts product', () {
    final info = parseOpenBeautyFacts(
      _found({
        'product_name': 'Hydrating Toner',
        'product_name_th': 'โทนเนอร์เติมความชุ่มชื้น',
        'brands': 'Softly, Softly Lab',
        'product_quantity': '200',
        'product_quantity_unit': 'ml',
        'categories_tags': ['en:face-care', 'en:face-toners'],
      }),
    )!;
    expect(info.name, 'โทนเนอร์เติมความชุ่มชื้น'); // Thai name preferred
    expect(info.brand, 'Softly');
    expect(info.netContent, 200);
    expect(info.netUnit, NetUnit.ml);
    expect(info.category, ProductCategory.toner);
  });

  test('quantity falls back to the label text', () {
    final info = parseOpenBeautyFacts(
      _found({'product_name': 'Cream', 'quantity': '50 g'}),
    )!;
    expect(info.netContent, 50);
    expect(info.netUnit, NetUnit.g);
    expect(info.category, isNull);
  });

  test('sunscreen wins over moisturizer', () {
    final info = parseOpenBeautyFacts(
      _found({
        'product_name': 'Daily Moisturizer SPF50',
        'categories_tags': ['en:moisturizers', 'en:sunscreens'],
      }),
    )!;
    expect(info.category, ProductCategory.sunscreen);
  });

  test('not found, empty or malformed responses give null', () {
    expect(
      parseOpenBeautyFacts({
        'status': 0,
        'status_verbose': 'product not found',
      }),
      isNull,
    );
    expect(parseOpenBeautyFacts(_found({'product_name': ' '})), isNull);
    expect(parseOpenBeautyFacts('nonsense'), isNull);
    expect(parseOpenBeautyFacts({'status': 1}), isNull);
  });

  test('invalid barcodes are not sent anywhere', () async {
    expect(await const OpenBeautyFactsLookup().lookup('abc'), isNull);
    expect(await const OpenBeautyFactsLookup().lookup('12'), isNull);
  });
}

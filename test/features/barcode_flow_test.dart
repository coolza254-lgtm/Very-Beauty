import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';
import 'package:very_beauty/core/db/settings_dao.dart';
import 'package:very_beauty/core/lookup/barcode_lookup.dart';
import 'package:very_beauty/features/products/barcode_fill.dart';

import '../helpers/pump_app.dart';

class _FakeLookup implements BarcodeLookupService {
  final asked = <String>[];

  @override
  Future<BarcodeProductInfo?> lookup(String barcode) async {
    asked.add(barcode);
    return const BarcodeProductInfo(
      name: 'Gentle Gel Cleanser',
      brand: 'Pure',
      category: ProductCategory.cleanser,
      netContent: 150,
      netUnit: NetUnit.ml,
    );
  }
}

String _text(WidgetTester tester, String label) => tester
    .widget<TextFormField>(find.widgetWithText(TextFormField, label))
    .controller!
    .text;

void main() {
  testWidgets('scan → ask once → fill from the open database', (tester) async {
    final lookup = _FakeLookup();
    final db = await pumpApp(
      tester,
      overrides: [
        barcodeScannerProvider.overrideWithValue((_) async => '8850000000001'),
        barcodeLookupProvider.overrideWithValue(lookup),
      ],
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('สแกนบาร์โค้ด'));
    await tester.pumpAndSettle();

    // Consent first; nothing is sent before it.
    expect(find.text('ค้นหาข้อมูลจากอินเทอร์เน็ต?'), findsOneWidget);
    expect(lookup.asked, isEmpty);
    await tester.tap(find.text('ค้นหา'));
    await tester.pumpAndSettle();

    expect(lookup.asked, ['8850000000001']);
    expect(_text(tester, 'ชื่อสินค้า'), 'Gentle Gel Cleanser');
    expect(_text(tester, 'ปริมาณสุทธิ'), '150');
    expect(find.text('บาร์โค้ด 8850000000001'), findsOneWidget);

    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();
    final saved = (await tester.runAsync(() => ProductsDao(db).loadAll()))!;
    expect(saved.single.product.barcode, '8850000000001');
    expect(saved.single.product.category, ProductCategory.cleanser);
    expect(saved.single.product.netUnit, NetUnit.ml);
    final consent = await tester.runAsync(
      () => SettingsDao(db).getValue(SettingKeys.barcodeLookup),
    );
    expect(consent, '1');
  });

  testWidgets('a re-bought product fills from your own data, offline', (
    tester,
  ) async {
    final lookup = _FakeLookup();
    await pumpApp(
      tester,
      overrides: [
        barcodeScannerProvider.overrideWithValue((_) async => '111222333444'),
        barcodeLookupProvider.overrideWithValue(lookup),
      ],
      seed: (db) => ProductsDao(db).createProduct(
        const ProductDraft(
          name: 'Ceramide Cream',
          category: ProductCategory.moisturizer,
          price: 650,
          netContent: 50,
          barcode: '111222333444',
        ),
      ),
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('สแกนบาร์โค้ด'));
    await tester.pumpAndSettle();

    expect(lookup.asked, isEmpty); // never went online
    expect(find.text('ค้นหาข้อมูลจากอินเทอร์เน็ต?'), findsNothing);
    expect(_text(tester, 'ชื่อสินค้า'), 'Ceramide Cream');
    expect(_text(tester, 'ราคา (บาท)'), '650');
  });

  testWidgets('declining keeps everything offline', (tester) async {
    final lookup = _FakeLookup();
    await pumpApp(
      tester,
      overrides: [
        barcodeScannerProvider.overrideWithValue((_) async => '8850000000002'),
        barcodeLookupProvider.overrideWithValue(lookup),
      ],
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('สแกนบาร์โค้ด'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ไม่ต้อง'));
    await tester.pumpAndSettle();
    expect(lookup.asked, isEmpty);
    expect(find.text('บาร์โค้ด 8850000000002'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('add a product with just name + category, then weigh it', (
    tester,
  ) async {
    final db = await pumpApp(tester);

    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('เพิ่มสินค้า').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'ชื่อสินค้า'),
      'Vit C Serum',
    );
    await tester.tap(find.text('เซรั่ม'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'ราคา (บาท)'),
      '900',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'ปริมาณสุทธิ'),
      '30',
    );
    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();

    // Lands on the detail screen.
    expect(find.text('Vit C Serum'), findsOneWidget);
    expect(find.text('฿30'), findsOneWidget); // price per gram

    await tester.tap(find.text('ชั่งใหม่'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'ครั้งแรก ชั่งตอนยังไม่ได้ใช้ (รวมบรรจุภัณฑ์) จะใช้เป็นน้ำหนักเริ่มต้น',
      ),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField).last, '80');
    await tester.pump();
    // Container = full weight − label net content.
    expect(
      find.text('บรรจุภัณฑ์ ≈ 50 กรัม (80 − ปริมาณสุทธิ 30)'),
      findsOneWidget,
    );
    await tester.tap(find.text('บันทึก').last);
    await tester.pumpAndSettle();

    final products = await tester.runAsync(() => ProductsDao(db).loadAll());
    expect(products!.single.product.startWeight, 80);
    expect(products.single.product.category, ProductCategory.serum);
    expect(find.text('เหลือ 100%'), findsOneWidget);
    expect(find.text('บรรจุภัณฑ์ 50 กรัม'), findsOneWidget);

    // Later weighing shows what is left before saving.
    await tester.tap(find.text('ชั่งใหม่'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '65');
    await tester.pump();
    expect(find.text('เหลือ 15 กรัม (50%)'), findsOneWidget);
  });

  testWidgets('name is required', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('เพิ่มสินค้า').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();
    expect(find.text('กรุณาใส่ชื่อสินค้า'), findsOneWidget);
  });

  testWidgets('filters by status', (tester) async {
    await pumpApp(
      tester,
      seed: (db) async {
        final dao = ProductsDao(db);
        await dao.createProduct(
          const ProductDraft(
            name: 'Cleanser A',
            category: ProductCategory.cleanser,
          ),
        );
        await dao.createProduct(
          const ProductDraft(
            name: 'Dream Cream',
            category: ProductCategory.moisturizer,
            status: ProductStatus.wishlist,
          ),
        );
      },
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    expect(find.text('Cleanser A'), findsOneWidget);
    expect(find.text('Dream Cream'), findsOneWidget);

    final chip = find.widgetWithText(ChoiceChip, 'อยากได้');
    await tester.scrollUntilVisible(
      chip,
      80,
      scrollable: find
          .ancestor(
            of: find.widgetWithText(ChoiceChip, 'ใช้อยู่'),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.ensureVisible(chip);
    await tester.pumpAndSettle();
    await tester.tap(chip);
    await tester.pumpAndSettle();
    expect(find.text('Cleanser A'), findsNothing);
    expect(find.text('Dream Cream'), findsOneWidget);
  });

  testWidgets('ingredients: autocomplete, paste, popular chips, info sheet', (
    tester,
  ) async {
    final db = await pumpApp(tester);

    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('เพิ่มสินค้า').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'ชื่อสินค้า'),
      'Daily Sunscreen',
    );
    await tester.tap(find.text('กันแดด'));
    await tester.pumpAndSettle();

    // Typing Thai shows the database entry; picking it saves the INCI name.
    final field = find.byKey(const Key('ingredientField'));
    await tester.ensureVisible(field);
    await tester.enterText(field, 'ไนอะซิน');
    await tester.pumpAndSettle();
    expect(find.textContaining('ไนอะซินาไมด์ (วิตามินบี 3) ·'), findsOneWidget);
    await tester.tap(find.text('Niacinamide'));
    await tester.pumpAndSettle();

    // Pasting a list from the label adds every name, canonicalised.
    await tester.enterText(field, 'zinc oxide, glycerin, My Secret Extract,');
    await tester.pumpAndSettle();

    // Quick-add from "common in sunscreen".
    expect(find.textContaining('พบบ่อยในกันแดด'), findsOneWidget);
    final popular = find.widgetWithText(ActionChip, 'Titanium Dioxide');
    await tester.ensureVisible(popular);
    await tester.tap(popular);
    await tester.pumpAndSettle();

    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();

    final names = await tester.runAsync(() async {
      final p = (await ProductsDao(db).loadAll()).single.product;
      return ProductsDao(db).ingredientsOf(p.id);
    });
    expect(names, [
      'Glycerin',
      'My Secret Extract',
      'Niacinamide',
      'Titanium Dioxide',
      'Zinc Oxide',
    ]);

    // Detail: tapping a chip explains the ingredient.
    await tapVisible(tester, find.widgetWithText(InputChip, 'Zinc Oxide'));
    expect(find.text('สารกันแดด (แร่)'), findsWidgets);
  });

  testWidgets('ingredient database screen searches and filters', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'retin');
    await tester.pumpAndSettle();
    expect(find.text('Retinol'), findsOneWidget);
    await tester.tap(find.text('Retinol'));
    await tester.pumpAndSettle();
    expect(find.text('ควรรู้'), findsOneWidget);
  });
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:very_beauty/core/storage/app_paths.dart';
import 'package:very_beauty/core/storage/product_photo_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/products_dao.dart';

import 'package:very_beauty/features/products/widgets/molecule_view.dart';

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
    await tester.scrollUntilVisible(
      field,
      200,
      scrollable: find.byType(Scrollable).first,
    );
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

  testWidgets('ingredient page shows the structure and my products', (
    tester,
  ) async {
    await pumpApp(
      tester,
      seed: (db) => ProductsDao(db).createProduct(
        const ProductDraft(
          name: 'Barrier Cream',
          category: ProductCategory.moisturizer,
          // Saved under an alias; the page still finds it.
          ingredients: ['Vitamin B3'],
        ),
      ),
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'niacinamide');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Niacinamide'));
    await tester.pumpAndSettle();

    expect(find.text('คืออะไร'), findsOneWidget);
    await tapVisible(tester, find.text('สูตรโมเลกุล C₆H₆N₂O'));
    expect(find.byType(MoleculeView), findsOneWidget);
    await tapVisible(tester, find.text('Barrier Cream'));
    expect(find.text('ประวัติการชั่ง'), findsNothing);
    expect(find.text('Barrier Cream'), findsWidgets);
  });

  testWidgets('a product can have several categories and its own photo', (
    tester,
  ) async {
    final dir = (await tester.runAsync(
      () => Directory.systemTemp.createTemp('vb_product_photo'),
    ))!;
    addTearDown(() => dir.delete(recursive: true));
    final db = await pumpApp(
      tester,
      overrides: [
        appPathsProvider.overrideWith((ref) async => AppPaths(dir)),
        productPhotoPickerProvider.overrideWithValue(_FakePicker()),
      ],
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('เพิ่มสินค้า').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'ชื่อสินค้า'),
      'Sun Serum SPF50',
    );
    await tester.tap(find.text('กันแดด'));
    await tester.pump();
    await tester.tap(find.text('เซรั่ม'));
    await tester.pump();
    expect(find.text('กันแดด ★'), findsOneWidget); // main category

    await tester.tap(find.byKey(const Key('productPhotoBox')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('เลือกจากคลังภาพ'));
    await tester.pump();
    // Image processing and file writes are real async work.
    final photo = find.descendant(
      of: find.byKey(const Key('productPhotoBox')),
      matching: find.byType(Image),
    );
    for (var i = 0; i < 50 && photo.evaluate().isEmpty; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pump();
    }
    expect(photo, findsOneWidget);

    await tester.tap(find.text('บันทึก').first);
    await tester.pumpAndSettle();
    expect(find.text('กันแดด · เซรั่ม'), findsOneWidget);

    final p = (await tester.runAsync(() => ProductsDao(db).loadAll()))!
        .single
        .product;
    expect(p.categories, [ProductCategory.sunscreen, ProductCategory.serum]);
    expect(p.photoThumbPath, startsWith('photos/thumbs/products/'));
    expect(File(AppPaths(dir).resolve(p.photoPath!)).existsSync(), isTrue);

    // The serum filter finds it too.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    final serum = find.widgetWithText(ChoiceChip, 'เซรั่ม');
    await tester.scrollUntilVisible(
      serum,
      100,
      scrollable: find
          .ancestor(
            of: find.widgetWithText(ChoiceChip, 'คลีนเซอร์'),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.tap(serum);
    await tester.pumpAndSettle();
    expect(find.text('Sun Serum SPF50'), findsOneWidget);
  });

  testWidgets('lists my ingredients that the database does not know', (
    tester,
  ) async {
    await pumpApp(
      tester,
      seed: (db) => ProductsDao(db).createProduct(
        const ProductDraft(
          name: 'Mystery Toner',
          category: ProductCategory.toner,
          ingredients: ['Glycerin', 'Unicorn Tears'],
        ),
      ),
    );
    await tester.tap(find.text('สินค้า'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('ฐานข้อมูลส่วนผสม'));
    await tester.pumpAndSettle();
    expect(
      find.text('มี 1 ส่วนผสมในสินค้าของคุณที่ยังไม่มีข้อมูล'),
      findsOneWidget,
    );
    await tester.tap(find.text('ดูรายชื่อ'));
    await tester.pumpAndSettle();
    expect(find.text('Unicorn Tears'), findsOneWidget);
    expect(find.text('คัดลอกรายชื่อ'), findsOneWidget);
  });
}

class _FakePicker implements ProductPhotoPicker {
  @override
  Future<Uint8List?> pick({required bool fromCamera}) async =>
      img.encodeJpg(img.Image(width: 40, height: 60));
}

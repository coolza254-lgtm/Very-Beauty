// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('v1 to v2 keeps products and adds an empty finished_date', () async {
    final oldProductsData = <v1.ProductsData>[
      const v1.ProductsData(
        id: 1,
        createdAt: 10,
        updatedAt: 20,
        name: 'Serum',
        category: 'serum',
        price: 590,
        netContent: 30,
        netUnit: 'ml',
        status: 'in_use',
      ),
    ];
    final expectedNewProductsData = <v2.ProductsData>[
      const v2.ProductsData(
        id: 1,
        createdAt: 10,
        updatedAt: 20,
        name: 'Serum',
        category: 'serum',
        price: 590,
        netContent: 30,
        netUnit: 'ml',
        status: 'in_use',
      ),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.products, oldProductsData);
      },
      validateItems: (newDb) async {
        expect(
          await newDb.select(newDb.products).get(),
          expectedNewProductsData,
        );
      },
    );
  });
}

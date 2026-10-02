import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/app/app.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/providers.dart';
import 'package:very_beauty/core/notifications/notification_service.dart';
import 'package:very_beauty/core/notifications/reminder_sync.dart';
import 'package:very_beauty/core/update/app_update_service.dart';
import 'package:very_beauty/core/update/update_controller.dart';

import 'test_database.dart';

/// Pumps the whole app on a phone-sized screen with an in-memory database.
Future<AppDatabase> pumpApp(
  WidgetTester tester, {
  Future<void> Function(AppDatabase db)? seed,
  List<Override> overrides = const [],
  AppUpdateService? updateService,
}) async {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final db = createTestDatabase();
  // Unmount the app (cancelling its database streams) before closing the
  // database; closing first would hang the test.
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
    await db.close();
  });
  if (seed != null) await seed(db);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(
          NoopNotificationService(),
        ),
        appUpdateServiceProvider.overrideWithValue(
          updateService ?? NoUpdates(),
        ),
        currentVersionProvider.overrideWith(
          (ref) async => const AppVersionInfo(version: '1.0.0', build: 1),
        ),
        ...overrides,
      ],
      child: const VeryBeautyApp(),
    ),
  );
  await tester.pumpAndSettle();
  return db;
}

/// Scrolls the main list until [finder] is fully on screen, then taps it.
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Never touches the network in tests.
class NoUpdates implements AppUpdateService {
  @override
  Future<UpdateInfo?> check(AppVersionInfo current) async => null;
}

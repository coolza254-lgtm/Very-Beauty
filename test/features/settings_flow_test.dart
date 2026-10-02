import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/settings_dao.dart';
import 'package:very_beauty/core/security/app_lock.dart';

import '../helpers/pump_app.dart';

class _FakeAuth implements DeviceAuth {
  bool available = true;
  bool succeed = false;
  int prompts = 0;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<bool> authenticate(String reason) async {
    prompts++;
    return succeed;
  }
}

void main() {
  testWidgets('app lock blocks content until authentication succeeds', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await pumpApp(
      tester,
      overrides: [deviceAuthProvider.overrideWithValue(auth)],
      seed: (db) => SettingsDao(db).setValue(SettingKeys.appLock, '1'),
    );

    expect(find.text('Very Beauty ถูกล็อกไว้'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(auth.prompts, 1); // prompted once automatically, not in a loop

    auth.succeed = true;
    await tester.tap(find.text('ปลดล็อก'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('turning on app lock requires authentication', (tester) async {
    final auth = _FakeAuth()..succeed = true;
    final db = await pumpApp(
      tester,
      overrides: [deviceAuthProvider.overrideWithValue(auth)],
    );
    await tester.tap(find.text('ตั้งค่า'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('ล็อกแอพ'));
    expect(auth.prompts, 1);
    final value = await tester.runAsync(
      () => SettingsDao(db).getValue(SettingKeys.appLock),
    );
    expect(value, '1');
  });

  testWidgets('switching language to English', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('ตั้งค่า'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('English'));
    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Today'), findsOneWidget);
  });
}

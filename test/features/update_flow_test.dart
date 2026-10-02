import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/settings_dao.dart';
import 'package:very_beauty/core/update/app_update_service.dart';

import '../helpers/pump_app.dart';

class _OneUpdate implements AppUpdateService {
  int calls = 0;

  @override
  Future<UpdateInfo?> check(AppVersionInfo current) async {
    calls++;
    return UpdateInfo(
      versionLabel: 'Very Beauty v1.0.0 (build 9)',
      url: Uri.parse('https://example.com/a.apk'),
    );
  }
}

void main() {
  testWidgets('offers a new version at launch; "later" is remembered', (
    tester,
  ) async {
    final service = _OneUpdate();
    final db = await pumpApp(tester, updateService: service);
    expect(find.text('มีเวอร์ชันใหม่ ✨'), findsOneWidget);
    await tester.tap(find.text('ภายหลัง'));
    await tester.pumpAndSettle();

    final settings = (await tester.runAsync(() => SettingsDao(db).loadAll()))!;
    expect(
      settings[SettingKeys.updateDismissed],
      'Very Beauty v1.0.0 (build 9)',
    );
    expect(settings[SettingKeys.lastUpdateCheck], isNotNull);
    expect(service.calls, 1);
  });

  testWidgets('automatic check can be turned off', (tester) async {
    final service = _OneUpdate();
    await pumpApp(
      tester,
      updateService: service,
      seed: (db) => SettingsDao(db).setValue(SettingKeys.updateAutoCheck, '0'),
    );
    expect(find.text('มีเวอร์ชันใหม่ ✨'), findsNothing);
    expect(service.calls, 0);
  });
}

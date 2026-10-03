import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/update/apk_installer.dart';
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

class _SignedUpdate implements AppUpdateService {
  @override
  Future<UpdateInfo?> check(AppVersionInfo current) async => UpdateInfo(
    versionLabel: 'Very Beauty v1.0.0 (build 9)',
    url: Uri.parse('https://example.com/a.apk'),
    apkUrl: Uri.parse('https://example.com/a.apk'),
    abiApkUrls: {'arm64-v8a': Uri.parse('https://example.com/a-arm64-v8a.apk')},
  );
}

class _FakeInstaller implements ApkInstaller {
  _FakeInstaller({this.result = InstallStatus.success});

  final InstallStatus result;
  final installed = <String>[];
  final _statuses = StreamController<InstallStatus>.broadcast();

  @override
  Stream<InstallStatus> get statuses => _statuses.stream;

  final downloaded = <Uri>[];

  @override
  Future<bool> canInstall() async => true;

  @override
  Future<List<String>> supportedAbis() async => ['arm64-v8a', 'armeabi-v7a'];

  @override
  Future<void> openInstallSettings() async {}

  @override
  Future<File> download(
    Uri url, {
    void Function(double? progress)? onProgress,
  }) async {
    downloaded.add(url);
    onProgress?.call(0.5);
    onProgress?.call(1);
    return File('/tmp/very_beauty_update.apk');
  }

  @override
  Future<void> install(File apk) async {
    installed.add(apk.path);
    _statuses.add(InstallStatus.pendingUserAction);
    _statuses.add(result);
  }
}

void main() {
  testWidgets('signed releases download and install inside the app', (
    tester,
  ) async {
    final installer = _FakeInstaller();
    await pumpApp(
      tester,
      updateService: _SignedUpdate(),
      overrides: [apkInstallerProvider.overrideWithValue(installer)],
    );
    expect(find.text('มีเวอร์ชันใหม่ ✨'), findsOneWidget);
    await tester.tap(find.text('อัปเดตเลย'));
    await tester.pumpAndSettle();
    expect(installer.installed, ['/tmp/very_beauty_update.apk']);
    // The smaller APK for this phone's CPU is used.
    expect(installer.downloaded.single.path, '/a-arm64-v8a.apk');
    expect(find.textContaining('กำลังติดตั้ง'), findsOneWidget);
  });

  testWidgets('an old debug-signed install explains the one-time reinstall', (
    tester,
  ) async {
    final installer = _FakeInstaller(result: InstallStatus.conflict);
    await pumpApp(
      tester,
      updateService: _SignedUpdate(),
      overrides: [apkInstallerProvider.overrideWithValue(installer)],
    );
    await tester.tap(find.text('อัปเดตเลย'));
    await tester.pumpAndSettle();
    expect(find.text('ต้องติดตั้งใหม่อีกครั้งสุดท้าย'), findsOneWidget);
  });

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

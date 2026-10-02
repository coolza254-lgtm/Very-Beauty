import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../db/providers.dart';
import '../db/settings_dao.dart';

/// Device authentication (fingerprint, face or the phone's PIN).
abstract class DeviceAuth {
  Future<bool> isAvailable();
  Future<bool> authenticate(String reason);
}

class LocalDeviceAuth implements DeviceAuth {
  final _auth = LocalAuthentication();

  @override
  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    try {
      // biometricOnly: false lets people fall back to their PIN/pattern.
      return await _auth.authenticate(
        localizedReason: reason,
        persistAcrossBackgrounding: true,
      );
    } on Exception catch (e) {
      debugPrint('Authentication failed: $e');
      return false;
    }
  }
}

final deviceAuthProvider = Provider<DeviceAuth>((ref) => LocalDeviceAuth());

/// Android FLAG_SECURE (no screenshots or screen recording). No-op elsewhere.
Future<void> setSecureScreen(bool secure) async {
  if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) return;
  try {
    await const MethodChannel('very_beauty/secure_screen')
        .invokeMethod<void>('setSecure', {'secure': secure});
  } on MissingPluginException {
    // Tests and platforms without the channel.
  }
}

/// Applies the "block screenshots" setting whenever it changes.
final secureScreenSyncProvider = Provider<void>((ref) {
  ref.listen(
    settingsProvider.select((s) => s.value?[SettingKeys.secureScreen]),
    (_, secure) => setSecureScreen(secure == '1'),
    fireImmediately: true,
  );
});

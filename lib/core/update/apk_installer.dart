import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

/// Result of an install session (mirrors Android's PackageInstaller.STATUS_*).
enum InstallStatus {
  success,
  pendingUserAction,
  failure,
  blocked,
  aborted,
  invalid,
  conflict,
  storage,
  incompatible;

  static InstallStatus fromCode(int code) => switch (code) {
    0 => success,
    -1 => pendingUserAction,
    2 => blocked,
    3 => aborted,
    4 => invalid,
    5 => conflict,
    6 => storage,
    7 => incompatible,
    _ => failure,
  };

  /// The installed app was signed with a different key (e.g. an old debug
  /// build), so Android refuses to update it in place.
  bool get isSignatureMismatch => this == conflict || this == incompatible;
}

/// Downloads and installs update APKs (Android only).
abstract class ApkInstaller {
  /// Whether "install unknown apps" is allowed for Very Beauty.
  Future<bool> canInstall();

  /// Opens the system page where the user allows installs from this app.
  Future<void> openInstallSettings();

  /// Downloads [url] to a temporary file, reporting progress 0..1 (or null
  /// while the size is unknown).
  Future<File> download(Uri url, {void Function(double? progress)? onProgress});

  /// Hands [apk] to the system installer. Results arrive on [statuses].
  Future<void> install(File apk);

  Stream<InstallStatus> get statuses;
}

class PlatformApkInstaller implements ApkInstaller {
  PlatformApkInstaller() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onInstallStatus') {
        final args = (call.arguments as Map).cast<String, Object?>();
        _statuses.add(InstallStatus.fromCode(args['status'] as int? ?? 1));
      }
    });
  }

  static const _channel = MethodChannel('very_beauty/installer');
  final _statuses = StreamController<InstallStatus>.broadcast();

  @override
  Stream<InstallStatus> get statuses => _statuses.stream;

  @override
  Future<bool> canInstall() async =>
      await _channel.invokeMethod<bool>('canInstall') ?? false;

  @override
  Future<void> openInstallSettings() =>
      _channel.invokeMethod<void>('openInstallSettings');

  @override
  Future<void> install(File apk) =>
      _channel.invokeMethod<void>('install', {'path': apk.path});

  @override
  Future<File> download(
    Uri url, {
    void Function(double? progress)? onProgress,
  }) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/very_beauty_update.apk');
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 20);
    try {
      final request = await client.getUrl(url);
      request.headers.set(
        HttpHeaders.userAgentHeader,
        'VeryBeauty (github.com/coolza254-lgtm/Very-Beauty)',
      );
      final response = await request.close();
      if (response.statusCode != 200) {
        throw HttpException('HTTP ${response.statusCode}', uri: url);
      }
      final total = response.contentLength;
      var received = 0;
      final sink = file.openWrite();
      try {
        await for (final chunk in response.timeout(
          const Duration(seconds: 30),
        )) {
          sink.add(chunk);
          received += chunk.length;
          onProgress?.call(total > 0 ? received / total : null);
        }
      } finally {
        await sink.close();
      }
      if (total > 0 && received != total) {
        throw const HttpException('Download incomplete');
      }
      return file;
    } finally {
      client.close(force: true);
    }
  }
}

final apkInstallerProvider = Provider<ApkInstaller>(
  (ref) => PlatformApkInstaller(),
);

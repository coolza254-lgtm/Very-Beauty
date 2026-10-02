import 'package:flutter/foundation.dart';

import '../net/http_json.dart';

/// The installed app's version.
class AppVersionInfo {
  const AppVersionInfo({required this.version, required this.build});

  /// e.g. "1.0.0".
  final String version;

  /// Monotonic build number; CI sets it to the release number.
  final int build;
}

/// A newer version that can be installed.
class UpdateInfo {
  const UpdateInfo({
    required this.versionLabel,
    required this.url,
    this.notes,
    this.mandatory = false,
  });

  /// Shown to the user, e.g. "1.0.0 (build 12)".
  final String versionLabel;

  /// Where to get it (APK download or store page).
  final Uri url;
  final String? notes;

  /// True when the installed build is below the release's
  /// `min_supported_build` (e.g. an incompatible data change).
  final bool mandatory;
}

/// Checks for a newer version. The app's only network access
/// (docs/SPEC.md §8): it sends nothing about the user and must fail
/// silently offline — implementations return null on any error.
abstract class AppUpdateService {
  Future<UpdateInfo?> check(AppVersionInfo current);
}

/// Distribution via GitHub Releases (APK). Release tags are `build-N`, with
/// the APK attached; an optional `min_supported_build: N` line in the
/// release notes forces the update.
class GitHubReleasesUpdateService implements AppUpdateService {
  const GitHubReleasesUpdateService({
    this.repo = 'coolza254-lgtm/Very-Beauty',
    this.timeout = const Duration(seconds: 8),
  });

  final String repo;
  final Duration timeout;

  @override
  Future<UpdateInfo?> check(AppVersionInfo current) async {
    try {
      final json = await getJson(
        Uri.https('api.github.com', '/repos/$repo/releases', {
          'per_page': '10',
        }),
        timeout,
      );
      return parseGitHubReleases(json, current);
    } catch (e) {
      debugPrint('Update check skipped: $e');
      return null;
    }
  }
}

/// iOS cannot install apps itself: look up the App Store version and send
/// the user to the store page.
class AppStoreUpdateService implements AppUpdateService {
  const AppStoreUpdateService({
    required this.bundleId,
    this.timeout = const Duration(seconds: 8),
  });

  final String bundleId;
  final Duration timeout;

  @override
  Future<UpdateInfo?> check(AppVersionInfo current) async {
    try {
      final json = await getJson(
        Uri.https('itunes.apple.com', '/lookup', {'bundleId': bundleId}),
        timeout,
      );
      return parseAppStoreLookup(json, current);
    } catch (e) {
      debugPrint('Update check skipped: $e');
      return null;
    }
  }
}

final _buildTag = RegExp(r'^build-(\d+)$');
final _minBuild = RegExp(r'min_supported_build:\s*(\d+)');

/// Picks the newest `build-N` release with an APK newer than [current].
UpdateInfo? parseGitHubReleases(Object? json, AppVersionInfo current) {
  if (json is! List) return null;
  UpdateInfo? best;
  var bestBuild = current.build;
  for (final r in json.whereType<Map<String, dynamic>>()) {
    if (r['draft'] == true) continue;
    final match = _buildTag.firstMatch('${r['tag_name']}');
    if (match == null) continue;
    final build = int.parse(match.group(1)!);
    if (build <= bestBuild) continue;
    final apk = (r['assets'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .where((a) => '${a['name']}'.endsWith('.apk'))
        .firstOrNull;
    final url = apk?['browser_download_url'] ?? r['html_url'];
    if (url is! String) continue;
    final body = '${r['body'] ?? ''}';
    final minBuild = int.tryParse(_minBuild.firstMatch(body)?.group(1) ?? '');
    bestBuild = build;
    best = UpdateInfo(
      versionLabel: '${r['name'] ?? 'build $build'}',
      url: Uri.parse(url),
      notes: body.trim().isEmpty ? null : body.trim(),
      mandatory: minBuild != null && current.build < minBuild,
    );
  }
  return best;
}

UpdateInfo? parseAppStoreLookup(Object? json, AppVersionInfo current) {
  if (json is! Map) return null;
  final results = json['results'];
  if (results is! List || results.isEmpty) return null;
  final app = results.first as Map;
  final latest = '${app['version']}';
  final url = app['trackViewUrl'];
  if (url is! String || compareVersions(latest, current.version) <= 0) {
    return null;
  }
  return UpdateInfo(
    versionLabel: latest,
    url: Uri.parse(url),
    notes: app['releaseNotes'] as String?,
  );
}

/// Compares dotted versions numerically ("1.10.0" > "1.9.3").
int compareVersions(String a, String b) {
  List<int> parts(String v) =>
      v.split('.').map((p) => int.tryParse(p) ?? 0).toList();
  final pa = parts(a);
  final pb = parts(b);
  for (var i = 0; i < pa.length || i < pb.length; i++) {
    final x = i < pa.length ? pa[i] : 0;
    final y = i < pb.length ? pb[i] : 0;
    if (x != y) return x.compareTo(y);
  }
  return 0;
}

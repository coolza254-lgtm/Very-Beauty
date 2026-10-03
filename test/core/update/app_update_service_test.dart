import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/update/app_update_service.dart';

Map<String, dynamic> _release(
  int build, {
  bool draft = false,
  bool apk = true,
  String body = '',
}) => {
  'tag_name': 'build-$build',
  'name': 'Very Beauty v1.0.0 (build $build)',
  'draft': draft,
  'html_url': 'https://github.com/x/y/releases/tag/build-$build',
  'body': body,
  'assets': [
    if (apk)
      {
        'name': 'VeryBeauty-v1.0.0-build$build.apk',
        'browser_download_url':
            'https://github.com/x/y/releases/download/build-$build/a.apk',
      },
  ],
};

const _current = AppVersionInfo(version: '1.0.0', build: 5);

void main() {
  group('GitHub releases', () {
    test('picks the newest build above the installed one', () {
      final info = parseGitHubReleases([
        _release(7),
        _release(6),
        _release(4),
      ], _current)!;
      expect(info.versionLabel, 'Very Beauty v1.0.0 (build 7)');
      expect(info.url.path, endsWith('/build-7/a.apk'));
      expect(info.mandatory, isFalse);
    });

    test('only releases signed with the permanent key update in-app', () {
      expect(parseGitHubReleases([_release(7)], _current)!.apkUrl, isNull);
      final signed = parseGitHubReleases([
        _release(7, body: 'notes\nsigning: release\n'),
      ], _current)!;
      expect(signed.apkUrl!.path, endsWith('/build-7/a.apk'));
      expect(
        parseGitHubReleases([
          _release(7, apk: false, body: 'signing: release'),
        ], _current)!.apkUrl,
        isNull,
      );
    });

    test('per-CPU APKs are offered for in-app updates', () {
      final release = _release(7, body: 'signing: release')
        ..['assets'] = [
          {
            'name': 'VeryBeauty-v1.0.0-build7.apk',
            'browser_download_url': 'https://x/u.apk',
          },
          {
            'name': 'VeryBeauty-v1.0.0-build7-arm64-v8a.apk',
            'browser_download_url': 'https://x/arm64.apk',
          },
          {
            'name': 'VeryBeauty-v1.0.0-build7-armeabi-v7a.apk',
            'browser_download_url': 'https://x/arm32.apk',
          },
        ];
      final info = parseGitHubReleases([release], _current)!;
      expect(info.url.toString(), 'https://x/u.apk');
      expect(
        info.apkUrlFor(['arm64-v8a', 'armeabi-v7a']).toString(),
        'https://x/arm64.apk',
      );
      expect(info.apkUrlFor(['armeabi-v7a']).toString(), 'https://x/arm32.apk');
      expect(info.apkUrlFor(['x86']).toString(), 'https://x/u.apk');
      expect(info.apkUrlFor(const []).toString(), 'https://x/u.apk');
    });

    test('null when up to date, drafts ignored', () {
      expect(parseGitHubReleases([_release(5), _release(3)], _current), isNull);
      expect(parseGitHubReleases([_release(9, draft: true)], _current), isNull);
      expect(parseGitHubReleases('nonsense', _current), isNull);
      expect(
        parseGitHubReleases([
          {'tag_name': 'v2'},
        ], _current),
        isNull,
      );
    });

    test('falls back to the release page without an APK', () {
      final info = parseGitHubReleases([_release(8, apk: false)], _current)!;
      expect(info.url.toString(), contains('/releases/tag/build-8'));
    });

    test('min_supported_build makes the update mandatory', () {
      expect(
        parseGitHubReleases([
          _release(8, body: 'notes\nmin_supported_build: 6'),
        ], _current)!.mandatory,
        isTrue,
      );
      expect(
        parseGitHubReleases([
          _release(8, body: 'min_supported_build: 5'),
        ], _current)!.mandatory,
        isFalse,
      );
    });
  });

  group('App Store lookup', () {
    test('newer version', () {
      final info = parseAppStoreLookup({
        'resultCount': 1,
        'results': [
          {
            'version': '1.2.0',
            'trackViewUrl': 'https://apps.apple.com/app/id1',
          },
        ],
      }, _current)!;
      expect(info.versionLabel, '1.2.0');
    });

    test('same version or not on the store', () {
      expect(
        parseAppStoreLookup({
          'results': [
            {'version': '1.0.0', 'trackViewUrl': 'https://a'},
          ],
        }, _current),
        isNull,
      );
      expect(parseAppStoreLookup({'results': <Object>[]}, _current), isNull);
    });
  });

  test('compareVersions is numeric', () {
    expect(compareVersions('1.10.0', '1.9.3'), greaterThan(0));
    expect(compareVersions('1.0', '1.0.0'), 0);
    expect(compareVersions('0.9', '1.0'), lessThan(0));
  });
}

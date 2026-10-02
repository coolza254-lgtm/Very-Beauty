import 'dart:convert';
import 'dart:io';

/// Minimal GET returning decoded JSON. No cookies, ids or user data.
Future<Object?> getJson(
  Uri uri,
  Duration timeout, {
  String userAgent = 'VeryBeauty (github.com/coolza254-lgtm/Very-Beauty)',
}) async {
  final client = HttpClient()..connectionTimeout = timeout;
  try {
    final request = await client.getUrl(uri).timeout(timeout);
    request.headers
      ..set(HttpHeaders.acceptHeader, 'application/json')
      ..set(HttpHeaders.userAgentHeader, userAgent);
    final response = await request.close().timeout(timeout);
    if (response.statusCode != 200) {
      throw HttpException('HTTP ${response.statusCode}', uri: uri);
    }
    final body = await response.transform(utf8.decoder).join().timeout(timeout);
    return jsonDecode(body);
  } finally {
    client.close(force: true);
  }
}

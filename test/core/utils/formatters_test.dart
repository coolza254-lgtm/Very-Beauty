import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:very_beauty/core/utils/formatters.dart';

void main() {
  setUpAll(() => initializeDateFormatting('th'));

  test('formatNumber trims trailing zeros', () {
    expect(formatNumber(1250), '1,250');
    expect(formatNumber(12.5), '12.5');
    expect(formatNumber(1.236), '1.24');
  });

  test('formatBaht', () {
    expect(formatBaht(1250.4), '฿1,250');
    expect(formatBaht(11.8), '฿11.8');
  });

  test('formatShortDate uses Buddhist-era year in Thai', () {
    expect(formatShortDate(DateTime(2026, 10, 2), 'th'), '2 ต.ค. 2569');
  });

  test('parseNumber', () {
    expect(parseNumber(' 1,250.50 '), 1250.5);
    expect(parseNumber(''), isNull);
    expect(parseNumber('abc'), isNull);
    expect(parseNumber(null), isNull);
  });
}

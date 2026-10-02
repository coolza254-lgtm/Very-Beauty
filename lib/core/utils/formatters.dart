import 'package:intl/intl.dart';

final _number = NumberFormat('#,##0.##');
final _whole = NumberFormat('#,##0');

/// 1,234.5 — up to two decimals, no trailing zeros.
String formatNumber(num value) => _number.format(value);

/// ฿1,250 (whole baht) or ฿12.5 for small unit prices.
String formatBaht(num value) =>
    '฿${value.abs() >= 100 ? _whole.format(value) : _number.format(value)}';

/// Rounded percentage without the % sign.
String formatPercent(num value) => _whole.format(value.round());

/// Short date with the Buddhist-era year for Thai, e.g. "2 ต.ค. 2569".
String formatShortDate(DateTime date, String locale) {
  if (locale.startsWith('th')) {
    return '${DateFormat('d MMM', 'th').format(date)} ${date.year + 543}';
  }
  return DateFormat.yMMMd(locale).format(date);
}

/// Parses user input such as "1,250.50" or "12,5"; null when blank/invalid.
double? parseNumber(String? input) {
  final text = input?.trim().replaceAll(',', '');
  if (text == null || text.isEmpty) return null;
  return double.tryParse(text);
}

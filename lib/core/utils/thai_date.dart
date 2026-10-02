import 'package:intl/intl.dart';

/// Formats a date the way Thai users expect, with the Buddhist-era year,
/// e.g. "วันพฤหัสบดีที่ 2 ตุลาคม 2569". Falls back to the Gregorian year for
/// other locales.
String formatLongDate(DateTime date, String locale) {
  if (locale.startsWith('th')) {
    final dayMonth = DateFormat('EEEEที่ d MMMM', 'th').format(date);
    return '$dayMonth ${date.year + 543}';
  }
  return DateFormat.yMMMMEEEEd(locale).format(date);
}

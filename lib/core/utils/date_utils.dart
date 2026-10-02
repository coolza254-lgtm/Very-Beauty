/// Helpers for the two date formats used in storage (docs/SPEC.md §5):
/// epoch milliseconds (UTC) for timestamps, and a local `YYYY-MM-DD` key for
/// `daily_entries.date`.
library;

/// Formats a local calendar date as `YYYY-MM-DD`.
String toDateKey(DateTime date) {
  final local = date.isUtc ? date.toLocal() : date;
  final y = local.year.toString().padLeft(4, '0');
  final m = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

/// Parses a `YYYY-MM-DD` key into local midnight of that day.
DateTime fromDateKey(String key) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(key);
  if (match == null) {
    throw FormatException('Expected YYYY-MM-DD', key);
  }
  final date = DateTime(
    int.parse(match.group(1)!),
    int.parse(match.group(2)!),
    int.parse(match.group(3)!),
  );
  if (toDateKey(date) != key) {
    throw FormatException('Invalid calendar date', key);
  }
  return date;
}

/// Converts a timestamp to epoch milliseconds (UTC) for storage.
int toEpochMs(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

/// Converts stored epoch milliseconds back to a local [DateTime].
DateTime fromEpochMs(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

/// Whole calendar days from [from] to [to] (local dates, DST-safe).
int daysBetween(DateTime from, DateTime to) {
  final a = DateTime.utc(from.year, from.month, from.day);
  final b = DateTime.utc(to.year, to.month, to.day);
  return b.difference(a).inDays;
}

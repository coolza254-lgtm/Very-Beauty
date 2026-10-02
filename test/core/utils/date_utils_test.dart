import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/utils/date_utils.dart';

void main() {
  group('toDateKey', () {
    test('pads month and day', () {
      expect(toDateKey(DateTime(2026, 3, 7, 23, 59)), '2026-03-07');
    });

    test('converts UTC input to the local calendar date', () {
      final utc = DateTime.utc(2026, 1, 1, 12);
      expect(toDateKey(utc), toDateKey(utc.toLocal()));
    });
  });

  group('fromDateKey', () {
    test('round-trips with toDateKey', () {
      expect(fromDateKey('2026-12-31'), DateTime(2026, 12, 31));
      expect(toDateKey(fromDateKey('2024-02-29')), '2024-02-29');
    });

    test('rejects malformed or impossible dates', () {
      expect(() => fromDateKey('2026-2-1'), throwsFormatException);
      expect(() => fromDateKey('2026-02-30'), throwsFormatException);
      expect(() => fromDateKey(''), throwsFormatException);
    });
  });

  test('epoch ms round-trip', () {
    final now = DateTime(2026, 10, 2, 8, 30);
    expect(fromEpochMs(toEpochMs(now)), now);
  });

  group('daysBetween', () {
    test('counts calendar days regardless of time of day', () {
      expect(daysBetween(DateTime(2026, 1, 1, 23), DateTime(2026, 1, 2, 1)), 1);
      expect(daysBetween(DateTime(2026, 1, 1), DateTime(2026, 1, 1, 22)), 0);
    });

    test('is negative when going backwards', () {
      expect(daysBetween(DateTime(2026, 3, 10), DateTime(2026, 3, 1)), -9);
    });
  });
}

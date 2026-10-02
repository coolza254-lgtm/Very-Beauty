import 'package:flutter_test/flutter_test.dart';
import 'package:very_beauty/core/db/app_database.dart';
import 'package:very_beauty/core/db/settings_dao.dart';
import 'package:very_beauty/core/notifications/reminder_planner.dart';

final _texts = ReminderTexts(
  routineTitle: (n) => 'routine $n',
  routineBody: 'b',
  weighTitle: 'weigh',
  weighBody: 'b',
  expiryTitle: 'expiry',
  expiryBody: (n) => 'expires $n',
  backupTitle: 'backup',
  backupBody: 'b',
);

final _now = DateTime(2026, 10, 2, 9, 30);

Routine _routine(int id, {String? time, bool enabled = true}) => Routine(
  id: id,
  createdAt: 0,
  updatedAt: 0,
  name: 'R$id',
  timeOfDay: TimeOfDaySlot.morning,
  reminderTime: time,
  reminderEnabled: enabled,
);

Product _product(int id, {DateTime? expiry, ProductStatus? status}) => Product(
  id: id,
  createdAt: 0,
  updatedAt: 0,
  name: 'P$id',
  category: ProductCategory.serum,
  netUnit: NetUnit.g,
  status: status ?? ProductStatus.inUse,
  expiryDate: expiry?.millisecondsSinceEpoch,
);

List<PlannedReminder> _plan({
  List<Routine> routines = const [],
  List<Product> products = const [],
  Map<String, String> settings = const {},
  DateTime? lastBackupAt,
}) => planReminders(
  now: _now,
  routines: routines,
  products: products,
  settings: settings,
  texts: _texts,
  lastBackupAt: lastBackupAt,
);

void main() {
  test('nothing enabled, nothing planned', () {
    expect(_plan(routines: [_routine(1)], products: [_product(1)]), isEmpty);
  });

  test('daily routine reminders at their next occurrence', () {
    final plan = _plan(
      routines: [
        _routine(1, time: '07:00'),
        _routine(2, time: '21:15'),
        _routine(3, time: '22:00', enabled: false),
      ],
    );
    expect(plan.map((r) => r.id), [10001, 10002]);
    expect(plan[0].at, DateTime(2026, 10, 3, 7)); // already past today
    expect(plan[1].at, DateTime(2026, 10, 2, 21, 15));
    expect(plan.every((r) => r.repeat == ReminderRepeat.daily), isTrue);
    expect(plan[0].title, 'routine R1');
  });

  test('weekly weighing keeps the anchor weekday', () {
    final plan = _plan(
      settings: {
        SettingKeys.weighReminderDays: '7',
        SettingKeys.weighReminderAnchor:
            '${DateTime(2026, 9, 20).millisecondsSinceEpoch}',
      },
    );
    expect(plan.single.at, DateTime(2026, 10, 4, 20));
    expect(plan.single.repeat, ReminderRepeat.weekly);
  });

  test('biweekly weighing is a one-shot at the next interval', () {
    final plan = _plan(
      settings: {
        SettingKeys.weighReminderDays: '14',
        SettingKeys.weighReminderAnchor:
            '${DateTime(2026, 9, 20).millisecondsSinceEpoch}',
      },
    );
    expect(plan.single.at, DateTime(2026, 10, 4, 20));
    expect(plan.single.repeat, ReminderRepeat.none);
  });

  test('expiry reminders 7 days before, only for future active products', () {
    final plan = _plan(
      settings: {SettingKeys.expiryReminders: '1'},
      products: [
        _product(1, expiry: DateTime(2026, 11, 1)),
        _product(2, expiry: DateTime(2026, 10, 5)), // reminder already past
        _product(
          3,
          expiry: DateTime(2026, 12, 1),
          status: ProductStatus.finished,
        ),
      ],
    );
    expect(plan.single.id, 200001);
    expect(plan.single.at, DateTime(2026, 10, 25, 10));
    expect(plan.single.body, 'expires P1');
  });

  test('backup reminder 30 days after the last backup', () {
    expect(
      _plan(lastBackupAt: DateTime(2026, 9, 20)).single.at,
      DateTime(2026, 10, 20, 20),
    );
    // Overdue: remind this evening.
    expect(
      _plan(lastBackupAt: DateTime(2026, 6, 1)).single.at,
      DateTime(2026, 10, 2, 20),
    );
  });

  test('parseHourMinute', () {
    expect(parseHourMinute('07:05'), (7, 5));
    expect(parseHourMinute('24:00'), isNull);
    expect(parseHourMinute(null), isNull);
    expect(formatHourMinute(7, 5), '07:05');
  });
}

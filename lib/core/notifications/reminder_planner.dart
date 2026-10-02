import '../db/app_database.dart';
import '../db/settings_dao.dart';
import '../utils/calculations.dart';
import '../utils/date_utils.dart';

/// Notification ids are grouped by kind so a sync can tell them apart.
abstract final class ReminderIds {
  static const weigh = 1;
  static const backup = 2;
  static int routine(int routineId) => 10000 + routineId;
  static int expiry(int productId) => 200000 + productId;
}

enum ReminderRepeat { none, daily, weekly }

/// One notification to be scheduled.
class PlannedReminder {
  const PlannedReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.at,
    this.repeat = ReminderRepeat.none,
  });

  final int id;
  final String title;
  final String body;

  /// First occurrence (local time). For repeating reminders only the time
  /// of day (and weekday for weekly) matters.
  final DateTime at;
  final ReminderRepeat repeat;

  @override
  String toString() => 'PlannedReminder($id, $at, $repeat, $title)';
}

/// Localized texts used in reminders, so the planner stays pure.
class ReminderTexts {
  const ReminderTexts({
    required this.routineTitle,
    required this.routineBody,
    required this.weighTitle,
    required this.weighBody,
    required this.expiryTitle,
    required this.expiryBody,
    required this.backupTitle,
    required this.backupBody,
  });

  final String Function(String routineName) routineTitle;
  final String routineBody;
  final String weighTitle;
  final String weighBody;
  final String expiryTitle;
  final String Function(String productName) expiryBody;
  final String backupTitle;
  final String backupBody;
}

/// Time of day for non-routine reminders.
const _eveningHour = 20;
const _morningHour = 10;

/// Works out which local notifications should exist right now.
List<PlannedReminder> planReminders({
  required DateTime now,
  required List<Routine> routines,
  required List<Product> products,
  required Map<String, String> settings,
  required ReminderTexts texts,
  DateTime? lastBackupAt,
}) {
  final plan = <PlannedReminder>[];

  for (final r in routines) {
    final time = parseHourMinute(r.reminderTime);
    if (!r.reminderEnabled || time == null) continue;
    plan.add(
      PlannedReminder(
        id: ReminderIds.routine(r.id),
        title: texts.routineTitle(r.name),
        body: texts.routineBody,
        at: _nextAt(now, time.$1, time.$2),
        repeat: ReminderRepeat.daily,
      ),
    );
  }

  final weighDays = int.tryParse(settings[SettingKeys.weighReminderDays] ?? '');
  if (weighDays != null && weighDays > 0) {
    final anchorMs = int.tryParse(
      settings[SettingKeys.weighReminderAnchor] ?? '',
    );
    final anchor = anchorMs == null ? now : fromEpochMs(anchorMs);
    var next = DateTime(anchor.year, anchor.month, anchor.day, _eveningHour);
    while (!next.isAfter(now)) {
      next = DateTime(
        next.year,
        next.month,
        next.day + weighDays,
        _eveningHour,
      );
    }
    plan.add(
      PlannedReminder(
        id: ReminderIds.weigh,
        title: texts.weighTitle,
        body: texts.weighBody,
        at: next,
        repeat: weighDays == 7 ? ReminderRepeat.weekly : ReminderRepeat.none,
      ),
    );
  }

  if (settings[SettingKeys.expiryReminders] == '1') {
    for (final p in products) {
      if (p.status != ProductStatus.inUse && p.status != ProductStatus.paused) {
        continue;
      }
      final expiry = effectiveExpiry(
        expiryDate: p.expiryDate == null ? null : fromEpochMs(p.expiryDate!),
        openedDate: p.openedDate == null ? null : fromEpochMs(p.openedDate!),
        paoMonths: p.paoMonths,
      );
      if (expiry == null) continue;
      final at = DateTime(
        expiry.year,
        expiry.month,
        expiry.day - 7,
        _morningHour,
      );
      if (!at.isAfter(now)) continue;
      plan.add(
        PlannedReminder(
          id: ReminderIds.expiry(p.id),
          title: texts.expiryTitle,
          body: texts.expiryBody(p.name),
          at: at,
        ),
      );
    }
  }

  if (lastBackupAt != null) {
    var at = DateTime(
      lastBackupAt.year,
      lastBackupAt.month,
      lastBackupAt.day + 30,
      _eveningHour,
    );
    if (!at.isAfter(now)) at = _nextAt(now, _eveningHour, 0);
    plan.add(
      PlannedReminder(
        id: ReminderIds.backup,
        title: texts.backupTitle,
        body: texts.backupBody,
        at: at,
      ),
    );
  }

  return plan;
}

/// Parses `HH:mm`.
(int, int)? parseHourMinute(String? value) {
  final m = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(value ?? '');
  if (m == null) return null;
  final h = int.parse(m.group(1)!);
  final min = int.parse(m.group(2)!);
  if (h > 23 || min > 59) return null;
  return (h, min);
}

String formatHourMinute(int hour, int minute) =>
    '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

DateTime _nextAt(DateTime now, int hour, int minute) {
  final today = DateTime(now.year, now.month, now.day, hour, minute);
  return today.isAfter(now)
      ? today
      : DateTime(now.year, now.month, now.day + 1, hour, minute);
}

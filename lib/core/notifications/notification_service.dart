import 'dart:async';
import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_planner.dart';

/// Schedules local notifications. Nothing ever leaves the device.
abstract class NotificationService {
  /// Asks the OS for permission to show notifications. Returns true when
  /// granted (or when the platform does not need asking).
  Future<bool> requestPermission();

  /// Makes the pending notifications match [plan]: cancels ours that are not
  /// in it and (re)schedules everything that is.
  Future<void> sync(List<PlannedReminder> plan);
}

/// Used in tests and when the platform plugin is unavailable.
class NoopNotificationService implements NotificationService {
  List<PlannedReminder> lastPlan = const [];

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> sync(List<PlannedReminder> plan) async => lastPlan = plan;
}

class LocalNotificationService implements NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  Future<void>? _ready;

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'reminders',
      'Reminders',
      channelDescription: 'Skincare routine and product reminders',
      icon: 'ic_stat_notify',
      color: Color(0xFFC77D8E),
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> _init() => _ready ??= () async {
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e) {
      debugPrint('Falling back to UTC+7 for reminders: $e');
      tz.setLocalLocation(tz.getLocation('Asia/Bangkok'));
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_notify'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
  }();

  @override
  Future<bool> requestPermission() async {
    await _init();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return true;
  }

  @override
  Future<void> sync(List<PlannedReminder> plan) async {
    await _init();
    final wanted = {for (final r in plan) r.id};
    final pending = await _plugin.pendingNotificationRequests();
    for (final p in pending) {
      if (!wanted.contains(p.id)) await _plugin.cancel(id: p.id);
    }
    for (final r in plan) {
      await _plugin.zonedSchedule(
        id: r.id,
        title: r.title,
        body: r.body,
        scheduledDate: tz.TZDateTime.from(r.at, tz.local),
        notificationDetails: _details,
        // Inexact scheduling needs no special alarm permission; a few
        // minutes of drift is fine for skincare reminders.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: switch (r.repeat) {
          ReminderRepeat.daily => DateTimeComponents.time,
          ReminderRepeat.weekly => DateTimeComponents.dayOfWeekAndTime,
          ReminderRepeat.none => null,
        },
      );
    }
  }
}

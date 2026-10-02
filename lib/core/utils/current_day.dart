import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'date_utils.dart';

/// Today's local date (midnight). Updates at midnight and when the app
/// returns to the foreground, so "today" screens never go stale.
class CurrentDayNotifier extends Notifier<DateTime> {
  Timer? _timer;
  AppLifecycleListener? _lifecycle;

  @override
  DateTime build() {
    _lifecycle ??= AppLifecycleListener(onResume: _refresh);
    ref.onDispose(() {
      _timer?.cancel();
      _lifecycle?.dispose();
      _lifecycle = null;
    });
    _scheduleMidnight();
    return startOfDay(DateTime.now());
  }

  void _refresh() {
    final today = startOfDay(DateTime.now());
    if (today != state) state = today;
    _scheduleMidnight();
  }

  void _scheduleMidnight() {
    _timer?.cancel();
    final now = DateTime.now();
    final next = DateTime(now.year, now.month, now.day + 1, 0, 0, 5);
    _timer = Timer(next.difference(now), _refresh);
  }
}

final currentDayProvider = NotifierProvider<CurrentDayNotifier, DateTime>(
  CurrentDayNotifier.new,
);

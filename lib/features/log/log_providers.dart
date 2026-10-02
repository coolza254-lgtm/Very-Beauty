import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/daily_log_dao.dart';
import '../../core/db/providers.dart';

/// The skin log for a `YYYY-MM-DD` date, or null if none yet.
final dailyEntryProvider = StreamProvider.family<DailyEntryWithTags?, String>(
  (ref, date) => ref.watch(dailyLogDaoProvider).watchEntry(date),
);

final tagsProvider = StreamProvider<List<Tag>>(
  (ref) => ref.watch(dailyLogDaoProvider).watchTags(),
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/theme.dart';
import '../../core/db/app_database.dart';
import '../../core/db/insights_dao.dart';
import '../../core/db/providers.dart';
import '../../core/utils/current_day.dart';

/// The five skin scores of a daily entry.
enum SkinScore { oil, moisture, acne, redness, dullness }

extension SkinScoreX on SkinScore {
  int? of(DailyEntry e) => switch (this) {
    SkinScore.oil => e.scoreOil,
    SkinScore.moisture => e.scoreMoisture,
    SkinScore.acne => e.scoreAcne,
    SkinScore.redness => e.scoreRedness,
    SkinScore.dullness => e.scoreDullness,
  };

  String label(AppLocalizations l10n) => switch (this) {
    SkinScore.oil => l10n.scoreOil,
    SkinScore.moisture => l10n.scoreMoisture,
    SkinScore.acne => l10n.scoreAcne,
    SkinScore.redness => l10n.scoreRedness,
    SkinScore.dullness => l10n.scoreDullness,
  };
}

const _honey = Color(0xFFF2C76B);

/// Calm (1) → troubled (5) as mint → honey → rose.
Color troubleColor(double trouble) {
  final t = ((trouble - 1) / 4).clamp(0.0, 1.0);
  return t < 0.5
      ? Color.lerp(const Color(0xFFA8D8B4), _honey, t * 2)!
      : Color.lerp(_honey, BrandColors.rose, (t - 0.5) * 2)!;
}

class _SimpleNotifier<T> extends Notifier<T> {
  _SimpleNotifier(this._initial);

  final T Function(Ref ref) _initial;

  @override
  T build() => _initial(ref);

  void set(T value) => state = value;
}

NotifierProvider<_SimpleNotifier<T>, T> _state<T>(
  T Function(Ref ref) initial,
) => NotifierProvider<_SimpleNotifier<T>, T>(() => _SimpleNotifier<T>(initial));

/// Month shown on the calendar (first day).
final calendarMonthProvider = _state<DateTime>((ref) {
  final today = ref.read(currentDayProvider);
  return DateTime(today.year, today.month);
});

final monthMarksProvider =
    StreamProvider.family<Map<String, DayMarks>, DateTime>(
      (ref, month) => ref.watch(insightsDaoProvider).watchMonth(month),
    );

final daySummaryProvider = StreamProvider.family<DaySummary, String>(
  (ref, date) => ref.watch(insightsDaoProvider).watchDay(date),
);

/// Days shown on the score chart.
final chartRangeProvider = _state<int>((ref) => 30);
final chartScoreProvider = _state<SkinScore>((ref) => SkinScore.acne);

final chartEntriesProvider =
    StreamProvider.family<List<DailyEntry>, (DateTime, DateTime)>(
      (ref, range) =>
          ref.watch(insightsDaoProvider).watchEntries(range.$1, range.$2),
    );

final chartMarkersProvider =
    StreamProvider.family<List<ProductMarker>, (DateTime, DateTime)>(
      (ref, range) =>
          ref.watch(insightsDaoProvider).watchMarkers(range.$1, range.$2),
    );

final searchTagProvider = _state<int?>((ref) => null);

final taggedDaysProvider = StreamProvider.family<List<TaggedDay>, int>(
  (ref, tagId) => ref.watch(insightsDaoProvider).watchTaggedDays(tagId),
);

final monthlySpendingProvider = StreamProvider<List<MonthSpending>>(
  (ref) => ref
      .watch(insightsDaoProvider)
      .watchMonthlySpending(ref.watch(currentDayProvider)),
);

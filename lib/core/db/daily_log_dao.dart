import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'daily_log_dao.g.dart';

/// Period phase values stored in `daily_entries.period_phase`.
enum PeriodPhase { menstruation, follicular, ovulation, luteal }

class DailyEntryWithTags {
  const DailyEntryWithTags({required this.entry, required this.tagIds});

  final DailyEntry entry;
  final Set<int> tagIds;
}

/// Form values for one day's skin log. Every field is optional.
class DailyLogDraft {
  const DailyLogDraft({
    this.scoreOil,
    this.scoreMoisture,
    this.scoreAcne,
    this.scoreRedness,
    this.scoreDullness,
    this.sleepHours,
    this.stressLevel,
    this.sunExposure,
    this.periodPhase,
    this.note,
    this.tagIds = const {},
  });

  factory DailyLogDraft.fromEntry(DailyEntryWithTags? e) {
    final d = e?.entry;
    return DailyLogDraft(
      scoreOil: d?.scoreOil,
      scoreMoisture: d?.scoreMoisture,
      scoreAcne: d?.scoreAcne,
      scoreRedness: d?.scoreRedness,
      scoreDullness: d?.scoreDullness,
      sleepHours: d?.sleepHours,
      stressLevel: d?.stressLevel,
      sunExposure: d?.sunExposure,
      periodPhase: PeriodPhase.values
          .where((p) => p.name == d?.periodPhase)
          .firstOrNull,
      note: d?.note,
      tagIds: e?.tagIds ?? const {},
    );
  }

  final int? scoreOil;
  final int? scoreMoisture;
  final int? scoreAcne;
  final int? scoreRedness;
  final int? scoreDullness;
  final double? sleepHours;
  final int? stressLevel;
  final SunExposure? sunExposure;
  final PeriodPhase? periodPhase;
  final String? note;
  final Set<int> tagIds;

  DailyEntriesCompanion toCompanion(String date) {
    final trimmed = note?.trim();
    return DailyEntriesCompanion(
      date: Value(date),
      scoreOil: Value(scoreOil),
      scoreMoisture: Value(scoreMoisture),
      scoreAcne: Value(scoreAcne),
      scoreRedness: Value(scoreRedness),
      scoreDullness: Value(scoreDullness),
      sleepHours: Value(sleepHours),
      stressLevel: Value(stressLevel),
      sunExposure: Value(sunExposure),
      periodPhase: Value(periodPhase?.name),
      note: Value(trimmed == null || trimmed.isEmpty ? null : trimmed),
      updatedAt: Value(nowEpochMs()),
    );
  }
}

@DriftAccessor(tables: [DailyEntries, EntryTags, Tags])
class DailyLogDao extends DatabaseAccessor<AppDatabase>
    with _$DailyLogDaoMixin {
  DailyLogDao(super.attachedDatabase);

  Stream<DailyEntryWithTags?> watchEntry(String date) => attachedDatabase
      .watchTables([dailyEntries, entryTags], () => loadEntry(date));

  Future<DailyEntryWithTags?> loadEntry(String date) async {
    final entry = await (select(
      dailyEntries,
    )..where((e) => e.date.equals(date))).getSingleOrNull();
    if (entry == null) return null;
    final tagIds = await (select(
      entryTags,
    )..where((t) => t.entryId.equals(entry.id))).map((t) => t.tagId).get();
    return DailyEntryWithTags(entry: entry, tagIds: tagIds.toSet());
  }

  Stream<List<Tag>> watchTags() =>
      (select(tags)..orderBy([
            (t) => OrderingTerm.asc(t.type),
            (t) => OrderingTerm.asc(t.id),
          ]))
          .watch();

  /// Creates or updates the entry for [date] (`YYYY-MM-DD`) and replaces its
  /// tags.
  Future<int> saveEntry(String date, DailyLogDraft draft) =>
      transaction(() async {
        final id = await ensureEntry(date);
        await (update(
          dailyEntries,
        )..where((e) => e.id.equals(id))).write(draft.toCompanion(date));
        await (delete(entryTags)..where((t) => t.entryId.equals(id))).go();
        await batch((b) {
          b.insertAll(entryTags, [
            for (final tagId in draft.tagIds)
              EntryTagsCompanion.insert(entryId: id, tagId: tagId),
          ]);
        });
        return id;
      });

  /// Returns the id of the entry for [date], creating an empty one if needed
  /// (photos attach to a day's entry).
  Future<int> ensureEntry(String date) async {
    final existing = await (select(
      dailyEntries,
    )..where((e) => e.date.equals(date))).getSingleOrNull();
    return existing?.id ??
        into(dailyEntries).insert(DailyEntriesCompanion.insert(date: date));
  }

  /// Adds a user-defined tag, or returns the existing one with that name.
  Future<int> addTag(String name, TagType type) async {
    final trimmed = name.trim();
    final existing =
        await (select(tags)..where(
              (t) =>
                  t.name.equals(trimmed) &
                  t.type.equals(tagTypeConverter.toSql(type)),
            ))
            .getSingleOrNull();
    return existing?.id ??
        into(tags).insert(TagsCompanion.insert(name: trimmed, type: type));
  }
}

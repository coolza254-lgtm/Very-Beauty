import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'photos_dao.g.dart';

/// A photo with the local date of the day it belongs to.
class PhotoWithDate {
  const PhotoWithDate({required this.photo, required this.date});

  final Photo photo;

  /// `YYYY-MM-DD`.
  final String date;
}

@DriftAccessor(tables: [Photos, DailyEntries])
class PhotosDao extends DatabaseAccessor<AppDatabase> with _$PhotosDaoMixin {
  PhotosDao(super.attachedDatabase);

  JoinedSelectStatement<HasResultSet, dynamic> _withDate() => select(photos)
      .join([
        innerJoin(dailyEntries, dailyEntries.id.equalsExp(photos.dailyEntryId)),
      ]);

  PhotoWithDate _read(TypedResult row) => PhotoWithDate(
    photo: row.readTable(photos),
    date: row.readTable(dailyEntries).date,
  );

  /// Newest first.
  Stream<List<PhotoWithDate>> watchAll() =>
      (_withDate()..orderBy([OrderingTerm.desc(photos.takenAt)]))
          .map(_read)
          .watch();

  Future<List<PhotoWithDate>> forDate(String date) =>
      (_withDate()
            ..where(dailyEntries.date.equals(date))
            ..orderBy([OrderingTerm.asc(photos.takenAt)]))
          .map(_read)
          .get();

  /// The most recent photo, used as the onion-skin guide.
  Future<Photo?> latest() =>
      (select(photos)
            ..orderBy([(p) => OrderingTerm.desc(p.takenAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> addPhoto({
    required String date,
    required DateTime takenAt,
    required String filePath,
    required String thumbPath,
    required TimeOfDaySlot session,
    String? note,
  }) => transaction(() async {
    final existing = await (select(
      dailyEntries,
    )..where((e) => e.date.equals(date))).getSingleOrNull();
    final entryId =
        existing?.id ??
        await into(dailyEntries)
            .insert(DailyEntriesCompanion.insert(date: date));
    return into(photos).insert(
      PhotosCompanion.insert(
        dailyEntryId: entryId,
        takenAt: takenAt.millisecondsSinceEpoch,
        filePath: filePath,
        thumbPath: thumbPath,
        session: session,
        note: Value(note),
      ),
    );
  });

  Future<void> updateNote(int id, String? note) =>
      (update(photos)..where((p) => p.id.equals(id))).write(
        PhotosCompanion(
          note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
          updatedAt: Value(nowEpochMs()),
        ),
      );

  /// Deletes the row and returns it so the caller can remove its files.
  Future<Photo?> deletePhoto(int id) => transaction(() async {
    final photo = await (select(
      photos,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    if (photo != null) {
      await (delete(photos)..where((p) => p.id.equals(id))).go();
    }
    return photo;
  });
}

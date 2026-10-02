import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';

final routinesProvider = StreamProvider<List<Routine>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.routines,
  )..orderBy([(r) => OrderingTerm(expression: r.id)])).watch();
});

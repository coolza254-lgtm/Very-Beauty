import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/providers.dart';
import '../../core/db/routines_dao.dart';
import '../../core/utils/current_day.dart';

final routinesProvider = StreamProvider<List<RoutineWithSteps>>(
  (ref) => ref.watch(routinesDaoProvider).watchAll(),
);

final routineProvider = StreamProvider.family<RoutineWithSteps?, int>(
  (ref, id) => ref.watch(routinesDaoProvider).watchOne(id),
);

/// Routines with what has been ticked off today.
final todayProgressProvider = StreamProvider<List<RoutineProgress>>((ref) {
  final day = ref.watch(currentDayProvider);
  return ref.watch(routinesDaoProvider).watchProgress(day);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/photos_dao.dart';
import '../../core/db/providers.dart';

/// All photos, newest first.
final photosProvider = StreamProvider<List<PhotoWithDate>>(
  (ref) => ref.watch(photosDaoProvider).watchAll(),
);

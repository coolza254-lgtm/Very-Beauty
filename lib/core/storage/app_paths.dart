import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Where the app keeps its files. Photos live in the app's private documents
/// directory — never the shared gallery (docs/SPEC.md §3). Override in tests.
class AppPaths {
  const AppPaths(this.documents);

  final Directory documents;

  Directory get photos => Directory(p.join(documents.path, 'photos'));

  /// Absolute path for a path stored relative to [documents].
  String resolve(String relative) => p.join(documents.path, relative);

  /// Path relative to [documents], as stored in the database.
  String relativize(String absolute) =>
      p.relative(absolute, from: documents.path);
}

final appPathsProvider = FutureProvider<AppPaths>(
  (ref) async => AppPaths(await getApplicationDocumentsDirectory()),
);

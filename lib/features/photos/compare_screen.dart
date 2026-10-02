import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/db/photos_dao.dart';
import '../../core/storage/app_paths.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'photo_providers.dart';

/// Before/after slider: drag the divider to reveal one photo over the other.
class CompareScreen extends ConsumerStatefulWidget {
  const CompareScreen({
    super.key,
    required this.beforeId,
    required this.afterId,
  });

  final int beforeId;
  final int afterId;

  @override
  ConsumerState<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends ConsumerState<CompareScreen> {
  double _split = 0.5;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final photos = ref.watch(photosProvider).value ?? const <PhotoWithDate>[];
    final paths = ref.watch(appPathsProvider).value;
    PhotoWithDate? find(int id) =>
        photos.where((p) => p.photo.id == id).firstOrNull;
    final before = find(widget.beforeId);
    final after = find(widget.afterId);

    if (paths == null || before == null || after == null) {
      return const Scaffold(backgroundColor: Colors.black);
    }
    final days = daysBetween(
      fromDateKey(before.date),
      fromDateKey(after.date),
    ).abs();
    Widget photo(PhotoWithDate p) => Image.file(
      File(paths.resolve(p.photo.filePath)),
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const ColoredBox(color: Colors.black),
    );
    Widget label(String text, Alignment alignment) => Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${l10n.compareTitle} · ${l10n.compareDaysApart(days)}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, box) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate: (d) => setState(
            () => _split = (_split + d.delta.dx / box.maxWidth).clamp(0.0, 1.0),
          ),
          onTapDown: (d) => setState(
            () => _split = (d.localPosition.dx / box.maxWidth).clamp(0.0, 1.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              photo(after),
              ClipRect(clipper: _LeftClipper(_split), child: photo(before)),
              label(
                formatShortDate(fromDateKey(before.date), locale),
                Alignment.topLeft,
              ),
              label(
                formatShortDate(fromDateKey(after.date), locale),
                Alignment.topRight,
              ),
              Positioned(
                left: box.maxWidth * _split - 1.5,
                top: 0,
                bottom: 0,
                child: Container(width: 3, color: Colors.white),
              ),
              Positioned(
                left: box.maxWidth * _split - 22,
                top: box.maxHeight / 2 - 22,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(blurRadius: 8, color: Colors.black38),
                    ],
                  ),
                  child: Icon(
                    Icons.compare_arrows_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              label(l10n.compareHint, Alignment.bottomCenter),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftClipper extends CustomClipper<Rect> {
  const _LeftClipper(this.fraction);

  final double fraction;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(_LeftClipper oldClipper) => oldClipper.fraction != fraction;
}

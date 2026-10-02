import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/widgets/confirm_dialog.dart';
import '../../core/db/providers.dart';
import '../../core/storage/app_paths.dart';
import '../../core/storage/photo_storage.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/thai_date.dart';
import 'photo_providers.dart';

/// Full-screen photo pager with pinch zoom, note and delete.
class PhotoViewerScreen extends ConsumerStatefulWidget {
  const PhotoViewerScreen({super.key, required this.photoId});

  final int photoId;

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  PageController? _pages;
  int _index = 0;

  @override
  void dispose() {
    _pages?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final photos = ref.watch(photosProvider).value;
    final paths = ref.watch(appPathsProvider).value;
    if (photos == null || paths == null) {
      return const Scaffold(backgroundColor: Colors.black);
    }
    if (photos.isEmpty) {
      return Scaffold(appBar: AppBar());
    }
    if (_pages == null) {
      _index = photos
          .indexWhere((p) => p.photo.id == widget.photoId)
          .clamp(0, photos.length - 1);
      _pages = PageController(initialPage: _index);
    }
    _index = _index.clamp(0, photos.length - 1);
    final current = photos[_index];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${formatLongDate(fromDateKey(current.date), locale)} · '
          '${l10n.slot(current.photo.session)}',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          IconButton(
            tooltip: l10n.photoNote,
            icon: const Icon(Icons.edit_note_rounded),
            onPressed: () => _editNote(current.photo.id, current.photo.note),
          ),
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final ok = await confirmDialog(
                context,
                title: l10n.photoDeleteTitle,
                body: l10n.photoDeleteBody,
                confirm: l10n.actionDelete,
              );
              if (!ok) return;
              final deleted = await ref
                  .read(photosDaoProvider)
                  .deletePhoto(current.photo.id);
              if (deleted != null) {
                await PhotoStorage(paths).delete(
                  StoredPhoto(
                    filePath: deleted.filePath,
                    thumbPath: deleted.thumbPath,
                  ),
                );
              }
              if (photos.length <= 1 && context.mounted) context.pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pages,
              itemCount: photos.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) => InteractiveViewer(
                maxScale: 5,
                child: Center(
                  child: Image.file(
                    File(paths.resolve(photos[i].photo.filePath)),
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (current.photo.note != null)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  current.photo.note!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _editNote(int id, String? note) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(text: note);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.photoNote),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 4,
          minLines: 1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
    controller.dispose();
    if (result != null) {
      await ref.read(photosDaoProvider).updateNote(id, result);
    }
  }
}

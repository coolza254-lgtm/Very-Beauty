import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/router.dart';
import '../../app/widgets/empty_state_view.dart';
import '../../core/db/photos_dao.dart';
import '../../core/storage/app_paths.dart';
import '../../core/utils/date_utils.dart';
import 'photo_providers.dart';

/// Timeline of skin photos grouped by month. Uses thumbnails only so long
/// histories scroll smoothly (docs/SPEC.md §12).
class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  bool _comparing = false;
  final _selected = <int>[];

  void _toggle(int id) => setState(() {
    if (_selected.remove(id)) return;
    if (_selected.length == 2) _selected.removeAt(0);
    _selected.add(id);
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final photos = ref.watch(photosProvider);
    final paths = ref.watch(appPathsProvider).value;
    final items = photos.value ?? const <PhotoWithDate>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(_comparing ? l10n.photosSelectTwo : l10n.navPhotos),
        leading: _comparing
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => setState(() {
                  _comparing = false;
                  _selected.clear();
                }),
              )
            : null,
        actions: [
          if (!_comparing && items.length >= 2)
            TextButton.icon(
              icon: const Icon(Icons.compare_rounded),
              label: Text(l10n.photosCompare),
              onPressed: () => setState(() => _comparing = true),
            ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: _comparing
          ? (_selected.length == 2
                ? FloatingActionButton.extended(
                    onPressed: () {
                      final pair =
                          items
                              .where((p) => _selected.contains(p.photo.id))
                              .toList()
                            ..sort(
                              (a, b) =>
                                  a.photo.takenAt.compareTo(b.photo.takenAt),
                            );
                      context.push(
                        AppRoutes.photoCompare(
                          pair[0].photo.id,
                          pair[1].photo.id,
                        ),
                      );
                    },
                    icon: const Icon(Icons.compare_rounded),
                    label: Text(l10n.photosCompare),
                  )
                : null)
          : items.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.camera),
              icon: const Icon(Icons.photo_camera_outlined),
              label: Text(l10n.photosTake),
            ),
      body: switch (photos) {
        AsyncData() when items.isEmpty => EmptyStateView(
          icon: Icons.photo_camera_outlined,
          title: l10n.photosEmptyTitle,
          body: l10n.photosEmptyBody,
          action: FilledButton.icon(
            onPressed: () => context.push(AppRoutes.camera),
            icon: const Icon(Icons.photo_camera_outlined),
            label: Text(l10n.photosTake),
          ),
        ),
        AsyncData() when paths != null => _Timeline(
          items: items,
          paths: paths,
          comparing: _comparing,
          selected: _selected,
          onTap: (p) => _comparing
              ? _toggle(p.photo.id)
              : context.push(AppRoutes.photoView(p.photo.id)),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.items,
    required this.paths,
    required this.comparing,
    required this.selected,
    required this.onTap,
  });

  final List<PhotoWithDate> items;
  final AppPaths paths;
  final bool comparing;
  final List<int> selected;
  final ValueChanged<PhotoWithDate> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final groups = <String, List<PhotoWithDate>>{};
    for (final p in items) {
      groups.putIfAbsent(p.date.substring(0, 7), () => []).add(p);
    }
    String monthTitle(String yyyyMm) {
      final d = fromDateKey('$yyyyMm-01');
      final month = DateFormat.MMMM(locale).format(d);
      return '$month ${locale.startsWith('th') ? d.year + 543 : d.year}';
    }

    final dpr = MediaQuery.devicePixelRatioOf(context);
    return CustomScrollView(
      slivers: [
        for (final MapEntry(key: month, value: photos) in groups.entries) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
              child: Text(
                monthTitle(month),
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemCount: photos.length,
              itemBuilder: (context, i) {
                final p = photos[i];
                final order = selected.indexOf(p.photo.id);
                return _Thumb(
                  file: File(paths.resolve(p.photo.thumbPath)),
                  label: '${int.parse(p.date.substring(8))}',
                  cacheWidth: (130 * dpr).round(),
                  selectedOrder: comparing && order >= 0 ? order + 1 : null,
                  onTap: () => onTap(p),
                );
              },
            ),
          ),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 96)),
      ],
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.file,
    required this.label,
    required this.cacheWidth,
    required this.onTap,
    this.selectedOrder,
  });

  final File file;
  final String label;
  final int cacheWidth;
  final int? selectedOrder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: scheme.primaryContainer),
            Image.file(
              file,
              fit: BoxFit.cover,
              cacheWidth: cacheWidth,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) =>
                  Icon(Icons.broken_image_outlined, color: scheme.primary),
            ),
            Positioned(
              left: 8,
              bottom: 6,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
            ),
            if (selectedOrder != null)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.primary, width: 4),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(6),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: scheme.primary,
                  child: Text(
                    '$selectedOrder',
                    style: TextStyle(color: scheme.onPrimary, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

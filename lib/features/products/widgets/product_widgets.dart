import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/gen/app_localizations.dart';
import '../../../app/labels.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/soft_card.dart';
import '../../../core/db/app_database.dart';
import '../../../core/db/products_dao.dart';
import '../../../core/storage/app_paths.dart';
import '../../../core/utils/calculations.dart';
import '../../../core/utils/formatters.dart';

/// Rounded "เหลือประมาณ xx%" bar.
class RemainingBar extends StatelessWidget {
  const RemainingBar({super.key, required this.remaining, this.dense = false});

  final RemainingPercent? remaining;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final r = remaining;
    final label = r == null
        ? l10n.remainingUnknown
        : r.isEstimate
        ? l10n.remainingApprox(formatPercent(r.percent))
        : l10n.remainingExact(formatPercent(r.percent));
    final low = r != null && r.percent <= 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              (dense ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium)
                  ?.copyWith(
                    color: low ? scheme.error : scheme.onSurfaceVariant,
                    fontWeight: r == null ? FontWeight.w300 : FontWeight.w500,
                  ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: r == null ? 0 : r.percent / 100,
            minHeight: dense ? 6 : 10,
            backgroundColor: scheme.primaryContainer,
            color: low ? scheme.error : scheme.primary,
          ),
        ),
      ],
    );
  }
}

/// The product's own photo when it has one, otherwise its category icon.
/// Tapping a photo (when [zoomable]) shows it full screen.
class ProductThumb extends ConsumerWidget {
  const ProductThumb({
    super.key,
    required this.product,
    this.size = 48,
    this.zoomable = false,
  });

  final Product product;
  final double size;
  final bool zoomable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paths = ref.watch(appPathsProvider).value;
    final thumb = product.photoThumbPath;
    if (thumb == null || paths == null) {
      return CategoryBadge(category: product.category, size: size);
    }
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.3),
      child: Image.file(
        File(paths.resolve(thumb)),
        width: size,
        height: size,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (_, _, _) =>
            CategoryBadge(category: product.category, size: size),
      ),
    );
    final full = product.photoPath;
    if (!zoomable || full == null) return image;
    return GestureDetector(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              child: Image.file(File(paths.resolve(full))),
            ),
          ),
        ),
      ),
      child: image,
    );
  }
}

/// "กันแดด · เซรั่ม" — every category of a product, main one first.
String categoryLabels(AppLocalizations l10n, Product p) =>
    p.categories.map(l10n.category).join(' · ');

/// Category icon in a pastel circle.
class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.category, this.size = 48});

  final ProductCategory category;
  final double size;

  @override
  Widget build(BuildContext context) => PastelIconBadge(
    icon: categoryIcon(category),
    color: categoryColor(category),
    size: size,
  );
}

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final ProductStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final (bg, fg) = switch (status) {
      ProductStatus.inUse => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      ProductStatus.wishlist => (BrandColors.lavender, BrandColors.cocoa),
      ProductStatus.paused => (BrandColors.butter, BrandColors.cocoa),
      ProductStatus.finished => (
        scheme.surfaceContainer,
        scheme.onSurfaceVariant,
      ),
    };
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHigh : bg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        AppLocalizations.of(context).status(status),
        style: theme.textTheme.labelSmall?.copyWith(
          color: isDark ? scheme.onSurface : fg,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item, this.onTap});

  final ProductWithMetrics item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = item.product;
    final perUnit = item.metrics.pricePerUnit;
    final showBar =
        p.status == ProductStatus.inUse || p.status == ProductStatus.paused;
    return SoftCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductThumb(product: p),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.name,
                        style: theme.textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusPill(status: p.status),
                  ],
                ),
                Text(
                  [
                    if (p.brand != null) p.brand!,
                    categoryLabels(l10n, p),
                    if (perUnit != null)
                      l10n.perUnitShort(
                        formatNumber(perUnit),
                        l10n.unit(p.netUnit),
                      ),
                  ].join(' · '),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (showBar) ...[
                  const SizedBox(height: 10),
                  RemainingBar(remaining: item.metrics.remaining, dense: true),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small labelled number used in grids on the detail screen.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    this.caption,
  });

  final String label;
  final String value;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (caption != null)
            Text(
              caption!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

/// Two-column grid of [StatTile]s that sizes itself to its content.
class StatGrid extends StatelessWidget {
  const StatGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += 2) {
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: children[i]),
              const SizedBox(width: 12),
              Expanded(
                child: i + 1 < children.length
                    ? children[i + 1]
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
      if (i + 2 < children.length) rows.add(const SizedBox(height: 12));
    }
    return Column(children: rows);
  }
}

/// Tappable 1–5 star row.
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 36,
  });

  final int? value;
  final ValueChanged<int?>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          InkResponse(
            onTap: onChanged == null
                ? null
                : () => onChanged!(value == i ? null : i),
            radius: size * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(
                i <= (value ?? 0)
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: size,
                color: color,
              ),
            ),
          ),
      ],
    );
  }
}

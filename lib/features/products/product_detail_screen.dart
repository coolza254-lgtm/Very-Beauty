import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/confirm_dialog.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/products_dao.dart';
import '../../core/db/providers.dart';
import '../../core/utils/calculations.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'finish_sheet.dart';
import 'product_providers.dart';
import 'weigh_sheet.dart';
import 'widgets/product_widgets.dart';
import 'widgets/weight_chart.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));
    return switch (details) {
      AsyncData(value: final d?) => _Detail(details: d),
      AsyncData() => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(AppLocalizations.of(context).productNotFound)),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('$error')),
      ),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}

enum _MenuAction { edit, finish, reopen, startUsing, pause, delete }

class _Detail extends ConsumerWidget {
  const _Detail({required this.details});

  final ProductDetails details;

  Product get p => details.product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final m = details.metrics;
    final isActive =
        p.status == ProductStatus.inUse || p.status == ProductStatus.paused;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(AppRoutes.productEdit(p.id)),
          ),
          PopupMenuButton<_MenuAction>(
            onSelected: (a) => _onMenu(context, ref, a),
            itemBuilder: (_) => [
              if (isActive)
                PopupMenuItem(
                  value: _MenuAction.finish,
                  child: Text(l10n.finishAction),
                ),
              if (p.status == ProductStatus.inUse)
                PopupMenuItem(
                  value: _MenuAction.pause,
                  child: Text(l10n.actionPause),
                ),
              if (p.status == ProductStatus.paused ||
                  p.status == ProductStatus.wishlist)
                PopupMenuItem(
                  value: _MenuAction.startUsing,
                  child: Text(l10n.actionStartUsing),
                ),
              if (p.status == ProductStatus.finished)
                PopupMenuItem(
                  value: _MenuAction.reopen,
                  child: Text(l10n.actionReopen),
                ),
              PopupMenuItem(
                value: _MenuAction.delete,
                child: Text(l10n.actionDelete),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: isActive
          ? FloatingActionButton.extended(
              onPressed: () => showWeighSheet(
                context,
                productId: p.id,
                productName: p.name,
                previousWeight: m.latestWeight,
                startWeight: p.startWeight,
              ),
              icon: const Icon(Icons.scale_outlined),
              label: Text(l10n.weighNow),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        children: [
          _Header(details: details),
          if (m.weightAnomaly) ...[
            const SizedBox(height: 12),
            _WarningCard(text: l10n.weightAnomaly),
          ],
          SectionTitle(l10n.valueSection),
          _Stats(details: details),
          if (p.status == ProductStatus.wishlist) ...[
            SectionTitle(l10n.wishlistCompare),
            _WishlistCompare(product: p, perUnit: m.pricePerUnit),
          ],
          if (details.weighings.isNotEmpty) ...[
            SectionTitle(l10n.weightHistory),
            _WeightHistory(details: details),
          ],
          if (p.status != ProductStatus.wishlist) ...[
            SectionTitle(l10n.skinWhileUsing),
            _SkinScores(details: details),
          ],
          SectionTitle(l10n.infoSection),
          _Info(details: details),
        ],
      ),
    );
  }

  Future<void> _onMenu(
    BuildContext context,
    WidgetRef ref,
    _MenuAction action,
  ) async {
    final dao = ref.read(productsDaoProvider);
    final l10n = AppLocalizations.of(context);
    switch (action) {
      case _MenuAction.edit:
        await context.push(AppRoutes.productEdit(p.id));
      case _MenuAction.finish:
        await showFinishSheet(context, productId: p.id);
      case _MenuAction.reopen || _MenuAction.startUsing:
        await dao.setStatus(p.id, ProductStatus.inUse);
      case _MenuAction.pause:
        await dao.setStatus(p.id, ProductStatus.paused);
      case _MenuAction.delete:
        final ok = await confirmDialog(
          context,
          title: l10n.deleteProductTitle,
          body: l10n.deleteProductBody,
          confirm: l10n.actionDelete,
        );
        if (ok && context.mounted) {
          context.pop();
          await dao.deleteProduct(p.id);
        }
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = details.product;
    return SoftCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme.colorScheme.primaryContainer,
          theme.colorScheme.surfaceContainerLowest,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CategoryBadge(category: p.category, size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: theme.textTheme.titleLarge),
                    Text(
                      [
                        if (p.brand != null) p.brand!,
                        l10n.category(p.category),
                        if (p.netContent != null)
                          '${formatNumber(p.netContent!)} ${l10n.unit(p.netUnit)}',
                      ].join(' · '),
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    StatusPill(status: p.status),
                  ],
                ),
              ),
            ],
          ),
          if (p.status != ProductStatus.wishlist) ...[
            const SizedBox(height: 20),
            RemainingBar(remaining: details.metrics.remaining),
          ],
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  const _WarningCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: scheme.error),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final m = details.metrics;
    final p = details.product;
    final unit = l10n.unit(p.netUnit);
    String or(String? v) => v ?? '–';
    final isWishlist = p.status == ProductStatus.wishlist;

    return StatGrid(
      children: [
        StatTile(
          label: l10n.statPricePerUnit(unit),
          value: or(
            m.pricePerUnit == null ? null : formatBaht(m.pricePerUnit!),
          ),
          caption: p.price == null ? null : formatBaht(p.price!),
        ),
        if (!isWishlist) ...[
          StatTile(
            label: l10n.statCostPerUse,
            value: or(m.costPerUse == null ? null : formatBaht(m.costPerUse!)),
            caption: '${l10n.statUsageCount} ${details.usageCount}',
          ),
          StatTile(
            label: l10n.statEmptyOn,
            value: m.predictedEmpty == null
                ? l10n.notEnoughData
                : formatShortDate(m.predictedEmpty!, locale),
          ),
          StatTile(
            label: l10n.statPerDay,
            value: or(
              m.dailyUsage == null
                  ? null
                  : '${formatNumber(m.dailyUsage!)} ${l10n.unitG}',
            ),
          ),
          StatTile(
            label: l10n.statUsed,
            value: or(
              m.usedGrams == null
                  ? null
                  : '${formatNumber(m.usedGrams!)} ${l10n.unitG}',
            ),
            caption: m.costUsed == null
                ? null
                : '${l10n.statCostUsed} ${formatBaht(m.costUsed!)}',
          ),
          StatTile(
            label: l10n.statRemaining,
            value: or(
              m.remainingGrams == null
                  ? null
                  : '${formatNumber(m.remainingGrams!)} ${l10n.unitG}',
            ),
          ),
        ],
      ],
    );
  }
}

class _WeightHistory extends ConsumerWidget {
  const _WeightHistory({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final logs = details.weighings;
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(12, 20, 20, 8),
      child: Column(
        children: [
          if (logs.length >= 2) ...[
            WeightChart(weighings: logs),
            const SizedBox(height: 12),
          ],
          for (final (i, log) in logs.reversed.indexed)
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 8),
              title: Text(
                '${formatNumber(log.weight)} ${l10n.unitG}',
                style: theme.textTheme.titleSmall,
              ),
              subtitle: Text(
                formatShortDate(fromEpochMs(log.weighedAt), locale),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (i + 1 < logs.length)
                    Text(
                      _diff(log.weight - logs[logs.length - 2 - i].weight),
                      style: theme.textTheme.bodySmall,
                    ),
                  IconButton(
                    tooltip: l10n.actionDelete,
                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                    onPressed: () async {
                      final ok = await confirmDialog(
                        context,
                        title: l10n.deleteWeighingTitle,
                        confirm: l10n.actionDelete,
                      );
                      if (ok) {
                        await ref
                            .read(productsDaoProvider)
                            .deleteWeighing(log.id);
                      }
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _diff(double d) =>
      '${d > 0
          ? '+'
          : d < 0
          ? '−'
          : '±'}${formatNumber(d.abs())}';
}

class _SkinScores extends StatelessWidget {
  const _SkinScores({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final s = details.skinScores;
    if (s.isEmpty) {
      return SoftCard(
        child: Text(
          l10n.skinWhileUsingEmpty,
          style: theme.textTheme.bodyMedium,
        ),
      );
    }
    final rows = [
      (l10n.scoreOil, s.oil),
      (l10n.scoreMoisture, s.moisture),
      (l10n.scoreAcne, s.acne),
      (l10n.scoreRedness, s.redness),
      (l10n.scoreDullness, s.dullness),
    ];
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, value) in rows)
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(label, style: theme.textTheme.bodyMedium),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: value / 5,
                          minHeight: 8,
                          backgroundColor: theme.colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      value.toStringAsFixed(1),
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
          Text(
            l10n.basedOnDays(details.daysWithSkinLog),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _WishlistCompare extends ConsumerWidget {
  const _WishlistCompare({required this.product, required this.perUnit});

  final Product product;
  final double? perUnit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mine = perUnit;
    if (mine == null) {
      return SoftCard(child: Text(l10n.wishlistCompareNeedsPrice));
    }
    final others = (ref.watch(productsProvider).value ?? const [])
        .where(
          (o) =>
              o.product.id != product.id &&
              o.product.category == product.category &&
              o.product.status != ProductStatus.wishlist &&
              o.metrics.pricePerUnit != null,
        )
        .toList();
    if (others.isEmpty) {
      return SoftCard(child: Text(l10n.wishlistCompareEmpty));
    }
    return SoftCard(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          for (final o in others)
            ListTile(
              leading: CategoryBadge(category: o.product.category, size: 36),
              title: Text(o.product.name),
              subtitle: Text(
                l10n.perUnitShort(
                  formatNumber(o.metrics.pricePerUnit!),
                  l10n.unit(o.product.netUnit),
                ),
              ),
              trailing: Text(
                _compare(l10n, mine, o.metrics.pricePerUnit!),
                style: theme.textTheme.labelLarge,
              ),
              onTap: () => context.push(AppRoutes.productDetail(o.product.id)),
            ),
        ],
      ),
    );
  }

  String _compare(AppLocalizations l10n, double mine, double other) {
    final pct = (mine - other) / other * 100;
    if (pct.abs() < 3) return l10n.samePrice;
    return pct < 0
        ? l10n.cheaperBy(formatPercent(-pct))
        : l10n.pricierBy(formatPercent(pct));
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final p = details.product;
    String? date(int? ms) =>
        ms == null ? null : formatShortDate(fromEpochMs(ms), locale);
    final expiry = effectiveExpiry(
      expiryDate: p.expiryDate == null ? null : fromEpochMs(p.expiryDate!),
      openedDate: p.openedDate == null ? null : fromEpochMs(p.openedDate!),
      paoMonths: p.paoMonths,
    );

    final rows = <(String, String?)>[
      (l10n.fieldOpenedDate, date(p.openedDate)),
      (l10n.fieldPao, p.paoMonths?.toString()),
      (l10n.expiresOn, expiry == null ? null : formatShortDate(expiry, locale)),
      (l10n.fieldPurchaseDate, date(p.purchaseDate)),
      (l10n.fieldPurchasePlace, p.purchasePlace),
      (
        l10n.fieldStartWeight,
        p.startWeight == null ? null : formatNumber(p.startWeight!),
      ),
      (
        l10n.fieldEmptyWeight,
        p.emptyBottleWeight == null ? null : formatNumber(p.emptyBottleWeight!),
      ),
      (l10n.finishedOn, date(p.finishedDate)),
      (
        l10n.repurchaseLabel,
        p.repurchase == null
            ? null
            : p.repurchase!
            ? l10n.repurchaseYes
            : l10n.repurchaseNo,
      ),
    ].where((r) => r.$2 != null).toList();

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.rating != null) ...[
            Text(l10n.ratingLabel, style: theme.textTheme.bodySmall),
            StarRating(value: p.rating, size: 24),
            const SizedBox(height: 12),
          ],
          for (final (label, value) in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(label, style: theme.textTheme.bodyMedium),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      value!,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          if (details.ingredients.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(l10n.fieldIngredients, style: theme.textTheme.bodySmall),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final i in details.ingredients)
                  Chip(label: Text(i), visualDensity: VisualDensity.compact),
              ],
            ),
          ],
          if (p.note != null) ...[
            const SizedBox(height: 12),
            Text(l10n.fieldNote, style: theme.textTheme.bodySmall),
            Text(p.note!, style: theme.textTheme.bodyLarge),
          ],
          if (rows.isEmpty &&
              p.rating == null &&
              details.ingredients.isEmpty &&
              p.note == null)
            Text('–', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/empty_state_view.dart';
import '../../core/db/app_database.dart';
import 'product_providers.dart';
import 'widgets/product_widgets.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final all = ref.watch(productsProvider);
    final filtered = ref.watch(filteredProductsProvider);
    final hasAny = all.value?.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProducts),
        actions: [
          IconButton(
            tooltip: l10n.scanTitle,
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () => context.push(AppRoutes.productScan),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: hasAny
          ? FloatingActionButton.extended(
              onPressed: () => context.push(
                ref.read(productFilterProvider).status == ProductStatus.wishlist
                    ? AppRoutes.productNewWishlist
                    : AppRoutes.productNew,
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.productsAdd),
            )
          : null,
      body: switch (all) {
        AsyncData(value: []) => EmptyStateView(
          icon: Icons.spa_outlined,
          title: l10n.productsEmptyTitle,
          body: l10n.productsEmptyBody,
          action: FilledButton.icon(
            onPressed: () => context.push(AppRoutes.productNew),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.productsAdd),
          ),
        ),
        AsyncData() => Column(
          children: [
            const _Filters(),
            Expanded(
              child: switch (filtered) {
                AsyncData(value: final items) when items.isEmpty => Center(
                  child: Text(
                    l10n.productsNoMatch,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                AsyncData(value: final items) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => ProductCard(
                    item: items[i],
                    onTap: () => context.push(
                      AppRoutes.productDetail(items[i].product.id),
                    ),
                  ),
                ),
                _ => const SizedBox(),
              },
            ),
          ],
        ),
        AsyncError(:final error) => Center(child: Text('$error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Filters extends ConsumerWidget {
  const _Filters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final filter = ref.watch(productFilterProvider);
    final notifier = ref.read(productFilterProvider.notifier);

    Widget chips<T>(
      List<T?> values,
      T? selected,
      String Function(T?) label,
      ValueChanged<T?> onSelected,
    ) => SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) => ChoiceChip(
          label: Text(label(values[i])),
          selected: values[i] == selected,
          showCheckmark: false,
          onSelected: (_) => onSelected(values[i]),
        ),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: TextField(
            onChanged: notifier.setQuery,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.productsSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              isDense: true,
            ),
          ),
        ),
        chips<ProductStatus>(
          [null, ...productStatusOrder],
          filter.status,
          (s) => s == null ? l10n.filterAll : l10n.status(s),
          notifier.setStatus,
        ),
        const SizedBox(height: 4),
        chips<ProductCategory>(
          [null, ...ProductCategory.values],
          filter.category,
          (c) => c == null ? l10n.filterAll : l10n.category(c),
          notifier.setCategory,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

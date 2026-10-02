import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/products_dao.dart';
import '../../core/db/providers.dart';

final productsProvider = StreamProvider<List<ProductWithMetrics>>(
  (ref) => ref.watch(productsDaoProvider).watchAll(),
);

final productDetailsProvider = StreamProvider.family<ProductDetails?, int>(
  (ref, id) => ref.watch(productsDaoProvider).watchDetails(id),
);

class ProductFilter {
  const ProductFilter({this.status, this.category, this.query = ''});

  final ProductStatus? status;
  final ProductCategory? category;
  final String query;

  bool matches(Product p) {
    if (status != null && p.status != status) return false;
    if (category != null && p.category != category) return false;
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return p.name.toLowerCase().contains(q) ||
        (p.brand?.toLowerCase().contains(q) ?? false);
  }
}

class ProductFilterNotifier extends Notifier<ProductFilter> {
  @override
  ProductFilter build() => const ProductFilter();

  void setStatus(ProductStatus? status) => state = ProductFilter(
    status: status,
    category: state.category,
    query: state.query,
  );

  void setCategory(ProductCategory? category) => state = ProductFilter(
    status: state.status,
    category: category,
    query: state.query,
  );

  void setQuery(String query) => state = ProductFilter(
    status: state.status,
    category: state.category,
    query: query,
  );
}

final productFilterProvider =
    NotifierProvider<ProductFilterNotifier, ProductFilter>(
      ProductFilterNotifier.new,
    );

/// Display order for status filters and list grouping.
const productStatusOrder = [
  ProductStatus.inUse,
  ProductStatus.paused,
  ProductStatus.wishlist,
  ProductStatus.finished,
];

/// Products matching the current filter, active ones first.
final filteredProductsProvider = Provider<AsyncValue<List<ProductWithMetrics>>>(
  (ref) {
    final filter = ref.watch(productFilterProvider);
    return ref.watch(productsProvider).whenData((all) {
      final matching = all.where((p) => filter.matches(p.product)).toList();
      // Stable sort: keep newest-first within each status.
      final rank = {for (final (i, p) in matching.indexed) p: i};
      return matching..sort((a, b) {
        final byStatus = productStatusOrder
            .indexOf(a.product.status)
            .compareTo(productStatusOrder.indexOf(b.product.status));
        return byStatus != 0 ? byStatus : rank[a]!.compareTo(rank[b]!);
      });
    });
  },
);

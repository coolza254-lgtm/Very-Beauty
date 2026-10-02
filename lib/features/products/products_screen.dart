import 'package:flutter/material.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/widgets/empty_state_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProducts)),
      body: EmptyStateView(
        icon: Icons.spa_outlined,
        title: l10n.productsEmptyTitle,
        body: l10n.productsEmptyBody,
      ),
    );
  }
}

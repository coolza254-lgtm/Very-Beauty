import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/db/providers.dart';
import 'widgets/product_widgets.dart';

/// Closes a product as finished with an optional rating and repurchase choice.
Future<void> showFinishSheet(BuildContext context, {required int productId}) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => _FinishSheet(productId: productId),
    );

class _FinishSheet extends ConsumerStatefulWidget {
  const _FinishSheet({required this.productId});

  final int productId;

  @override
  ConsumerState<_FinishSheet> createState() => _FinishSheetState();
}

class _FinishSheetState extends ConsumerState<_FinishSheet> {
  int? _rating;
  bool? _repurchase;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.finishTitle, style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),
          Text(l10n.finishRating, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Center(
            child: StarRating(
              value: _rating,
              onChanged: (v) => setState(() => _rating = v),
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.finishRepurchase, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            emptySelectionAllowed: true,
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: true,
                label: Text(l10n.repurchaseYes),
                icon: const Icon(Icons.favorite_rounded),
              ),
              ButtonSegment(
                value: false,
                label: Text(l10n.repurchaseNo),
                icon: const Icon(Icons.heart_broken_outlined),
              ),
            ],
            selected: {?_repurchase},
            onSelectionChanged: (s) =>
                setState(() => _repurchase = s.isEmpty ? null : s.single),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () async {
              await ref
                  .read(productsDaoProvider)
                  .finishProduct(
                    widget.productId,
                    rating: _rating,
                    repurchase: _repurchase,
                  );
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
  }
}

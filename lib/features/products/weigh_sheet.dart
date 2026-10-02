import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/db/providers.dart';
import '../../core/utils/calculations.dart';
import '../../core/utils/formatters.dart';

/// Bottom sheet with a large number field for a quick weighing. The number
/// keyboard opens immediately and the change since the last weighing updates
/// as you type (docs/SPEC.md §7.2).
Future<void> showWeighSheet(
  BuildContext context, {
  required int productId,
  required String productName,
  double? previousWeight,
  double? startWeight,
  double? netContent,
  double? packagingWeight,
  bool isMillilitres = false,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _WeighSheet(
    productId: productId,
    productName: productName,
    previousWeight: previousWeight,
    startWeight: startWeight,
    netContent: netContent,
    packagingWeight: packagingWeight,
    isMillilitres: isMillilitres,
  ),
);

class _WeighSheet extends ConsumerStatefulWidget {
  const _WeighSheet({
    required this.productId,
    required this.productName,
    this.previousWeight,
    this.startWeight,
    this.netContent,
    this.packagingWeight,
    this.isMillilitres = false,
  });

  final int productId;
  final String productName;
  final double? previousWeight;
  final double? startWeight;
  final double? netContent;

  /// Known container weight (measured or derived), if any.
  final double? packagingWeight;
  final bool isMillilitres;

  @override
  ConsumerState<_WeighSheet> createState() => _WeighSheetState();
}

class _WeighSheetState extends ConsumerState<_WeighSheet> {
  final _controller = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? get _value {
    final v = parseNumber(_controller.text);
    return v == null || v <= 0 ? null : v;
  }

  Future<void> _save() async {
    final v = _value;
    if (v == null || _saving) return;
    setState(() => _saving = true);
    await ref.read(productsDaoProvider).addWeighing(widget.productId, v);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final v = _value;
    final prev = widget.previousWeight;

    String? info;
    String? preview;
    var warn = false;
    if (prev == null) {
      info = l10n.weighFirst;
      // First full weighing: container = total − label net content.
      final net = widget.netContent;
      if (v != null && net != null && widget.packagingWeight == null) {
        final packaging = packagingWeight(
          emptyBottle: null,
          start: v,
          netContent: net,
        );
        if (packaging != null) {
          preview = l10n.weighPackagingPreview(
            formatNumber(packaging),
            formatNumber(v),
            formatNumber(net),
          );
        }
      }
    } else if (v != null) {
      final diff = v - prev;
      info = l10n.weighDiff(
        '${diff > 0
            ? '+'
            : diff < 0
            ? '−'
            : '±'}${formatNumber(diff.abs())}',
      );
      final start = widget.startWeight;
      warn = diff > 0 || (start != null && v > start);
      final packaging = widget.packagingWeight;
      if (packaging != null && start != null && start > packaging) {
        final left = v - packaging < 0 ? 0.0 : v - packaging;
        final percent = (left / (start - packaging) * 100).clamp(0, 100);
        preview = l10n.weighRemainingPreview(
          formatNumber(left),
          percent.round().toString(),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.weighTitle, style: theme.textTheme.titleLarge),
          Text(widget.productName, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            autofocus: true,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 44,
              color: scheme.primary,
            ),
            decoration: InputDecoration(
              hintText: prev == null ? '0' : formatNumber(prev),
              suffixText: l10n.unitG,
              helperText: l10n.weighHint,
            ),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 12),
          if (info != null)
            Text(
              warn ? '$info · ${l10n.weighHeavier}' : info,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: warn ? scheme.error : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (preview != null) ...[
            const SizedBox(height: 6),
            Text(
              preview,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: scheme.primary,
              ),
            ),
          ],
          if (preview != null && widget.isMillilitres)
            Text(
              l10n.weighMlNote,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: v == null || _saving ? null : _save,
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
  }
}

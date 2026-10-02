import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/db/providers.dart';
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
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _WeighSheet(
    productId: productId,
    productName: productName,
    previousWeight: previousWeight,
    startWeight: startWeight,
  ),
);

class _WeighSheet extends ConsumerStatefulWidget {
  const _WeighSheet({
    required this.productId,
    required this.productName,
    this.previousWeight,
    this.startWeight,
  });

  final int productId;
  final String productName;
  final double? previousWeight;
  final double? startWeight;

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
    var warn = false;
    if (prev == null) {
      info = l10n.weighFirst;
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

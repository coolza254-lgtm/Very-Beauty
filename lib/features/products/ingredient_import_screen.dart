import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/theme.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/ingredients/ingredient_db.dart';
import '../../core/ingredients/ingredient_list_parser.dart';
import '../../core/ingredients/ingredient_text_scanner.dart';

/// Opens [IngredientImportScreen]; returns the names to add (INCI names for
/// matches, the original text otherwise), or null when cancelled.
Future<List<String>?> importIngredients(
  BuildContext context, {
  bool scan = false,
}) => Navigator.of(context).push<List<String>>(
  MaterialPageRoute(
    fullscreenDialog: true,
    builder: (_) => IngredientImportScreen(startWithScan: scan),
  ),
);

/// Paste a whole ingredient list (or scan it from a photo), review how each
/// name was matched against the database, then add them all at once.
class IngredientImportScreen extends ConsumerStatefulWidget {
  const IngredientImportScreen({super.key, this.startWithScan = false});

  final bool startWithScan;

  @override
  ConsumerState<IngredientImportScreen> createState() =>
      _IngredientImportScreenState();
}

class _IngredientImportScreenState
    extends ConsumerState<IngredientImportScreen> {
  final _text = TextEditingController();

  /// Raw names the user unticked.
  final _excluded = <String>{};
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startWithScan) {
        _scan();
      } else {
        _pasteClipboard(onlyIfList: true);
      }
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _pasteClipboard({bool onlyIfList = false}) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim() ?? '';
    if (text.isEmpty || (onlyIfList && !text.contains(','))) return;
    if (!mounted) return;
    setState(() => _text.text = text);
  }

  Future<void> _scan() async {
    final l10n = AppLocalizations.of(context);
    final fromCamera = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.importTakePhoto),
              onTap: () => Navigator.of(context).pop(true),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.importPickImage),
              onTap: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
    if (fromCamera == null || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _scanning = true);
    try {
      final text = await ref
          .read(ingredientTextScannerProvider)
          .scan(fromCamera: fromCamera);
      if (text == null || !mounted) return;
      if (text.trim().isEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.importScanEmpty)));
        return;
      }
      setState(() {
        _text.text = _text.text.trim().isEmpty
            ? text
            : '${_text.text.trim()}\n$text';
      });
    } catch (e) {
      debugPrint('Ingredient scan failed: $e');
      messenger.showSnackBar(SnackBar(content: Text(l10n.importScanFailed)));
    } finally {
      if (mounted) setState(() => _scanning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final db = ref.watch(ingredientDbProvider).value;
    final matches = db == null
        ? const <IngredientMatch>[]
        : [for (final name in parseIngredientList(_text.text)) db.match(name)];
    // Several spellings can land on the same ingredient; keep the first.
    final seen = <String>{};
    final rows = [
      for (final m in matches)
        if (seen.add(m.ingredient?.inci.toLowerCase() ?? m.raw.toLowerCase()))
          m,
    ];
    final chosen = [
      for (final m in rows)
        if (!_excluded.contains(m.raw)) m.ingredient?.inci ?? m.raw,
    ];
    final exact = rows
        .where((m) => m.ingredient != null && !m.approximate)
        .length;
    final close = rows.where((m) => m.approximate).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.importTitle),
        actions: [
          TextButton(
            onPressed: chosen.isEmpty
                ? null
                : () => Navigator.of(context).pop(chosen),
            child: Text(l10n.importAdd(chosen.length)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.importHint, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _pasteClipboard,
                      icon: const Icon(Icons.content_paste_rounded),
                      label: Text(l10n.importFromClipboard),
                    ),
                    OutlinedButton.icon(
                      onPressed: _scanning ? null : _scan,
                      icon: const Icon(Icons.document_scanner_outlined),
                      label: Text(l10n.importScan),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_scanning) ...[
                  const LinearProgressIndicator(),
                  const SizedBox(height: 6),
                  Text(l10n.importScanning, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 6),
                ],
                TextField(
                  key: const Key('importField'),
                  controller: _text,
                  minLines: 4,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: l10n.importFieldHint),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (rows.isEmpty)
            Text(l10n.importEmpty, style: theme.textTheme.bodyMedium)
          else ...[
            Text(
              l10n.importSummary(exact, close, rows.length - exact - close),
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SoftCard(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  for (final m in rows)
                    _MatchRow(
                      match: m,
                      included: !_excluded.contains(m.raw),
                      onChanged: (on) => setState(
                        () =>
                            on ? _excluded.remove(m.raw) : _excluded.add(m.raw),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: chosen.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(chosen),
              child: Text(l10n.importAdd(chosen.length)),
            ),
          ],
        ],
      ),
    );
  }
}

class _MatchRow extends StatelessWidget {
  const _MatchRow({
    required this.match,
    required this.included,
    required this.onChanged,
  });

  final IngredientMatch match;
  final bool included;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final i = match.ingredient;
    final (icon, color) = switch (match) {
      IngredientMatch(ingredient: null) => (
        Icons.help_outline_rounded,
        theme.colorScheme.outline,
      ),
      IngredientMatch(approximate: true) => (
        Icons.error_outline_rounded,
        BrandColors.champagne,
      ),
      _ => (Icons.check_circle_rounded, theme.colorScheme.primary),
    };
    return CheckboxListTile(
      value: included,
      onChanged: (v) => onChanged(v ?? false),
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(i?.inci ?? match.raw),
      subtitle: Text(
        i == null
            ? l10n.importUnknown
            : match.approximate
            ? l10n.importApproximate(match.raw)
            : '${i.thai} · ${l10n.ingredientFunction(i.function)}',
      ),
      secondary: Icon(icon, color: color),
    );
  }
}

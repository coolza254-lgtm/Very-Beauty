import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../core/db/providers.dart';
import '../../core/db/settings_dao.dart';
import '../../core/lookup/barcode_lookup.dart';
import 'barcode_scanner_screen.dart';

final barcodeLookupProvider = Provider<BarcodeLookupService>(
  (ref) => const OpenBeautyFactsLookup(),
);

/// Opens the scanner; returns the barcode, or null if cancelled.
Future<String?> scanBarcode(BuildContext context) => Navigator.of(
  context,
).push<String>(MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()));

/// Finds details for [barcode]: first among the user's own products
/// (offline, e.g. a re-buy), then online if the user allows it.
Future<BarcodeProductInfo?> lookUpBarcode(
  BuildContext context,
  WidgetRef ref,
  String barcode,
) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);

  final existing = await ref.read(productsDaoProvider).findByBarcode(barcode);
  if (existing != null) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.scanFoundLocal)));
    return infoFromExisting(existing);
  }

  final settings = ref.read(settingsDaoProvider);
  var consent = await settings.getValue(SettingKeys.barcodeLookup);
  if (consent == null) {
    if (!context.mounted) return null;
    final allow = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.travel_explore_rounded),
        title: Text(l10n.lookupConsentTitle),
        content: Text(l10n.lookupConsentBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.lookupConsentDeny),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.lookupConsentAllow),
          ),
        ],
      ),
    );
    if (allow == null) return null;
    consent = allow ? '1' : '0';
    await settings.setValue(SettingKeys.barcodeLookup, consent);
  }
  if (consent != '1') {
    messenger.showSnackBar(SnackBar(content: Text(l10n.scanNotFound)));
    return null;
  }

  messenger.showSnackBar(SnackBar(content: Text(l10n.scanSearching)));
  final info = await ref.read(barcodeLookupProvider).lookup(barcode);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(info == null ? l10n.scanNotFound : l10n.scanFoundOnline),
      ),
    );
  return info;
}

/// The scanner, swappable in tests (there is no camera there).
final barcodeScannerProvider =
    Provider<Future<String?> Function(BuildContext context)>(
      (ref) => scanBarcode,
    );

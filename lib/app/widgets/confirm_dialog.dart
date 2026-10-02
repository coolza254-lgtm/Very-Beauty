import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';

/// Simple yes/no dialog; resolves to true only when confirmed.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  String? body,
  required String confirm,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: body == null ? null : Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirm),
        ),
      ],
    ),
  );
  return result ?? false;
}

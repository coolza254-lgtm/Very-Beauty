import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import 'reminder_sync.dart';

/// Explains why, then asks the OS for notification permission. Call when the
/// user first turns on any reminder (docs/SPEC.md §10).
Future<bool> ensureNotificationPermission(
  BuildContext context,
  WidgetRef ref,
) async {
  final l10n = AppLocalizations.of(context);
  final proceed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.notifications_active_outlined),
      title: Text(l10n.notificationPermissionTitle),
      content: Text(l10n.notificationPermissionBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.actionContinue),
        ),
      ],
    ),
  );
  if (proceed != true) return false;
  bool granted;
  try {
    granted = await ref.read(notificationServiceProvider).requestPermission();
  } catch (_) {
    granted = false;
  }
  if (!granted && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.notificationPermissionDenied)));
  }
  return granted;
}

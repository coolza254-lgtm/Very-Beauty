import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';
import '../l10n/gen/app_localizations.dart';

/// Read-only field that opens a date picker; can be cleared.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: firstDate ?? DateTime(now.year - 10),
          lastDate: lastDate ?? DateTime(now.year + 10),
          helpText: label,
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.event_outlined),
          suffixIcon: value == null
              ? null
              : IconButton(
                  tooltip: l10n.actionClear,
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => onChanged(null),
                ),
        ),
        child: Text(
          value == null ? l10n.pickDate : formatShortDate(value!, locale),
          style: value == null
              ? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)
              : null,
        ),
      ),
    );
  }
}

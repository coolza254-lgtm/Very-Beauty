import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';

/// Friendly empty state for screens whose features arrive in later phases.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.showSoonBadge = false,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;

  /// Shows a small "coming soon" pill for features in later phases.
  final bool showSoonBadge;

  /// Optional call to action under the text.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scheme.primaryContainer,
                        scheme.surfaceContainerLowest,
                      ],
                    ),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Icon(icon, size: 48, color: scheme.primary),
                ),
                Positioned(
                  right: -4,
                  top: 4,
                  child: Icon(
                    Icons.auto_awesome,
                    size: 22,
                    color: scheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[const SizedBox(height: 24), action!],
            if (showSoonBadge) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: scheme.secondary.withValues(alpha: 0.6),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).comingSoonBadge,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.secondary,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).comingSoon)),
    );
}

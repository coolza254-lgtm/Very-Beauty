import 'package:flutter/material.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/widgets/empty_state_view.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navInsights)),
      body: EmptyStateView(
        icon: Icons.insights_outlined,
        title: l10n.insightsEmptyTitle,
        showSoonBadge: true,
        body: l10n.insightsEmptyBody,
      ),
    );
  }
}

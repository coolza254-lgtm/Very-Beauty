import 'package:flutter/material.dart';

import '../../app/l10n/gen/app_localizations.dart';
import 'calendar_tab.dart';
import 'chart_tab.dart';
import 'search_tab.dart';
import 'spending_tab.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navInsights),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: l10n.insightsTabCalendar),
              Tab(text: l10n.insightsTabChart),
              Tab(text: l10n.insightsTabSearch),
              Tab(text: l10n.insightsTabSpending),
            ],
          ),
        ),
        body: const TabBarView(
          children: [CalendarTab(), ChartTab(), SearchTab(), SpendingTab()],
        ),
      ),
    );
  }
}

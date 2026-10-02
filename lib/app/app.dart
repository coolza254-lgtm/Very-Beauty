import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/db/providers.dart';
import '../core/db/settings_dao.dart';
import '../core/notifications/reminder_sync.dart';
import '../core/security/app_lock.dart';
import '../core/security/lock_gate.dart';
import 'app_settings_providers.dart';
import 'l10n/gen/app_localizations.dart';
import 'router.dart';
import 'theme.dart';

class VeryBeautyApp extends ConsumerWidget {
  const VeryBeautyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.light;
    // Keeps scheduled reminders in sync with the database.
    ref.watch(reminderSyncProvider);
    final settings = ref.watch(settingsProvider).value ?? const {};
    ref.watch(secureScreenSyncProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: themeMode,
      // Thai by default; English can be chosen in Settings.
      locale: Locale(settings[SettingKeys.locale] ?? 'th'),
      builder: (context, child) => LockGate(child: child!),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

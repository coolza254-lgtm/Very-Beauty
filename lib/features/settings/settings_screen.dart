import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_settings_providers.dart';
import '../../app/l10n/gen/app_localizations.dart';
import '../../app/theme.dart';
import '../../app/widgets/soft_card.dart';
import '../../app/router.dart';
import '../../core/db/providers.dart';
import '../../core/db/settings_dao.dart';
import '../../core/notifications/permission.dart';
import 'about_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.light;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          SectionTitle(l10n.settingsAppearance),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PastelIconBadge(
                      icon: Icons.palette_outlined,
                      color: BrandColors.blush,
                      size: 40,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.settingsTheme,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(l10n.themeDark),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(l10n.themeSystem),
                      ),
                    ],
                    selected: {themeMode},
                    onSelectionChanged: (s) => setThemeMode(ref, s.single),
                  ),
                ),
              ],
            ),
          ),
          SectionTitle(l10n.settingsNotifications),
          const _NotificationSettings(),
          SectionTitle(l10n.settingsAppInfo),
          SoftCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const AboutScreen()),
            ),
            child: Row(
              children: [
                const PastelIconBadge(
                  icon: Icons.favorite_border_rounded,
                  color: BrandColors.lavender,
                  size: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.settingsAbout,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationSettings extends ConsumerWidget {
  const _NotificationSettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider).value ?? const {};
    final dao = ref.read(settingsDaoProvider);
    final weighDays = settings[SettingKeys.weighReminderDays] ?? '0';
    final expiryOn = settings[SettingKeys.expiryReminders] == '1';

    return SoftCard(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const PastelIconBadge(
              icon: Icons.alarm_rounded,
              color: BrandColors.butter,
              size: 40,
            ),
            title: Text(l10n.settingsRoutineReminders),
            subtitle: Text(l10n.settingsRoutineRemindersHint),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutes.routines),
          ),
          const Divider(),
          const SizedBox(height: 8),
          Text(l10n.settingsWeighReminder, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: '0', label: Text(l10n.weighReminderOff)),
                ButtonSegment(
                  value: '7',
                  label: Text(l10n.weighReminderWeekly),
                ),
                ButtonSegment(
                  value: '14',
                  label: Text(l10n.weighReminderBiweekly),
                ),
              ],
              selected: {weighDays},
              onSelectionChanged: (s) async {
                final value = s.single;
                if (value != '0' && weighDays == '0') {
                  final ok = await ensureNotificationPermission(context, ref);
                  if (!ok) return;
                }
                await dao.setValue(
                  SettingKeys.weighReminderAnchor,
                  '${DateTime.now().millisecondsSinceEpoch}',
                );
                await dao.setValue(SettingKeys.weighReminderDays, value);
              },
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.settingsExpiryReminders),
            subtitle: Text(l10n.settingsExpiryRemindersHint),
            value: expiryOn,
            onChanged: (on) async {
              if (on && !await ensureNotificationPermission(context, ref)) {
                return;
              }
              await dao.setValue(SettingKeys.expiryReminders, on ? '1' : '0');
            },
          ),
        ],
      ),
    );
  }
}

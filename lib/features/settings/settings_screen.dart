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
import '../../core/security/app_lock.dart';
import '../../core/update/update_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'about_screen.dart';
import 'backup_actions.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.light;
    final settings = ref.watch(settingsProvider).value ?? const {};
    final language = settings[SettingKeys.locale] ?? 'th';
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
                _CardHeader(
                  icon: Icons.palette_outlined,
                  color: BrandColors.blush,
                  title: l10n.settingsTheme,
                ),
                const SizedBox(height: 12),
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
                const SizedBox(height: 20),
                _CardHeader(
                  icon: Icons.translate_rounded,
                  color: BrandColors.sky,
                  title: l10n.settingsLanguage,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: 'th',
                        label: Text(l10n.languageThai),
                      ),
                      ButtonSegment(
                        value: 'en',
                        label: Text(l10n.languageEnglish),
                      ),
                    ],
                    selected: {language},
                    onSelectionChanged: (s) => ref
                        .read(settingsDaoProvider)
                        .setValue(SettingKeys.locale, s.single),
                  ),
                ),
              ],
            ),
          ),
          SectionTitle(l10n.settingsNotifications),
          const _NotificationSettings(),
          SectionTitle(l10n.settingsPrivacy),
          const _PrivacySettings(),
          SectionTitle(l10n.settingsData),
          const _DataSettings(),
          SectionTitle(l10n.settingsUpdates),
          const _UpdateSettings(),
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

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.icon,
    required this.color,
    required this.title,
  });

  final IconData icon;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      PastelIconBadge(icon: icon, color: color, size: 40),
      const SizedBox(width: 12),
      Expanded(
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    ],
  );
}

class _PrivacySettings extends ConsumerWidget {
  const _PrivacySettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value ?? const {};
    final dao = ref.read(settingsDaoProvider);
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(20, 4, 12, 4),
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const PastelIconBadge(
              icon: Icons.lock_outline_rounded,
              color: BrandColors.lavender,
              size: 40,
            ),
            title: Text(l10n.settingsAppLock),
            subtitle: Text(l10n.settingsAppLockHint),
            value: settings[SettingKeys.appLock] == '1',
            onChanged: (on) async {
              final auth = ref.read(deviceAuthProvider);
              final messenger = ScaffoldMessenger.of(context);
              if (on) {
                if (!await auth.isAvailable()) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.settingsAppLockUnavailable)),
                  );
                  return;
                }
                if (!await auth.authenticate(l10n.lockEnableReason)) return;
              }
              await dao.setValue(SettingKeys.appLock, on ? '1' : '0');
            },
          ),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const PastelIconBadge(
              icon: Icons.travel_explore_rounded,
              color: BrandColors.sky,
              size: 40,
            ),
            title: Text(l10n.settingsOnlineLookup),
            subtitle: Text(l10n.settingsOnlineLookupHint),
            value: settings[SettingKeys.barcodeLookup] == '1',
            onChanged: (on) =>
                dao.setValue(SettingKeys.barcodeLookup, on ? '1' : '0'),
          ),
          if (Theme.of(context).platform == TargetPlatform.android) ...[
            const Divider(),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const PastelIconBadge(
                icon: Icons.screenshot_monitor_outlined,
                color: BrandColors.mint,
                size: 40,
              ),
              title: Text(l10n.settingsSecureScreen),
              subtitle: Text(l10n.settingsSecureScreenHint),
              value: settings[SettingKeys.secureScreen] == '1',
              onChanged: (on) =>
                  dao.setValue(SettingKeys.secureScreen, on ? '1' : '0'),
            ),
          ],
        ],
      ),
    );
  }
}

class _DataSettings extends ConsumerWidget {
  const _DataSettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final settings = ref.watch(settingsProvider).value ?? const {};
    final lastMs = int.tryParse(settings[SettingKeys.lastBackupAt] ?? '');
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const PastelIconBadge(
              icon: Icons.cloud_upload_outlined,
              color: BrandColors.sky,
              size: 40,
            ),
            title: Text(l10n.backupExport),
            subtitle: Text(l10n.backupExportHint),
            onTap: () => exportBackup(context, ref),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const PastelIconBadge(
              icon: Icons.settings_backup_restore_rounded,
              color: BrandColors.butter,
              size: 40,
            ),
            title: Text(l10n.backupImport),
            subtitle: Text(l10n.backupImportHint),
            onTap: () => importBackup(context, ref),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              lastMs == null
                  ? l10n.backupNever
                  : l10n.backupLast(
                      formatShortDate(fromEpochMs(lastMs), locale),
                    ),
              style: theme.textTheme.bodySmall,
            ),
          ),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.backupReminders),
            value: settings[SettingKeys.backupReminders] != '0',
            onChanged: (on) => ref
                .read(settingsDaoProvider)
                .setValue(SettingKeys.backupReminders, on ? '1' : '0'),
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

class _UpdateSettings extends ConsumerWidget {
  const _UpdateSettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value ?? const {};
    final current = ref.watch(currentVersionProvider).value;
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const PastelIconBadge(
              icon: Icons.system_update_rounded,
              color: BrandColors.mint,
              size: 40,
            ),
            title: Text(l10n.updateCheck),
            subtitle: current == null
                ? null
                : Text(
                    l10n.updateCurrent('${current.version} (${current.build})'),
                  ),
            onTap: () => manualCheckForUpdate(context, ref),
          ),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.updateAuto),
            subtitle: Text(l10n.updateAutoHint),
            value: settings[SettingKeys.updateAutoCheck] != '0',
            onChanged: (on) => ref
                .read(settingsDaoProvider)
                .setValue(SettingKeys.updateAutoCheck, on ? '1' : '0'),
          ),
        ],
      ),
    );
  }
}

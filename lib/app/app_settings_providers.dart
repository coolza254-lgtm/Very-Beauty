import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/db/providers.dart';
import '../core/db/settings_dao.dart';

final themeModeProvider = StreamProvider<ThemeMode>((ref) {
  return ref
      .watch(settingsDaoProvider)
      .watchValue(SettingKeys.themeMode)
      .map(_parseThemeMode);
});

ThemeMode _parseThemeMode(String? value) => ThemeMode.values.firstWhere(
  (m) => m.name == value,
  orElse: () => ThemeMode.light,
);

Future<void> setThemeMode(WidgetRef ref, ThemeMode mode) =>
    ref.read(settingsDaoProvider).setValue(SettingKeys.themeMode, mode.name);

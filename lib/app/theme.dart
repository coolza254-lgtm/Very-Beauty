import 'package:flutter/material.dart';

/// Brand colours taken from the Very Beauty logo.
abstract final class BrandColors {
  static const blush = Color(0xFFF9E3E3); // logo background
  static const rose = Color(0xFFE8838F); // hearts and accents
  static const cocoa = Color(0xFF4E3630); // wordmark and outlines
  static const sage = Color(0xFFA9CFA4);
  static const sky = Color(0xFFA9C4DF);
  static const honey = Color(0xFFF5CF6B);
}

ThemeData buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  var scheme = ColorScheme.fromSeed(
    seedColor: BrandColors.rose,
    brightness: brightness,
  );
  if (isLight) {
    scheme = scheme.copyWith(
      surface: const Color(0xFFFFF8F7),
      onSurface: BrandColors.cocoa,
      primaryContainer: BrandColors.blush,
      onPrimaryContainer: BrandColors.cocoa,
    );
  }

  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

  return ThemeData(
    colorScheme: scheme,
    brightness: brightness,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      centerTitle: false,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      shape: shape,
      elevation: 0,
      color: isLight ? Colors.white : scheme.surfaceContainerHigh,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: scheme.primaryContainer,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(64, 48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      filled: true,
    ),
  );
}

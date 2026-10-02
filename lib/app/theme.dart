import 'package:flutter/material.dart';

/// Very Beauty palette: soft pink and white, pastel accents, a touch of
/// champagne gold. Derived from the logo.
abstract final class BrandColors {
  static const white = Color(0xFFFFFFFF);
  static const porcelain = Color(0xFFFFF9F8); // app background
  static const blush = Color(0xFFFDE7E4); // logo background, containers
  static const petal = Color(0xFFF6D3D6); // borders, dividers
  static const rose = Color(0xFFC77D8E); // primary actions
  static const roseDeep = Color(0xFFA85F71);
  static const cocoa = Color(0xFF4A3734); // main text
  static const taupe = Color(0xFF8E7773); // secondary text
  static const champagne = Color(0xFFC8A97E); // subtle luxe accent

  // Pastel accents for icons and chips.
  static const butter = Color(0xFFFBEFCB);
  static const lavender = Color(0xFFEAE2F5);
  static const mint = Color(0xFFDCEFE0);
  static const sky = Color(0xFFDDE9F6);

  // Dark mode.
  static const night = Color(0xFF211A1B);
  static const nightSurface = Color(0xFF2C2324);
  static const nightContainer = Color(0xFF3A2C2E);
  static const nightRose = Color(0xFFF0B6C2);
}

abstract final class AppFonts {
  /// Rounded, friendly display face that echoes the logo wordmark.
  static const display = 'Mali';

  /// Clean body face with good Thai and Latin coverage.
  static const body = 'Prompt';
}

/// Soft, low-contrast shadow used for cards.
List<BoxShadow> softShadow(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
    ? [
        BoxShadow(
          color: BrandColors.rose.withValues(alpha: 0.07),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ]
    : const [];

ThemeData buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;

  final scheme = isLight
      ? const ColorScheme(
          brightness: Brightness.light,
          primary: BrandColors.rose,
          onPrimary: BrandColors.white,
          primaryContainer: BrandColors.blush,
          onPrimaryContainer: BrandColors.cocoa,
          secondary: BrandColors.champagne,
          onSecondary: BrandColors.white,
          secondaryContainer: BrandColors.butter,
          onSecondaryContainer: BrandColors.cocoa,
          tertiary: BrandColors.roseDeep,
          onTertiary: BrandColors.white,
          error: Color(0xFFBA4A5A),
          onError: BrandColors.white,
          surface: BrandColors.porcelain,
          onSurface: BrandColors.cocoa,
          onSurfaceVariant: BrandColors.taupe,
          surfaceContainerLowest: BrandColors.white,
          surfaceContainerLow: BrandColors.white,
          surfaceContainer: Color(0xFFFFF3F2),
          surfaceContainerHigh: BrandColors.blush,
          surfaceContainerHighest: BrandColors.petal,
          outline: Color(0xFFE2BFC3),
          outlineVariant: BrandColors.petal,
          shadow: BrandColors.rose,
        )
      : const ColorScheme(
          brightness: Brightness.dark,
          primary: BrandColors.nightRose,
          onPrimary: BrandColors.night,
          primaryContainer: BrandColors.nightContainer,
          onPrimaryContainer: Color(0xFFFBE4E7),
          secondary: BrandColors.champagne,
          onSecondary: BrandColors.night,
          secondaryContainer: Color(0xFF4A3F2E),
          onSecondaryContainer: Color(0xFFF6E9D3),
          tertiary: Color(0xFFE8A3B3),
          onTertiary: BrandColors.night,
          error: Color(0xFFF2A3AE),
          onError: BrandColors.night,
          surface: BrandColors.night,
          onSurface: Color(0xFFF6E8E6),
          onSurfaceVariant: Color(0xFFCDB8B5),
          surfaceContainerLowest: BrandColors.night,
          surfaceContainerLow: BrandColors.nightSurface,
          surfaceContainer: BrandColors.nightSurface,
          surfaceContainerHigh: BrandColors.nightContainer,
          surfaceContainerHighest: Color(0xFF47373A),
          outline: Color(0xFF6E5A5D),
          outlineVariant: Color(0xFF4B3C3E),
          shadow: Colors.black,
        );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: AppFonts.body,
  );
  final t = base.textTheme;
  TextStyle? display(TextStyle? s, double size) => s?.copyWith(
    fontFamily: AppFonts.display,
    fontWeight: FontWeight.w600,
    fontSize: size,
    height: 1.3,
    color: scheme.onSurface,
  );
  final textTheme = t.copyWith(
    displaySmall: display(t.displaySmall, 32),
    headlineMedium: display(t.headlineMedium, 28),
    headlineSmall: display(t.headlineSmall, 24),
    titleLarge: display(t.titleLarge, 21),
    titleMedium: t.titleMedium?.copyWith(fontWeight: FontWeight.w500),
    bodyLarge: t.bodyLarge?.copyWith(fontWeight: FontWeight.w400, height: 1.5),
    bodyMedium: t.bodyMedium?.copyWith(
      fontWeight: FontWeight.w300,
      height: 1.5,
      color: scheme.onSurfaceVariant,
    ),
    labelLarge: t.labelLarge?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    ),
  );

  final radius = BorderRadius.circular(24);

  return base.copyWith(
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.surface,
    splashFactory: InkSparkle.splashFactory,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.headlineSmall,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      elevation: 0,
      backgroundColor: isLight ? BrandColors.white : BrandColors.nightSurface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.primaryContainer,
      indicatorShape: const StadiumBorder(),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          size: 24,
          color: states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.onSurfaceVariant,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontFamily: AppFonts.body,
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w500
              : FontWeight.w400,
          color: states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.onSurfaceVariant,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(64, 52),
        textStyle: textTheme.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(64, 52),
        side: BorderSide(color: scheme.outline),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: scheme.primaryContainer,
        selectedForegroundColor: scheme.onPrimaryContainer,
        side: BorderSide(color: scheme.outlineVariant),
        textStyle: textTheme.labelLarge,
      ),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      side: BorderSide(color: scheme.outlineVariant),
      backgroundColor: scheme.surfaceContainerLowest,
      selectedColor: scheme.primaryContainer,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: scheme.primary,
      shape: RoundedRectangleBorder(borderRadius: radius),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: 0.7),
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.onSurface,
      contentTextStyle: TextStyle(
        fontFamily: AppFonts.body,
        color: scheme.surface,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Very Beauty';

  @override
  String get navToday => 'Today';

  @override
  String get navProducts => 'Products';

  @override
  String get navPhotos => 'Photos';

  @override
  String get navInsights => 'Insights';

  @override
  String get navSettings => 'Settings';

  @override
  String get comingSoon => 'Coming in a later phase';

  @override
  String get todayGreeting => 'Have you taken care of your skin today?';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsAbout => 'About';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDisclaimerTitle => 'Please note';

  @override
  String get aboutDisclaimer =>
      'Very Beauty is a personal skincare journal only. It is not a medical diagnostic or treatment tool. If you have skin concerns, please consult a dermatologist.';

  @override
  String get aboutPrivacyTitle => 'Privacy';

  @override
  String get aboutPrivacy =>
      'All your data and photos stay on this device. The app has no accounts, no servers and no tracking.';

  @override
  String get todayHello => 'Hello';

  @override
  String get todayHeroSubtitle => 'Little steps, lovely skin.';

  @override
  String get todayRoutinesTitle => 'Today\'s routines';

  @override
  String get routineNoSteps => 'No steps yet · adding products is coming soon';

  @override
  String get todayQuickTitle => 'Quick log';

  @override
  String get quickPhoto => 'Skin photo';

  @override
  String get quickSkinLog => 'Skin log';

  @override
  String get productsEmptyTitle => 'No products yet';

  @override
  String get productsEmptyBody =>
      'Keep every bottle with its price, size and value.';

  @override
  String get photosEmptyTitle => 'No photos yet';

  @override
  String get photosEmptyBody =>
      'Take photos at the same angle and compare over time.';

  @override
  String get insightsEmptyTitle => 'No insights yet';

  @override
  String get insightsEmptyBody =>
      'Calendar, skin charts and value summaries will appear here.';

  @override
  String get comingSoonBadge => 'Soon';

  @override
  String get settingsAppInfo => 'App info';
}

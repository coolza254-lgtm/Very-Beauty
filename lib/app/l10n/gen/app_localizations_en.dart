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

  @override
  String get categoryCleanser => 'Cleanser';

  @override
  String get categoryToner => 'Toner';

  @override
  String get categorySerum => 'Serum';

  @override
  String get categoryMoisturizer => 'Moisturizer';

  @override
  String get categorySunscreen => 'Sunscreen';

  @override
  String get categoryTreatment => 'Treatment';

  @override
  String get categoryMask => 'Mask';

  @override
  String get categoryOther => 'Other';

  @override
  String get statusInUse => 'In use';

  @override
  String get statusFinished => 'Finished';

  @override
  String get statusPaused => 'Paused';

  @override
  String get statusWishlist => 'Wishlist';

  @override
  String get unitG => 'g';

  @override
  String get unitMl => 'ml';

  @override
  String get filterAll => 'All';

  @override
  String get productsSearchHint => 'Search name or brand';

  @override
  String get productsAdd => 'Add product';

  @override
  String get productsNoMatch => 'No products match these filters';

  @override
  String get productFormNew => 'New product';

  @override
  String get productFormEdit => 'Edit product';

  @override
  String get fieldName => 'Product name';

  @override
  String get fieldNameRequired => 'Please enter a name';

  @override
  String get fieldCategory => 'Category';

  @override
  String get fieldPrice => 'Price (THB)';

  @override
  String get fieldNetContent => 'Net content';

  @override
  String get fieldMoreDetails => 'More details';

  @override
  String get fieldMoreDetailsHint => 'Brand, dates, weights, ingredients…';

  @override
  String get fieldBrand => 'Brand';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldPurchasePlace => 'Where purchased';

  @override
  String get fieldPurchaseDate => 'Purchase date';

  @override
  String get fieldOpenedDate => 'Opened on';

  @override
  String get fieldPao => 'Period after opening (months)';

  @override
  String get fieldExpiry => 'Printed expiry date';

  @override
  String get fieldStartWeight => 'Starting weight (g, incl. container)';

  @override
  String get fieldEmptyWeight => 'Empty container weight (g)';

  @override
  String get fieldEmptyWeightHelp =>
      'Optional — makes the remaining amount exact';

  @override
  String get fieldNote => 'Note';

  @override
  String get fieldIngredients => 'Key ingredients';

  @override
  String get fieldIngredientsHelp =>
      'Comma separated, e.g. niacinamide, vitamin C';

  @override
  String get fieldInvalidNumber => 'Invalid number';

  @override
  String get pickDate => 'Pick a date';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionClear => 'Clear';

  @override
  String remainingExact(String percent) {
    return '$percent% left';
  }

  @override
  String remainingApprox(String percent) {
    return 'About $percent% left';
  }

  @override
  String get remainingUnknown => 'Weigh it to see how much is left';

  @override
  String get statUsed => 'Used';

  @override
  String get statRemaining => 'Remaining';

  @override
  String get statPerDay => 'Per day';

  @override
  String statPricePerUnit(String unit) {
    return 'Price per $unit';
  }

  @override
  String get statCostUsed => 'Value used';

  @override
  String get statCostPerUse => 'Cost per use (approx.)';

  @override
  String get statUsageCount => 'Times used';

  @override
  String get statEmptyOn => 'Expected to run out';

  @override
  String get notEnoughData => 'Not enough data yet';

  @override
  String get weightAnomaly =>
      'The latest weight is heavier than the start — probably a weighing mistake. Weigh again or delete the wrong entry.';

  @override
  String get weightHistory => 'Weighing history';

  @override
  String get weightChartTitle => 'Weight over time';

  @override
  String get weighNow => 'Weigh';

  @override
  String get weighTitle => 'Weigh product';

  @override
  String get weighHint => 'Weight incl. container (g)';

  @override
  String weighDiff(String diff) {
    return '$diff g since last time';
  }

  @override
  String get weighFirst => 'First weighing — becomes the starting weight';

  @override
  String get weighHeavier => 'Heavier than last time — please double-check';

  @override
  String get weighEmpty => 'No weighings yet';

  @override
  String get skinWhileUsing => 'Skin while using this';

  @override
  String get skinWhileUsingEmpty => 'No skin logs on days you used this yet';

  @override
  String basedOnDays(int count) {
    return 'Based on $count logged days';
  }

  @override
  String get scoreOil => 'Oiliness';

  @override
  String get scoreMoisture => 'Hydration';

  @override
  String get scoreAcne => 'Breakouts';

  @override
  String get scoreRedness => 'Redness';

  @override
  String get scoreDullness => 'Dullness';

  @override
  String get finishAction => 'Finished it';

  @override
  String get finishTitle => 'Close this product';

  @override
  String get finishRating => 'Your rating';

  @override
  String get finishRepurchase => 'Would you buy it again?';

  @override
  String get repurchaseYes => 'Yes';

  @override
  String get repurchaseNo => 'No';

  @override
  String get actionReopen => 'Use again';

  @override
  String get actionStartUsing => 'Start using';

  @override
  String get actionPause => 'Pause';

  @override
  String get deleteProductTitle => 'Delete this product?';

  @override
  String get deleteProductBody =>
      'Its weighing and usage history will be deleted too.';

  @override
  String get deleteWeighingTitle => 'Delete this weighing?';

  @override
  String get wishlistCompare => 'Value comparison';

  @override
  String get wishlistCompareEmpty =>
      'No products in this category with a unit price to compare yet';

  @override
  String get wishlistCompareNeedsPrice => 'Add price and size to compare value';

  @override
  String cheaperBy(String percent) {
    return '$percent% cheaper';
  }

  @override
  String pricierBy(String percent) {
    return '$percent% pricier';
  }

  @override
  String get samePrice => 'About the same';

  @override
  String get infoSection => 'Details';

  @override
  String get expiresOn => 'Expires';

  @override
  String get ratingLabel => 'Rating';

  @override
  String get repurchaseLabel => 'Repurchase';

  @override
  String get finishedOn => 'Finished on';

  @override
  String perUnitShort(String price, String unit) {
    return '฿$price/$unit';
  }

  @override
  String get productNotFound => 'Product not found';

  @override
  String get valueSection => 'Value';
}

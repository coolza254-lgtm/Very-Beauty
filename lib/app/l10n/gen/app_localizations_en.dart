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

  @override
  String reminderRoutineTitle(String name) {
    return 'Time for your $name routine ✨';
  }

  @override
  String get reminderRoutineBody => 'Tap to check off what you used today';

  @override
  String get reminderWeighTitle => 'Time to weigh your skincare';

  @override
  String get reminderWeighBody =>
      'Weigh what you\'re using to see what\'s left and when it runs out';

  @override
  String get reminderExpiryTitle => 'A product expires soon';

  @override
  String reminderExpiryBody(String name) {
    return '$name expires in 7 days';
  }

  @override
  String get reminderBackupTitle => 'Time for a backup?';

  @override
  String get reminderBackupBody =>
      'Your data lives only on this phone — back it up in case you switch phones';

  @override
  String get routinesTitle => 'My routines';

  @override
  String get routinesManage => 'Manage routines';

  @override
  String get routineNew => 'New routine';

  @override
  String get routineName => 'Routine name';

  @override
  String get routineSlot => 'Time of day';

  @override
  String get slotMorning => 'Morning';

  @override
  String get slotEvening => 'Evening';

  @override
  String get slotOther => 'Other';

  @override
  String get routineSteps => 'Steps';

  @override
  String get routineStepsHint => 'Long-press and drag to reorder';

  @override
  String get routineAddSteps => 'Add steps';

  @override
  String get routineAddStepsTitle => 'Choose products for this routine';

  @override
  String get routineAddStepsEmpty => 'No products in use yet — add some first';

  @override
  String routineAddSelected(int count) {
    return 'Add $count';
  }

  @override
  String get routineReminder => 'Remind me';

  @override
  String routineReminderAt(String time) {
    return 'Every day at $time';
  }

  @override
  String get routineDeleteTitle => 'Delete this routine?';

  @override
  String get routineDeleteBody => 'Your usage history stays.';

  @override
  String routineStepCount(int count) {
    return '$count steps';
  }

  @override
  String get routineNotInUse => 'Not in use';

  @override
  String get routineEmptySteps => 'No steps yet — tap to add products';

  @override
  String get routineUseAsUsual => 'Done as usual';

  @override
  String get routineAllDone => 'All done';

  @override
  String routineProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String todayProgress(int done, int total) {
    return '$done of $total steps done today';
  }

  @override
  String get todayAllDone => 'Every step done — lovely! 💗';

  @override
  String get todayAlertsTitle => 'Heads up';

  @override
  String alertLow(String name, String percent) {
    return '$name is about $percent% left';
  }

  @override
  String alertEmptySoon(String name, String date) {
    return '$name should run out $date';
  }

  @override
  String alertExpired(String name, String date) {
    return '$name has expired ($date)';
  }

  @override
  String alertExpiring(String name, String date) {
    return '$name expires $date';
  }

  @override
  String alertWeighDue(String name, int days) {
    return 'Time to weigh $name (last weighed $days days ago)';
  }

  @override
  String get todaySkinTitle => 'Skin today';

  @override
  String get todaySkinEmpty => 'Not logged yet — tap to log your skin';

  @override
  String get todaySkinEdit => 'Edit log';

  @override
  String get dailyLogTitle => 'Skin log';

  @override
  String get dailyLogScores => 'Rate your skin';

  @override
  String get dailyLogScoresHint =>
      '1 = very low · 5 = very high. Tap again to clear';

  @override
  String get dailyLogSymptoms => 'Symptoms';

  @override
  String get dailyLogFactors => 'Factors';

  @override
  String get dailyLogLifestyle => 'Lifestyle';

  @override
  String get dailyLogSleep => 'Sleep (hours)';

  @override
  String get dailyLogStress => 'Stress';

  @override
  String get dailyLogSun => 'Sun exposure';

  @override
  String get sunNone => 'None';

  @override
  String get sunLow => 'A little';

  @override
  String get sunHigh => 'A lot';

  @override
  String get dailyLogPeriod => 'Cycle';

  @override
  String get periodMenstruation => 'Period';

  @override
  String get periodFollicular => 'After period';

  @override
  String get periodOvulation => 'Ovulation';

  @override
  String get periodLuteal => 'Before period';

  @override
  String get dailyLogNote => 'Note';

  @override
  String get dailyLogNoteHint => 'How is your skin today? Tried anything new?';

  @override
  String get dailyLogSaved => 'Saved';

  @override
  String get tagAdd => 'Add';

  @override
  String get tagAddTitle => 'New tag';

  @override
  String get tagName => 'Tag name';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsRoutineReminders => 'Routine reminders';

  @override
  String get settingsRoutineRemindersHint => 'Set a time in each routine';

  @override
  String get settingsWeighReminder => 'Weighing reminder';

  @override
  String get weighReminderOff => 'Off';

  @override
  String get weighReminderWeekly => 'Weekly';

  @override
  String get weighReminderBiweekly => 'Every 2 weeks';

  @override
  String get settingsExpiryReminders => 'Remind 7 days before expiry';

  @override
  String get settingsExpiryRemindersHint =>
      'Uses the printed date or period after opening (PAO)';

  @override
  String get notificationPermissionTitle => 'Allow notifications';

  @override
  String get notificationPermissionBody =>
      'Very Beauty only sends reminders from this phone — for routines, weighing and expiry. Nothing leaves your device.';

  @override
  String get notificationPermissionDenied =>
      'Notifications are blocked — you can allow them in your phone\'s settings';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionDone => 'Done';

  @override
  String get pickTime => 'Pick a time';
}

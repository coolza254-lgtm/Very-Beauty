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
      'All your data and photos stay on this device. The app has no accounts, no servers and no tracking.\n\nThe only internet connection is checking GitHub for a new version (can be turned off in Settings), which sends none of your data.';

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
  String get fieldStartWeight => 'Full weight before use (g, with container)';

  @override
  String get fieldEmptyWeight => 'Empty container weight (g)';

  @override
  String get fieldEmptyWeightHelp =>
      'Leave blank to calculate it: full weight − net content';

  @override
  String get fieldNote => 'Note';

  @override
  String get fieldIngredients => 'Ingredients';

  @override
  String get fieldIngredientsHelp =>
      'Type a Thai or English name and pick from the list, or paste the list from the label (comma separated)';

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
  String get weighFirst =>
      'First weighing — weigh it unused (with container); this becomes the start weight';

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

  @override
  String get cameraTitle => 'Skin photo';

  @override
  String get cameraTipTitle => 'Tips for comparable photos';

  @override
  String get cameraTip =>
      'Face a window, use the same natural light each time, no flash, and keep your face inside the oval';

  @override
  String get cameraPermissionTitle => 'Camera access';

  @override
  String get cameraPermissionBody =>
      'The camera is used to take skin photos for comparison. Photos stay inside this app — not in your gallery and never uploaded.';

  @override
  String get cameraDenied =>
      'Camera access is off — you can allow it in your phone\'s settings';

  @override
  String get cameraUnavailable => 'No camera found on this device';

  @override
  String get cameraOnionSkin => 'Last photo';

  @override
  String get cameraSwitch => 'Switch camera';

  @override
  String get cameraCapture => 'Take photo';

  @override
  String get cameraSaving => 'Saving…';

  @override
  String get cameraSaved => 'Photo saved';

  @override
  String get photoSession => 'Session';

  @override
  String get photosCompare => 'Compare';

  @override
  String get photosSelectTwo => 'Pick 2 photos to compare';

  @override
  String photosSelected(int count) {
    return '$count/2 selected';
  }

  @override
  String get photosTake => 'Take photo';

  @override
  String get photoDeleteTitle => 'Delete this photo?';

  @override
  String get photoDeleteBody => 'The photo will be permanently removed.';

  @override
  String get photoNote => 'Photo note';

  @override
  String get compareTitle => 'Compare';

  @override
  String get compareHint => 'Drag the divider to compare';

  @override
  String compareDaysApart(int days) {
    return '$days days apart';
  }

  @override
  String get insightsTabCalendar => 'Calendar';

  @override
  String get insightsTabChart => 'Skin chart';

  @override
  String get insightsTabSearch => 'Search';

  @override
  String get insightsTabSpending => 'Spending';

  @override
  String get calendarLegendCalm => 'Calm';

  @override
  String get calendarLegendTroubled => 'Troubled';

  @override
  String get calendarLegendPhoto => 'Photo';

  @override
  String get calendarLegendUsage => 'Used products';

  @override
  String get daySummaryNoLog => 'No skin log for this day';

  @override
  String get daySummaryProducts => 'Products used';

  @override
  String get daySummaryNoProducts => 'No products logged';

  @override
  String daySummaryTimes(int count) {
    return '$count×';
  }

  @override
  String get daySummaryEdit => 'Edit this day';

  @override
  String get daySummaryPhotos => 'Photos';

  @override
  String get chartRange30 => '30 days';

  @override
  String get chartRange90 => '90 days';

  @override
  String get chartRange180 => '6 months';

  @override
  String get chartEmpty =>
      'No skin scores in this range yet — try logging daily';

  @override
  String get chartMarkers => 'Started / finished';

  @override
  String chartMarkerStart(String name) {
    return 'Started $name';
  }

  @override
  String chartMarkerEnd(String name) {
    return 'Finished $name';
  }

  @override
  String get searchPrompt =>
      'Pick a symptom or factor to see what you used that day and the 3 days before';

  @override
  String get searchNoDays => 'No days with this tag yet';

  @override
  String searchDaysFound(int count) {
    return '$count days';
  }

  @override
  String get searchRecentProducts => 'Used in the 3 days before';

  @override
  String get spendingThisMonth => 'This month';

  @override
  String get spendingSixMonths => 'Last 6 months';

  @override
  String get spendingPerMonth => 'Spending per month';

  @override
  String get spendingNote =>
      'Counted by purchase (or opening) date; wishlist excluded';

  @override
  String get spendingValue => 'Value per product';

  @override
  String get spendingValueHint => 'Sorted by cheapest per use';

  @override
  String get spendingNoProducts => 'Add product prices to see spending';

  @override
  String perUseShort(String price) {
    return '$price/use';
  }

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageThai => 'ไทย';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsAppLock => 'App lock';

  @override
  String get settingsAppLockHint =>
      'Use fingerprint, face or your phone\'s PIN to open the app';

  @override
  String get settingsAppLockUnavailable =>
      'This phone has no screen lock or biometrics set up';

  @override
  String get settingsSecureScreen => 'Block screenshots';

  @override
  String get settingsSecureScreenHint =>
      'Prevents screenshots and screen recording (Android)';

  @override
  String get settingsData => 'Data & backup';

  @override
  String get backupExport => 'Back up (export)';

  @override
  String get backupExportHint =>
      'Creates one .zip with all data and photos — save it anywhere you like';

  @override
  String get backupImport => 'Restore (import)';

  @override
  String get backupImportHint => 'Pick a backup .zip to bring your data back';

  @override
  String backupLast(String date) {
    return 'Last backup $date';
  }

  @override
  String get backupNever => 'Never backed up';

  @override
  String get backupReminders => 'Monthly backup reminder';

  @override
  String get backupWorking => 'Preparing backup…';

  @override
  String get backupRestoring => 'Restoring…';

  @override
  String get backupShareSubject => 'Very Beauty backup';

  @override
  String get backupDone => 'Backup saved';

  @override
  String backupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreConfirmTitle => 'Restore from this backup?';

  @override
  String restoreConfirmBody(String date, int count) {
    return 'Backup from $date with $count photos.\n\nAll data and photos currently on this phone will be replaced. This can\'t be undone.';
  }

  @override
  String get restoreAction => 'Replace with backup';

  @override
  String get restoreDone => 'Restore complete';

  @override
  String get restoreNotBackup => 'This isn\'t a Very Beauty backup file';

  @override
  String restoreNewer(String version) {
    return 'This backup is from a newer app version ($version) — update the app first';
  }

  @override
  String get restoreCorrupt =>
      'The backup file is damaged — your current data is untouched';

  @override
  String alertBackupDue(int days) {
    return 'No backup for $days days';
  }

  @override
  String get lockTitle => 'Very Beauty is locked';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get lockReason => 'Confirm it\'s you to open Very Beauty';

  @override
  String get lockEnableReason => 'Confirm it\'s you to turn on app lock';

  @override
  String get settingsUpdates => 'Updates';

  @override
  String get updateCheck => 'Check for updates';

  @override
  String updateCurrent(String version) {
    return 'Current version $version';
  }

  @override
  String get updateAuto => 'Check automatically once a day';

  @override
  String get updateAutoHint =>
      'Only asks GitHub for the latest version — none of your data is sent';

  @override
  String get updateChecking => 'Checking…';

  @override
  String get updateNone => 'You\'re up to date (or offline)';

  @override
  String get updateAvailableTitle => 'A new version is ready ✨';

  @override
  String get updateRequiredTitle => 'Please update to continue';

  @override
  String get updateRequiredBody =>
      'This version is too old for the new data format';

  @override
  String get updateKeepsData =>
      'Download and tap the installer to update. Your data stays (if signed with the same key) — backing up first is a good idea.';

  @override
  String get updateDownload => 'Download';

  @override
  String get updateLater => 'Later';

  @override
  String get ingFnSurfactant => 'Cleansing agent';

  @override
  String get ingFnUvChemical => 'UV filter (chemical)';

  @override
  String get ingFnUvMineral => 'UV filter (mineral)';

  @override
  String get ingFnHumectant => 'Humectant';

  @override
  String get ingFnEmollient => 'Emollient';

  @override
  String get ingFnOcclusive => 'Occlusive';

  @override
  String get ingFnBarrier => 'Barrier repair';

  @override
  String get ingFnBrightening => 'Brightening';

  @override
  String get ingFnAntioxidant => 'Antioxidant';

  @override
  String get ingFnExfoliant => 'Exfoliant';

  @override
  String get ingFnAntiAcne => 'Anti-acne';

  @override
  String get ingFnRetinoid => 'Retinoid';

  @override
  String get ingFnAntiAging => 'Anti-aging';

  @override
  String get ingFnSoothing => 'Soothing';

  @override
  String get ingFnAbsorbent => 'Oil absorbing';

  @override
  String get ingFnFilmFormer => 'Film former';

  @override
  String get ingFnEmulsifier => 'Emulsifier';

  @override
  String get ingFnThickener => 'Texture / thickener';

  @override
  String get ingFnPreservative => 'Preservative';

  @override
  String get ingFnChelating => 'Chelating agent';

  @override
  String get ingFnPhAdjuster => 'pH adjuster';

  @override
  String get ingFnSolvent => 'Solvent';

  @override
  String get ingFnFragrance => 'Fragrance';

  @override
  String get ingFnOther => 'Other';

  @override
  String get ingredientsSearchHint => 'e.g. niacinamide, zinc oxide';

  @override
  String ingredientsCommonIn(String category) {
    return 'Common in $category · tap to add';
  }

  @override
  String ingredientsAddCustom(String name) {
    return 'Add “$name”';
  }

  @override
  String get ingredientsCustomSubtitle => 'Not in the database yet';

  @override
  String get ingredientsUsedBefore => 'Used in your other products';

  @override
  String get ingredientsUnknown =>
      'This ingredient is not in the app database yet';

  @override
  String get ingredientsTitle => 'Ingredient database';

  @override
  String ingredientsCount(int count) {
    return '$count ingredients';
  }

  @override
  String get ingredientsAlsoKnownAs => 'Also known as';

  @override
  String get ingredientsTypicalIn => 'Common in';

  @override
  String get ingredientsCaution => 'Good to know';

  @override
  String get ingredientsNoMatch => 'No matching ingredients';

  @override
  String get ingredientsDisclaimer =>
      'General information only, not medical advice';

  @override
  String get ingredientsFilterAll => 'All functions';

  @override
  String fieldEmptyWeightAuto(String start, String net, String packaging) {
    return 'Leave blank — calculated: $start − $net = $packaging g';
  }

  @override
  String packagingCalculated(String grams) {
    return '$grams (calculated)';
  }

  @override
  String statPackaging(String grams) {
    return 'Container $grams g';
  }

  @override
  String weighPackagingPreview(String packaging, String total, String net) {
    return 'Container ≈ $packaging g ($total − net content $net)';
  }

  @override
  String weighRemainingPreview(String grams, String percent) {
    return '$grams g left ($percent%)';
  }

  @override
  String get weighMlNote => 'For ml products, 1 ml ≈ 1 g is assumed';

  @override
  String get ingFnColorant => 'Colorant';

  @override
  String get ingredientWhat => 'What it is';

  @override
  String get ingredientGood => 'What it does';

  @override
  String get ingredientTips => 'How to use';

  @override
  String get ingredientAbout => 'About';

  @override
  String get ingredientStructure => 'Chemical structure';

  @override
  String ingredientFormula(String formula) {
    return 'Formula $formula';
  }

  @override
  String ingredientMw(String mw) {
    return 'Molecular weight $mw g/mol';
  }

  @override
  String get ingredientZoomHint =>
      'Pinch to zoom · skeletal formula (corners are carbon)';

  @override
  String get ingredientKindPolymer =>
      'A polymer (long repeating chains of many sizes), so there is no single structure';

  @override
  String get ingredientKindExtract =>
      'A natural extract made of many compounds';

  @override
  String get ingredientKindOil =>
      'A natural oil or butter: a mix of triglycerides of several fatty acids';

  @override
  String get ingredientKindMixture =>
      'A mixture of molecules of different sizes (e.g. coconut fatty acids)';

  @override
  String get ingredientKindMineral =>
      'A mineral or inorganic solid, not a single molecule';

  @override
  String get ingredientKindProtein => 'A large protein or enzyme';

  @override
  String get ingredientKindFerment => 'A ferment containing many compounds';

  @override
  String get ingredientKindPeptide =>
      'A peptide (chain of amino acids), too large to draw clearly';

  @override
  String get ingredientKindUnknown => 'No structure data yet';

  @override
  String get ingredientMyProducts => 'My products with this ingredient';

  @override
  String get ingredientFunctions => 'Functions';

  @override
  String get ingFnAboutSurfactant =>
      'Binds both water and oil so grime and makeup rinse away';

  @override
  String get ingFnAboutUvChemical =>
      'Absorbs UV rays and releases them as a little heat';

  @override
  String get ingFnAboutUvMineral =>
      'Mineral particles that reflect, scatter and absorb UV';

  @override
  String get ingFnAboutHumectant => 'Draws water into the upper skin layers';

  @override
  String get ingFnAboutEmollient =>
      'Fills gaps between skin cells for soft, smooth skin';

  @override
  String get ingFnAboutOcclusive => 'Forms a film that slows water loss';

  @override
  String get ingFnAboutBarrier =>
      'Repairs the skin barrier with skin-like lipids';

  @override
  String get ingFnAboutBrightening => 'Reduces pigment for a more even tone';

  @override
  String get ingFnAboutAntioxidant =>
      'Neutralises free radicals from sun and pollution';

  @override
  String get ingFnAboutExfoliant => 'Removes dead skin cells for smoother skin';

  @override
  String get ingFnAboutAntiAcne =>
      'Targets acne bacteria, oil or clogged pores';

  @override
  String get ingFnAboutRetinoid => 'Vitamin A derivatives that renew skin';

  @override
  String get ingFnAboutAntiAging => 'Targets wrinkles and firmness';

  @override
  String get ingFnAboutSoothing => 'Calms irritation and redness';

  @override
  String get ingFnAboutAbsorbent => 'Absorbs excess oil for a matte finish';

  @override
  String get ingFnAboutFilmFormer =>
      'Forms a thin film for long wear or water resistance';

  @override
  String get ingFnAboutEmulsifier => 'Holds water and oil together in creams';

  @override
  String get ingFnAboutThickener => 'Adjusts thickness and texture';

  @override
  String get ingFnAboutPreservative =>
      'Keeps products free of bacteria and mould';

  @override
  String get ingFnAboutChelating => 'Binds metal ions to keep formulas stable';

  @override
  String get ingFnAboutPhAdjuster => 'Sets the formula’s pH';

  @override
  String get ingFnAboutSolvent => 'Dissolves other ingredients';

  @override
  String get ingFnAboutFragrance => 'Adds scent; can cause allergies';

  @override
  String get ingFnAboutColorant => 'Adds colour to the product or skin';

  @override
  String get ingFnAboutOther => 'Has a specialised role in the formula';

  @override
  String get ingredientRoles => 'Role in the formula';

  @override
  String get updateNow => 'Update now';

  @override
  String get updateInAppBody =>
      'Tap \"Update now\" and the app downloads and installs the new version itself. All your data stays.';

  @override
  String get updateDownloading => 'Downloading update…';

  @override
  String get updateInstalling =>
      'Installing… The app closes when done; tap the notification to reopen it.';

  @override
  String get updatePermissionTitle => 'Allow Very Beauty to install updates';

  @override
  String get updatePermissionBody =>
      'One time only: turn on \"Allow from this source\", then go back to the app.';

  @override
  String get updatePermissionOpen => 'Open settings';

  @override
  String get updatePermissionMissing =>
      'Not allowed yet. Try again from Settings → Check for updates.';

  @override
  String get updateDownloadFailed =>
      'Download failed. Check your connection and try again.';

  @override
  String get updateInstallFailed => 'Install failed. Please try again.';

  @override
  String get updateCancelled => 'Update cancelled';

  @override
  String get updateSignatureTitle => 'One last reinstall needed';

  @override
  String get updateSignatureBody =>
      'This installed copy was signed with a temporary key, so it can’t be updated in place. Back up, uninstall, install the new file and restore. Future updates will work from inside the app.';

  @override
  String get productPhotoAdd => 'Add photo';

  @override
  String get productPhotoCamera => 'Take a photo';

  @override
  String get productPhotoGallery => 'Choose from gallery';

  @override
  String get productPhotoRemove => 'Remove photo';

  @override
  String get productPhotoFailed => 'Couldn’t open this image. Try another one.';

  @override
  String get fieldCategoryMultiHint =>
      'Pick one or more · the first one is the main icon';

  @override
  String ingredientsMissing(int count) {
    return '$count of your ingredients have no info yet';
  }

  @override
  String get ingredientsMissingShow => 'Show list';

  @override
  String get ingredientsMissingTitle => 'Ingredients without info';

  @override
  String get ingredientsMissingHint =>
      'Copy the list and send it to the developer to add them in the next version';

  @override
  String get ingredientsMissingCopy => 'Copy list';

  @override
  String get ingredientsMissingCopied => 'Copied';

  @override
  String get ingredientsFix => 'Fix';

  @override
  String ingredientsFixTitle(String name) {
    return 'Fix “$name”';
  }

  @override
  String get ingredientsFixHint =>
      'Pick the right name; every product using it is updated';

  @override
  String ingredientsDidYouMean(String name) {
    return 'Did you mean $name?';
  }

  @override
  String ingredientsFixed(String name) {
    return 'Changed to $name';
  }
}

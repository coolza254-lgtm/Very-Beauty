import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In th, this message translates to:
  /// **'Very Beauty'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In th, this message translates to:
  /// **'วันนี้'**
  String get navToday;

  /// No description provided for @navProducts.
  ///
  /// In th, this message translates to:
  /// **'สินค้า'**
  String get navProducts;

  /// No description provided for @navPhotos.
  ///
  /// In th, this message translates to:
  /// **'รูปถ่าย'**
  String get navPhotos;

  /// No description provided for @navInsights.
  ///
  /// In th, this message translates to:
  /// **'สรุป'**
  String get navInsights;

  /// No description provided for @navSettings.
  ///
  /// In th, this message translates to:
  /// **'ตั้งค่า'**
  String get navSettings;

  /// No description provided for @comingSoon.
  ///
  /// In th, this message translates to:
  /// **'กำลังพัฒนา — จะมาในเฟสถัดไป'**
  String get comingSoon;

  /// No description provided for @todayGreeting.
  ///
  /// In th, this message translates to:
  /// **'วันนี้ดูแลผิวแล้วหรือยัง?'**
  String get todayGreeting;

  /// No description provided for @settingsAppearance.
  ///
  /// In th, this message translates to:
  /// **'รูปลักษณ์'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In th, this message translates to:
  /// **'ธีม'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In th, this message translates to:
  /// **'ตามระบบ'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In th, this message translates to:
  /// **'สว่าง'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In th, this message translates to:
  /// **'มืด'**
  String get themeDark;

  /// No description provided for @settingsAbout.
  ///
  /// In th, this message translates to:
  /// **'เกี่ยวกับแอพ'**
  String get settingsAbout;

  /// No description provided for @aboutVersion.
  ///
  /// In th, this message translates to:
  /// **'เวอร์ชัน {version}'**
  String aboutVersion(String version);

  /// No description provided for @aboutDisclaimerTitle.
  ///
  /// In th, this message translates to:
  /// **'ข้อควรทราบ'**
  String get aboutDisclaimerTitle;

  /// No description provided for @aboutDisclaimer.
  ///
  /// In th, this message translates to:
  /// **'Very Beauty เป็นเครื่องมือช่วยบันทึกการดูแลผิวส่วนตัวเท่านั้น ไม่ใช่เครื่องมือวินิจฉัยหรือรักษาทางการแพทย์ หากมีอาการผิวผิดปกติ ควรปรึกษาแพทย์ผิวหนัง'**
  String get aboutDisclaimer;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In th, this message translates to:
  /// **'ความเป็นส่วนตัว'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacy.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลและรูปถ่ายทั้งหมดถูกเก็บไว้ในเครื่องของคุณเท่านั้น แอพไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ และไม่มีระบบติดตามการใช้งาน'**
  String get aboutPrivacy;

  /// No description provided for @todayHello.
  ///
  /// In th, this message translates to:
  /// **'สวัสดีค่ะ'**
  String get todayHello;

  /// No description provided for @todayHeroSubtitle.
  ///
  /// In th, this message translates to:
  /// **'ดูแลผิวทีละนิด ให้สวยในแบบของคุณ'**
  String get todayHeroSubtitle;

  /// No description provided for @todayRoutinesTitle.
  ///
  /// In th, this message translates to:
  /// **'รูทีนของวันนี้'**
  String get todayRoutinesTitle;

  /// No description provided for @routineNoSteps.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีขั้นตอน · เพิ่มสินค้าได้เร็วๆ นี้'**
  String get routineNoSteps;

  /// No description provided for @todayQuickTitle.
  ///
  /// In th, this message translates to:
  /// **'บันทึกด่วน'**
  String get todayQuickTitle;

  /// No description provided for @quickPhoto.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูปผิว'**
  String get quickPhoto;

  /// No description provided for @quickSkinLog.
  ///
  /// In th, this message translates to:
  /// **'บันทึกสภาพผิว'**
  String get quickSkinLog;

  /// No description provided for @productsEmptyTitle.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีสินค้า'**
  String get productsEmptyTitle;

  /// No description provided for @productsEmptyBody.
  ///
  /// In th, this message translates to:
  /// **'เก็บสกินแคร์ทุกขวด พร้อมราคา ปริมาณ และความคุ้มค่า'**
  String get productsEmptyBody;

  /// No description provided for @photosEmptyTitle.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีรูปถ่าย'**
  String get photosEmptyTitle;

  /// No description provided for @photosEmptyBody.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูปผิวในมุมเดิมทุกครั้ง แล้วเทียบผลลัพธ์ตามเวลา'**
  String get photosEmptyBody;

  /// No description provided for @insightsEmptyTitle.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีข้อมูลสรุป'**
  String get insightsEmptyTitle;

  /// No description provided for @insightsEmptyBody.
  ///
  /// In th, this message translates to:
  /// **'ปฏิทิน กราฟสภาพผิว และความคุ้มค่าจะแสดงที่นี่'**
  String get insightsEmptyBody;

  /// No description provided for @comingSoonBadge.
  ///
  /// In th, this message translates to:
  /// **'เร็วๆ นี้'**
  String get comingSoonBadge;

  /// No description provided for @settingsAppInfo.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลแอพ'**
  String get settingsAppInfo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

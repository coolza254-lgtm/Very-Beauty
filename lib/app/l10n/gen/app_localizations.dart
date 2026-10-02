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
  /// **'ข้อมูลและรูปถ่ายทั้งหมดถูกเก็บไว้ในเครื่องของคุณเท่านั้น แอพไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ และไม่มีระบบติดตามการใช้งาน\n\nการเชื่อมต่ออินเทอร์เน็ตเพียงอย่างเดียวคือการตรวจสอบเวอร์ชันใหม่จาก GitHub (ปิดได้ในการตั้งค่า) ซึ่งไม่ส่งข้อมูลใดๆ ของคุณออกไป'**
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

  /// No description provided for @categoryCleanser.
  ///
  /// In th, this message translates to:
  /// **'คลีนเซอร์'**
  String get categoryCleanser;

  /// No description provided for @categoryToner.
  ///
  /// In th, this message translates to:
  /// **'โทนเนอร์'**
  String get categoryToner;

  /// No description provided for @categorySerum.
  ///
  /// In th, this message translates to:
  /// **'เซรั่ม'**
  String get categorySerum;

  /// No description provided for @categoryMoisturizer.
  ///
  /// In th, this message translates to:
  /// **'มอยส์เจอไรเซอร์'**
  String get categoryMoisturizer;

  /// No description provided for @categorySunscreen.
  ///
  /// In th, this message translates to:
  /// **'กันแดด'**
  String get categorySunscreen;

  /// No description provided for @categoryTreatment.
  ///
  /// In th, this message translates to:
  /// **'ทรีตเมนต์'**
  String get categoryTreatment;

  /// No description provided for @categoryMask.
  ///
  /// In th, this message translates to:
  /// **'มาสก์'**
  String get categoryMask;

  /// No description provided for @categoryOther.
  ///
  /// In th, this message translates to:
  /// **'อื่นๆ'**
  String get categoryOther;

  /// No description provided for @statusInUse.
  ///
  /// In th, this message translates to:
  /// **'ใช้อยู่'**
  String get statusInUse;

  /// No description provided for @statusFinished.
  ///
  /// In th, this message translates to:
  /// **'ใช้หมดแล้ว'**
  String get statusFinished;

  /// No description provided for @statusPaused.
  ///
  /// In th, this message translates to:
  /// **'พักไว้'**
  String get statusPaused;

  /// No description provided for @statusWishlist.
  ///
  /// In th, this message translates to:
  /// **'อยากได้'**
  String get statusWishlist;

  /// No description provided for @unitG.
  ///
  /// In th, this message translates to:
  /// **'กรัม'**
  String get unitG;

  /// No description provided for @unitMl.
  ///
  /// In th, this message translates to:
  /// **'มล.'**
  String get unitMl;

  /// No description provided for @filterAll.
  ///
  /// In th, this message translates to:
  /// **'ทั้งหมด'**
  String get filterAll;

  /// No description provided for @productsSearchHint.
  ///
  /// In th, this message translates to:
  /// **'ค้นหาชื่อหรือแบรนด์'**
  String get productsSearchHint;

  /// No description provided for @productsAdd.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มสินค้า'**
  String get productsAdd;

  /// No description provided for @productsNoMatch.
  ///
  /// In th, this message translates to:
  /// **'ไม่พบสินค้าที่ตรงกับตัวกรอง'**
  String get productsNoMatch;

  /// No description provided for @productFormNew.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มสินค้า'**
  String get productFormNew;

  /// No description provided for @productFormEdit.
  ///
  /// In th, this message translates to:
  /// **'แก้ไขสินค้า'**
  String get productFormEdit;

  /// No description provided for @fieldName.
  ///
  /// In th, this message translates to:
  /// **'ชื่อสินค้า'**
  String get fieldName;

  /// No description provided for @fieldNameRequired.
  ///
  /// In th, this message translates to:
  /// **'กรุณาใส่ชื่อสินค้า'**
  String get fieldNameRequired;

  /// No description provided for @fieldCategory.
  ///
  /// In th, this message translates to:
  /// **'ประเภท'**
  String get fieldCategory;

  /// No description provided for @fieldPrice.
  ///
  /// In th, this message translates to:
  /// **'ราคา (บาท)'**
  String get fieldPrice;

  /// No description provided for @fieldNetContent.
  ///
  /// In th, this message translates to:
  /// **'ปริมาณสุทธิ'**
  String get fieldNetContent;

  /// No description provided for @fieldMoreDetails.
  ///
  /// In th, this message translates to:
  /// **'รายละเอียดเพิ่มเติม'**
  String get fieldMoreDetails;

  /// No description provided for @fieldMoreDetailsHint.
  ///
  /// In th, this message translates to:
  /// **'แบรนด์ วันที่เปิดใช้ น้ำหนัก ส่วนผสม ฯลฯ'**
  String get fieldMoreDetailsHint;

  /// No description provided for @fieldBrand.
  ///
  /// In th, this message translates to:
  /// **'แบรนด์'**
  String get fieldBrand;

  /// No description provided for @fieldStatus.
  ///
  /// In th, this message translates to:
  /// **'สถานะ'**
  String get fieldStatus;

  /// No description provided for @fieldPurchasePlace.
  ///
  /// In th, this message translates to:
  /// **'ซื้อจากที่ไหน'**
  String get fieldPurchasePlace;

  /// No description provided for @fieldPurchaseDate.
  ///
  /// In th, this message translates to:
  /// **'วันที่ซื้อ'**
  String get fieldPurchaseDate;

  /// No description provided for @fieldOpenedDate.
  ///
  /// In th, this message translates to:
  /// **'วันที่เปิดใช้'**
  String get fieldOpenedDate;

  /// No description provided for @fieldPao.
  ///
  /// In th, this message translates to:
  /// **'อายุหลังเปิด (เดือน)'**
  String get fieldPao;

  /// No description provided for @fieldExpiry.
  ///
  /// In th, this message translates to:
  /// **'วันหมดอายุบนฉลาก'**
  String get fieldExpiry;

  /// No description provided for @fieldStartWeight.
  ///
  /// In th, this message translates to:
  /// **'น้ำหนักทั้งหมดตอนยังไม่ใช้ (กรัม รวมบรรจุภัณฑ์)'**
  String get fieldStartWeight;

  /// No description provided for @fieldEmptyWeight.
  ///
  /// In th, this message translates to:
  /// **'น้ำหนักบรรจุภัณฑ์เปล่า (กรัม)'**
  String get fieldEmptyWeight;

  /// No description provided for @fieldEmptyWeightHelp.
  ///
  /// In th, this message translates to:
  /// **'เว้นว่างได้ แอพจะคำนวณให้จาก น้ำหนักทั้งหมด − ปริมาณสุทธิ'**
  String get fieldEmptyWeightHelp;

  /// No description provided for @fieldNote.
  ///
  /// In th, this message translates to:
  /// **'โน้ต'**
  String get fieldNote;

  /// No description provided for @fieldIngredients.
  ///
  /// In th, this message translates to:
  /// **'ส่วนผสม'**
  String get fieldIngredients;

  /// No description provided for @fieldIngredientsHelp.
  ///
  /// In th, this message translates to:
  /// **'พิมพ์ชื่อไทยหรืออังกฤษแล้วเลือกจากรายการ หรือวางรายชื่อจากฉลาก (คั่นด้วยจุลภาค)'**
  String get fieldIngredientsHelp;

  /// No description provided for @fieldInvalidNumber.
  ///
  /// In th, this message translates to:
  /// **'ตัวเลขไม่ถูกต้อง'**
  String get fieldInvalidNumber;

  /// No description provided for @pickDate.
  ///
  /// In th, this message translates to:
  /// **'เลือกวันที่'**
  String get pickDate;

  /// No description provided for @actionSave.
  ///
  /// In th, this message translates to:
  /// **'บันทึก'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In th, this message translates to:
  /// **'ยกเลิก'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In th, this message translates to:
  /// **'ลบ'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In th, this message translates to:
  /// **'แก้ไข'**
  String get actionEdit;

  /// No description provided for @actionClear.
  ///
  /// In th, this message translates to:
  /// **'ล้าง'**
  String get actionClear;

  /// No description provided for @remainingExact.
  ///
  /// In th, this message translates to:
  /// **'เหลือ {percent}%'**
  String remainingExact(String percent);

  /// No description provided for @remainingApprox.
  ///
  /// In th, this message translates to:
  /// **'เหลือประมาณ {percent}%'**
  String remainingApprox(String percent);

  /// No description provided for @remainingUnknown.
  ///
  /// In th, this message translates to:
  /// **'ชั่งน้ำหนักเพื่อดูว่าเหลือเท่าไหร่'**
  String get remainingUnknown;

  /// No description provided for @statUsed.
  ///
  /// In th, this message translates to:
  /// **'ใช้ไปแล้ว'**
  String get statUsed;

  /// No description provided for @statRemaining.
  ///
  /// In th, this message translates to:
  /// **'คงเหลือ'**
  String get statRemaining;

  /// No description provided for @statPerDay.
  ///
  /// In th, this message translates to:
  /// **'ใช้ต่อวัน'**
  String get statPerDay;

  /// No description provided for @statPricePerUnit.
  ///
  /// In th, this message translates to:
  /// **'ราคาต่อ{unit}'**
  String statPricePerUnit(String unit);

  /// No description provided for @statCostUsed.
  ///
  /// In th, this message translates to:
  /// **'มูลค่าที่ใช้ไป'**
  String get statCostUsed;

  /// No description provided for @statCostPerUse.
  ///
  /// In th, this message translates to:
  /// **'บาทต่อครั้ง (ประมาณ)'**
  String get statCostPerUse;

  /// No description provided for @statUsageCount.
  ///
  /// In th, this message translates to:
  /// **'จำนวนครั้งที่ใช้'**
  String get statUsageCount;

  /// No description provided for @statEmptyOn.
  ///
  /// In th, this message translates to:
  /// **'คาดว่าจะหมด'**
  String get statEmptyOn;

  /// No description provided for @notEnoughData.
  ///
  /// In th, this message translates to:
  /// **'ยังประมาณไม่ได้'**
  String get notEnoughData;

  /// No description provided for @weightAnomaly.
  ///
  /// In th, this message translates to:
  /// **'น้ำหนักล่าสุดมากกว่าตอนเริ่มต้น อาจชั่งผิด ลองชั่งใหม่หรือลบรายการที่ผิด'**
  String get weightAnomaly;

  /// No description provided for @weightHistory.
  ///
  /// In th, this message translates to:
  /// **'ประวัติการชั่ง'**
  String get weightHistory;

  /// No description provided for @weightChartTitle.
  ///
  /// In th, this message translates to:
  /// **'น้ำหนักตามเวลา'**
  String get weightChartTitle;

  /// No description provided for @weighNow.
  ///
  /// In th, this message translates to:
  /// **'ชั่งใหม่'**
  String get weighNow;

  /// No description provided for @weighTitle.
  ///
  /// In th, this message translates to:
  /// **'ชั่งน้ำหนัก'**
  String get weighTitle;

  /// No description provided for @weighHint.
  ///
  /// In th, this message translates to:
  /// **'น้ำหนักรวมขวด (กรัม)'**
  String get weighHint;

  /// No description provided for @weighDiff.
  ///
  /// In th, this message translates to:
  /// **'{diff} กรัม จากครั้งก่อน'**
  String weighDiff(String diff);

  /// No description provided for @weighFirst.
  ///
  /// In th, this message translates to:
  /// **'ครั้งแรก ชั่งตอนยังไม่ได้ใช้ (รวมบรรจุภัณฑ์) จะใช้เป็นน้ำหนักเริ่มต้น'**
  String get weighFirst;

  /// No description provided for @weighHeavier.
  ///
  /// In th, this message translates to:
  /// **'หนักกว่าครั้งก่อน ตรวจสอบอีกครั้งนะ'**
  String get weighHeavier;

  /// No description provided for @weighEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีการชั่ง'**
  String get weighEmpty;

  /// No description provided for @skinWhileUsing.
  ///
  /// In th, this message translates to:
  /// **'ผิวช่วงที่ใช้สินค้านี้'**
  String get skinWhileUsing;

  /// No description provided for @skinWhileUsingEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีบันทึกผิวในวันที่ใช้สินค้านี้'**
  String get skinWhileUsingEmpty;

  /// No description provided for @basedOnDays.
  ///
  /// In th, this message translates to:
  /// **'จาก {count} วันที่บันทึก'**
  String basedOnDays(int count);

  /// No description provided for @scoreOil.
  ///
  /// In th, this message translates to:
  /// **'ความมัน'**
  String get scoreOil;

  /// No description provided for @scoreMoisture.
  ///
  /// In th, this message translates to:
  /// **'ความชุ่มชื้น'**
  String get scoreMoisture;

  /// No description provided for @scoreAcne.
  ///
  /// In th, this message translates to:
  /// **'สิว'**
  String get scoreAcne;

  /// No description provided for @scoreRedness.
  ///
  /// In th, this message translates to:
  /// **'ความแดง'**
  String get scoreRedness;

  /// No description provided for @scoreDullness.
  ///
  /// In th, this message translates to:
  /// **'ความหมองคล้ำ'**
  String get scoreDullness;

  /// No description provided for @finishAction.
  ///
  /// In th, this message translates to:
  /// **'ใช้หมดแล้ว'**
  String get finishAction;

  /// No description provided for @finishTitle.
  ///
  /// In th, this message translates to:
  /// **'ปิดสินค้านี้'**
  String get finishTitle;

  /// No description provided for @finishRating.
  ///
  /// In th, this message translates to:
  /// **'ให้คะแนน'**
  String get finishRating;

  /// No description provided for @finishRepurchase.
  ///
  /// In th, this message translates to:
  /// **'จะซื้อซ้ำไหม?'**
  String get finishRepurchase;

  /// No description provided for @repurchaseYes.
  ///
  /// In th, this message translates to:
  /// **'ซื้อซ้ำ'**
  String get repurchaseYes;

  /// No description provided for @repurchaseNo.
  ///
  /// In th, this message translates to:
  /// **'ไม่ซื้อซ้ำ'**
  String get repurchaseNo;

  /// No description provided for @actionReopen.
  ///
  /// In th, this message translates to:
  /// **'นำกลับมาใช้'**
  String get actionReopen;

  /// No description provided for @actionStartUsing.
  ///
  /// In th, this message translates to:
  /// **'เริ่มใช้'**
  String get actionStartUsing;

  /// No description provided for @actionPause.
  ///
  /// In th, this message translates to:
  /// **'พักไว้'**
  String get actionPause;

  /// No description provided for @deleteProductTitle.
  ///
  /// In th, this message translates to:
  /// **'ลบสินค้านี้?'**
  String get deleteProductTitle;

  /// No description provided for @deleteProductBody.
  ///
  /// In th, this message translates to:
  /// **'ประวัติการชั่งและการใช้ของสินค้านี้จะถูกลบด้วย'**
  String get deleteProductBody;

  /// No description provided for @deleteWeighingTitle.
  ///
  /// In th, this message translates to:
  /// **'ลบรายการชั่งนี้?'**
  String get deleteWeighingTitle;

  /// No description provided for @wishlistCompare.
  ///
  /// In th, this message translates to:
  /// **'เทียบความคุ้มค่า'**
  String get wishlistCompare;

  /// No description provided for @wishlistCompareEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีสินค้าประเภทเดียวกันที่มีราคาต่อหน่วยให้เทียบ'**
  String get wishlistCompareEmpty;

  /// No description provided for @wishlistCompareNeedsPrice.
  ///
  /// In th, this message translates to:
  /// **'ใส่ราคาและปริมาณเพื่อเทียบความคุ้มค่า'**
  String get wishlistCompareNeedsPrice;

  /// No description provided for @cheaperBy.
  ///
  /// In th, this message translates to:
  /// **'ถูกกว่า {percent}%'**
  String cheaperBy(String percent);

  /// No description provided for @pricierBy.
  ///
  /// In th, this message translates to:
  /// **'แพงกว่า {percent}%'**
  String pricierBy(String percent);

  /// No description provided for @samePrice.
  ///
  /// In th, this message translates to:
  /// **'ราคาพอๆ กัน'**
  String get samePrice;

  /// No description provided for @infoSection.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลสินค้า'**
  String get infoSection;

  /// No description provided for @expiresOn.
  ///
  /// In th, this message translates to:
  /// **'หมดอายุ'**
  String get expiresOn;

  /// No description provided for @ratingLabel.
  ///
  /// In th, this message translates to:
  /// **'คะแนน'**
  String get ratingLabel;

  /// No description provided for @repurchaseLabel.
  ///
  /// In th, this message translates to:
  /// **'ซื้อซ้ำ'**
  String get repurchaseLabel;

  /// No description provided for @finishedOn.
  ///
  /// In th, this message translates to:
  /// **'ใช้หมดเมื่อ'**
  String get finishedOn;

  /// No description provided for @perUnitShort.
  ///
  /// In th, this message translates to:
  /// **'฿{price}/{unit}'**
  String perUnitShort(String price, String unit);

  /// No description provided for @productNotFound.
  ///
  /// In th, this message translates to:
  /// **'ไม่พบสินค้านี้'**
  String get productNotFound;

  /// No description provided for @valueSection.
  ///
  /// In th, this message translates to:
  /// **'ความคุ้มค่า'**
  String get valueSection;

  /// No description provided for @reminderRoutineTitle.
  ///
  /// In th, this message translates to:
  /// **'ถึงเวลารูทีน{name}แล้ว ✨'**
  String reminderRoutineTitle(String name);

  /// No description provided for @reminderRoutineBody.
  ///
  /// In th, this message translates to:
  /// **'แตะเพื่อติ๊กว่าใช้อะไรไปบ้างวันนี้'**
  String get reminderRoutineBody;

  /// No description provided for @reminderWeighTitle.
  ///
  /// In th, this message translates to:
  /// **'ถึงเวลาชั่งสกินแคร์'**
  String get reminderWeighTitle;

  /// No description provided for @reminderWeighBody.
  ///
  /// In th, this message translates to:
  /// **'ชั่งขวดที่ใช้อยู่ จะได้รู้ว่าเหลือเท่าไหร่และหมดเมื่อไหร่'**
  String get reminderWeighBody;

  /// No description provided for @reminderExpiryTitle.
  ///
  /// In th, this message translates to:
  /// **'สินค้าใกล้หมดอายุ'**
  String get reminderExpiryTitle;

  /// No description provided for @reminderExpiryBody.
  ///
  /// In th, this message translates to:
  /// **'{name} จะหมดอายุในอีก 7 วัน'**
  String reminderExpiryBody(String name);

  /// No description provided for @reminderBackupTitle.
  ///
  /// In th, this message translates to:
  /// **'สำรองข้อมูลกันไว้หน่อยไหม?'**
  String get reminderBackupTitle;

  /// No description provided for @reminderBackupBody.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลทั้งหมดอยู่ในเครื่องนี้เท่านั้น สำรองไว้กันหายเวลาเปลี่ยนเครื่อง'**
  String get reminderBackupBody;

  /// No description provided for @routinesTitle.
  ///
  /// In th, this message translates to:
  /// **'รูทีนของฉัน'**
  String get routinesTitle;

  /// No description provided for @routinesManage.
  ///
  /// In th, this message translates to:
  /// **'จัดการรูทีน'**
  String get routinesManage;

  /// No description provided for @routineNew.
  ///
  /// In th, this message translates to:
  /// **'รูทีนใหม่'**
  String get routineNew;

  /// No description provided for @routineName.
  ///
  /// In th, this message translates to:
  /// **'ชื่อรูทีน'**
  String get routineName;

  /// No description provided for @routineSlot.
  ///
  /// In th, this message translates to:
  /// **'ช่วงเวลา'**
  String get routineSlot;

  /// No description provided for @slotMorning.
  ///
  /// In th, this message translates to:
  /// **'เช้า'**
  String get slotMorning;

  /// No description provided for @slotEvening.
  ///
  /// In th, this message translates to:
  /// **'เย็น'**
  String get slotEvening;

  /// No description provided for @slotOther.
  ///
  /// In th, this message translates to:
  /// **'อื่นๆ'**
  String get slotOther;

  /// No description provided for @routineSteps.
  ///
  /// In th, this message translates to:
  /// **'ขั้นตอน'**
  String get routineSteps;

  /// No description provided for @routineStepsHint.
  ///
  /// In th, this message translates to:
  /// **'กดค้างแล้วลากเพื่อจัดลำดับ'**
  String get routineStepsHint;

  /// No description provided for @routineAddSteps.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มขั้นตอน'**
  String get routineAddSteps;

  /// No description provided for @routineAddStepsTitle.
  ///
  /// In th, this message translates to:
  /// **'เลือกสินค้าที่ใช้ในรูทีนนี้'**
  String get routineAddStepsTitle;

  /// No description provided for @routineAddStepsEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีสินค้าที่ใช้อยู่ เพิ่มสินค้าก่อนนะ'**
  String get routineAddStepsEmpty;

  /// No description provided for @routineAddSelected.
  ///
  /// In th, this message translates to:
  /// **'เพิ่ม {count} รายการ'**
  String routineAddSelected(int count);

  /// No description provided for @routineReminder.
  ///
  /// In th, this message translates to:
  /// **'แจ้งเตือนรูทีนนี้'**
  String get routineReminder;

  /// No description provided for @routineReminderAt.
  ///
  /// In th, this message translates to:
  /// **'ทุกวัน เวลา {time}'**
  String routineReminderAt(String time);

  /// No description provided for @routineDeleteTitle.
  ///
  /// In th, this message translates to:
  /// **'ลบรูทีนนี้?'**
  String get routineDeleteTitle;

  /// No description provided for @routineDeleteBody.
  ///
  /// In th, this message translates to:
  /// **'ประวัติการใช้สินค้าจะยังอยู่'**
  String get routineDeleteBody;

  /// No description provided for @routineStepCount.
  ///
  /// In th, this message translates to:
  /// **'{count} ขั้นตอน'**
  String routineStepCount(int count);

  /// No description provided for @routineNotInUse.
  ///
  /// In th, this message translates to:
  /// **'ไม่ได้ใช้อยู่'**
  String get routineNotInUse;

  /// No description provided for @routineEmptySteps.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีขั้นตอน แตะเพื่อเพิ่มสินค้า'**
  String get routineEmptySteps;

  /// No description provided for @routineUseAsUsual.
  ///
  /// In th, this message translates to:
  /// **'ใช้ตามปกติ'**
  String get routineUseAsUsual;

  /// No description provided for @routineAllDone.
  ///
  /// In th, this message translates to:
  /// **'ครบแล้ว'**
  String get routineAllDone;

  /// No description provided for @routineProgress.
  ///
  /// In th, this message translates to:
  /// **'{done}/{total}'**
  String routineProgress(int done, int total);

  /// No description provided for @todayProgress.
  ///
  /// In th, this message translates to:
  /// **'วันนี้ทำไปแล้ว {done} จาก {total} ขั้นตอน'**
  String todayProgress(int done, int total);

  /// No description provided for @todayAllDone.
  ///
  /// In th, this message translates to:
  /// **'ครบทุกขั้นตอนแล้ว เก่งมาก! 💗'**
  String get todayAllDone;

  /// No description provided for @todayAlertsTitle.
  ///
  /// In th, this message translates to:
  /// **'ควรรู้วันนี้'**
  String get todayAlertsTitle;

  /// No description provided for @alertLow.
  ///
  /// In th, this message translates to:
  /// **'{name} เหลือประมาณ {percent}%'**
  String alertLow(String name, String percent);

  /// No description provided for @alertEmptySoon.
  ///
  /// In th, this message translates to:
  /// **'{name} คาดว่าจะหมด {date}'**
  String alertEmptySoon(String name, String date);

  /// No description provided for @alertExpired.
  ///
  /// In th, this message translates to:
  /// **'{name} หมดอายุแล้ว ({date})'**
  String alertExpired(String name, String date);

  /// No description provided for @alertExpiring.
  ///
  /// In th, this message translates to:
  /// **'{name} จะหมดอายุ {date}'**
  String alertExpiring(String name, String date);

  /// No description provided for @alertWeighDue.
  ///
  /// In th, this message translates to:
  /// **'ถึงเวลาชั่ง {name} (ชั่งล่าสุด {days} วันก่อน)'**
  String alertWeighDue(String name, int days);

  /// No description provided for @todaySkinTitle.
  ///
  /// In th, this message translates to:
  /// **'ผิววันนี้'**
  String get todaySkinTitle;

  /// No description provided for @todaySkinEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่ได้บันทึก แตะเพื่อบันทึกสภาพผิว'**
  String get todaySkinEmpty;

  /// No description provided for @todaySkinEdit.
  ///
  /// In th, this message translates to:
  /// **'แก้ไขบันทึก'**
  String get todaySkinEdit;

  /// No description provided for @dailyLogTitle.
  ///
  /// In th, this message translates to:
  /// **'บันทึกสภาพผิว'**
  String get dailyLogTitle;

  /// No description provided for @dailyLogScores.
  ///
  /// In th, this message translates to:
  /// **'ให้คะแนนผิว'**
  String get dailyLogScores;

  /// No description provided for @dailyLogScoresHint.
  ///
  /// In th, this message translates to:
  /// **'1 = น้อยมาก · 5 = มากที่สุด แตะซ้ำเพื่อล้าง'**
  String get dailyLogScoresHint;

  /// No description provided for @dailyLogSymptoms.
  ///
  /// In th, this message translates to:
  /// **'อาการ'**
  String get dailyLogSymptoms;

  /// No description provided for @dailyLogFactors.
  ///
  /// In th, this message translates to:
  /// **'ปัจจัยแวดล้อม'**
  String get dailyLogFactors;

  /// No description provided for @dailyLogLifestyle.
  ///
  /// In th, this message translates to:
  /// **'ไลฟ์สไตล์'**
  String get dailyLogLifestyle;

  /// No description provided for @dailyLogSleep.
  ///
  /// In th, this message translates to:
  /// **'นอน (ชั่วโมง)'**
  String get dailyLogSleep;

  /// No description provided for @dailyLogStress.
  ///
  /// In th, this message translates to:
  /// **'ความเครียด'**
  String get dailyLogStress;

  /// No description provided for @dailyLogSun.
  ///
  /// In th, this message translates to:
  /// **'โดนแดด'**
  String get dailyLogSun;

  /// No description provided for @sunNone.
  ///
  /// In th, this message translates to:
  /// **'ไม่โดน'**
  String get sunNone;

  /// No description provided for @sunLow.
  ///
  /// In th, this message translates to:
  /// **'เล็กน้อย'**
  String get sunLow;

  /// No description provided for @sunHigh.
  ///
  /// In th, this message translates to:
  /// **'นาน'**
  String get sunHigh;

  /// No description provided for @dailyLogPeriod.
  ///
  /// In th, this message translates to:
  /// **'รอบเดือน'**
  String get dailyLogPeriod;

  /// No description provided for @periodMenstruation.
  ///
  /// In th, this message translates to:
  /// **'มีประจำเดือน'**
  String get periodMenstruation;

  /// No description provided for @periodFollicular.
  ///
  /// In th, this message translates to:
  /// **'หลังมีประจำเดือน'**
  String get periodFollicular;

  /// No description provided for @periodOvulation.
  ///
  /// In th, this message translates to:
  /// **'ช่วงไข่ตก'**
  String get periodOvulation;

  /// No description provided for @periodLuteal.
  ///
  /// In th, this message translates to:
  /// **'ก่อนมีประจำเดือน'**
  String get periodLuteal;

  /// No description provided for @dailyLogNote.
  ///
  /// In th, this message translates to:
  /// **'โน้ต'**
  String get dailyLogNote;

  /// No description provided for @dailyLogNoteHint.
  ///
  /// In th, this message translates to:
  /// **'วันนี้ผิวเป็นยังไงบ้าง ลองอะไรใหม่ไหม'**
  String get dailyLogNoteHint;

  /// No description provided for @dailyLogSaved.
  ///
  /// In th, this message translates to:
  /// **'บันทึกแล้ว'**
  String get dailyLogSaved;

  /// No description provided for @tagAdd.
  ///
  /// In th, this message translates to:
  /// **'เพิ่ม'**
  String get tagAdd;

  /// No description provided for @tagAddTitle.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มแท็กใหม่'**
  String get tagAddTitle;

  /// No description provided for @tagName.
  ///
  /// In th, this message translates to:
  /// **'ชื่อแท็ก'**
  String get tagName;

  /// No description provided for @settingsNotifications.
  ///
  /// In th, this message translates to:
  /// **'การแจ้งเตือน'**
  String get settingsNotifications;

  /// No description provided for @settingsRoutineReminders.
  ///
  /// In th, this message translates to:
  /// **'แจ้งเตือนรูทีนเช้า/เย็น'**
  String get settingsRoutineReminders;

  /// No description provided for @settingsRoutineRemindersHint.
  ///
  /// In th, this message translates to:
  /// **'ตั้งเวลาได้ในแต่ละรูทีน'**
  String get settingsRoutineRemindersHint;

  /// No description provided for @settingsWeighReminder.
  ///
  /// In th, this message translates to:
  /// **'เตือนให้ชั่งน้ำหนักสินค้า'**
  String get settingsWeighReminder;

  /// No description provided for @weighReminderOff.
  ///
  /// In th, this message translates to:
  /// **'ปิด'**
  String get weighReminderOff;

  /// No description provided for @weighReminderWeekly.
  ///
  /// In th, this message translates to:
  /// **'ทุกสัปดาห์'**
  String get weighReminderWeekly;

  /// No description provided for @weighReminderBiweekly.
  ///
  /// In th, this message translates to:
  /// **'ทุก 2 สัปดาห์'**
  String get weighReminderBiweekly;

  /// No description provided for @settingsExpiryReminders.
  ///
  /// In th, this message translates to:
  /// **'เตือนก่อนหมดอายุ 7 วัน'**
  String get settingsExpiryReminders;

  /// No description provided for @settingsExpiryRemindersHint.
  ///
  /// In th, this message translates to:
  /// **'นับจากวันหมดอายุบนฉลาก หรืออายุหลังเปิด (PAO)'**
  String get settingsExpiryRemindersHint;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// In th, this message translates to:
  /// **'ขอสิทธิ์แจ้งเตือน'**
  String get notificationPermissionTitle;

  /// No description provided for @notificationPermissionBody.
  ///
  /// In th, this message translates to:
  /// **'Very Beauty จะส่งการแจ้งเตือนจากในเครื่องเท่านั้น เพื่อเตือนรูทีน การชั่ง และวันหมดอายุ ไม่มีการส่งข้อมูลออกไปไหน'**
  String get notificationPermissionBody;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่ได้รับสิทธิ์แจ้งเตือน เปิดได้ในการตั้งค่าของเครื่อง'**
  String get notificationPermissionDenied;

  /// No description provided for @actionContinue.
  ///
  /// In th, this message translates to:
  /// **'ดำเนินการต่อ'**
  String get actionContinue;

  /// No description provided for @actionDone.
  ///
  /// In th, this message translates to:
  /// **'เสร็จ'**
  String get actionDone;

  /// No description provided for @pickTime.
  ///
  /// In th, this message translates to:
  /// **'เลือกเวลา'**
  String get pickTime;

  /// No description provided for @cameraTitle.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูปผิว'**
  String get cameraTitle;

  /// No description provided for @cameraTipTitle.
  ///
  /// In th, this message translates to:
  /// **'เคล็ดลับให้เทียบผลได้แม่น'**
  String get cameraTipTitle;

  /// No description provided for @cameraTip.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายใกล้หน้าต่าง ใช้แสงธรรมชาติแบบเดิมทุกครั้ง ไม่ใช้แฟลช จัดหน้าให้อยู่ในกรอบวงรี'**
  String get cameraTip;

  /// No description provided for @cameraPermissionTitle.
  ///
  /// In th, this message translates to:
  /// **'ขอใช้กล้อง'**
  String get cameraPermissionTitle;

  /// No description provided for @cameraPermissionBody.
  ///
  /// In th, this message translates to:
  /// **'ใช้กล้องเพื่อถ่ายรูปผิวไว้เทียบผล รูปจะเก็บในแอพนี้เท่านั้น ไม่ลงแกลเลอรีและไม่ส่งออกไปไหน'**
  String get cameraPermissionBody;

  /// No description provided for @cameraDenied.
  ///
  /// In th, this message translates to:
  /// **'ไม่ได้รับสิทธิ์ใช้กล้อง เปิดได้ในการตั้งค่าของเครื่อง'**
  String get cameraDenied;

  /// No description provided for @cameraUnavailable.
  ///
  /// In th, this message translates to:
  /// **'ไม่พบกล้องบนอุปกรณ์นี้'**
  String get cameraUnavailable;

  /// No description provided for @cameraOnionSkin.
  ///
  /// In th, this message translates to:
  /// **'ภาพครั้งก่อน'**
  String get cameraOnionSkin;

  /// No description provided for @cameraSwitch.
  ///
  /// In th, this message translates to:
  /// **'สลับกล้อง'**
  String get cameraSwitch;

  /// No description provided for @cameraCapture.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูป'**
  String get cameraCapture;

  /// No description provided for @cameraSaving.
  ///
  /// In th, this message translates to:
  /// **'กำลังบันทึก…'**
  String get cameraSaving;

  /// No description provided for @cameraSaved.
  ///
  /// In th, this message translates to:
  /// **'บันทึกรูปแล้ว'**
  String get cameraSaved;

  /// No description provided for @photoSession.
  ///
  /// In th, this message translates to:
  /// **'ช่วง'**
  String get photoSession;

  /// No description provided for @photosCompare.
  ///
  /// In th, this message translates to:
  /// **'เทียบรูป'**
  String get photosCompare;

  /// No description provided for @photosSelectTwo.
  ///
  /// In th, this message translates to:
  /// **'เลือก 2 รูปที่จะเทียบ'**
  String get photosSelectTwo;

  /// No description provided for @photosSelected.
  ///
  /// In th, this message translates to:
  /// **'เลือกแล้ว {count}/2'**
  String photosSelected(int count);

  /// No description provided for @photosTake.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูป'**
  String get photosTake;

  /// No description provided for @photoDeleteTitle.
  ///
  /// In th, this message translates to:
  /// **'ลบรูปนี้?'**
  String get photoDeleteTitle;

  /// No description provided for @photoDeleteBody.
  ///
  /// In th, this message translates to:
  /// **'รูปจะถูกลบออกจากเครื่องถาวร'**
  String get photoDeleteBody;

  /// No description provided for @photoNote.
  ///
  /// In th, this message translates to:
  /// **'โน้ตของรูป'**
  String get photoNote;

  /// No description provided for @compareTitle.
  ///
  /// In th, this message translates to:
  /// **'เทียบรูป'**
  String get compareTitle;

  /// No description provided for @compareHint.
  ///
  /// In th, this message translates to:
  /// **'ลากเส้นกลางเพื่อเทียบ'**
  String get compareHint;

  /// No description provided for @compareDaysApart.
  ///
  /// In th, this message translates to:
  /// **'ห่างกัน {days} วัน'**
  String compareDaysApart(int days);

  /// No description provided for @insightsTabCalendar.
  ///
  /// In th, this message translates to:
  /// **'ปฏิทิน'**
  String get insightsTabCalendar;

  /// No description provided for @insightsTabChart.
  ///
  /// In th, this message translates to:
  /// **'กราฟผิว'**
  String get insightsTabChart;

  /// No description provided for @insightsTabSearch.
  ///
  /// In th, this message translates to:
  /// **'ค้นหา'**
  String get insightsTabSearch;

  /// No description provided for @insightsTabSpending.
  ///
  /// In th, this message translates to:
  /// **'ค่าใช้จ่าย'**
  String get insightsTabSpending;

  /// No description provided for @calendarLegendCalm.
  ///
  /// In th, this message translates to:
  /// **'ผิวดี'**
  String get calendarLegendCalm;

  /// No description provided for @calendarLegendTroubled.
  ///
  /// In th, this message translates to:
  /// **'มีปัญหา'**
  String get calendarLegendTroubled;

  /// No description provided for @calendarLegendPhoto.
  ///
  /// In th, this message translates to:
  /// **'มีรูป'**
  String get calendarLegendPhoto;

  /// No description provided for @calendarLegendUsage.
  ///
  /// In th, this message translates to:
  /// **'ใช้สินค้า'**
  String get calendarLegendUsage;

  /// No description provided for @daySummaryNoLog.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีบันทึกผิววันนี้'**
  String get daySummaryNoLog;

  /// No description provided for @daySummaryProducts.
  ///
  /// In th, this message translates to:
  /// **'สินค้าที่ใช้'**
  String get daySummaryProducts;

  /// No description provided for @daySummaryNoProducts.
  ///
  /// In th, this message translates to:
  /// **'ไม่ได้บันทึกการใช้สินค้า'**
  String get daySummaryNoProducts;

  /// No description provided for @daySummaryTimes.
  ///
  /// In th, this message translates to:
  /// **'{count} ครั้ง'**
  String daySummaryTimes(int count);

  /// No description provided for @daySummaryEdit.
  ///
  /// In th, this message translates to:
  /// **'แก้ไขบันทึกวันนี้'**
  String get daySummaryEdit;

  /// No description provided for @daySummaryPhotos.
  ///
  /// In th, this message translates to:
  /// **'รูปถ่าย'**
  String get daySummaryPhotos;

  /// No description provided for @chartRange30.
  ///
  /// In th, this message translates to:
  /// **'30 วัน'**
  String get chartRange30;

  /// No description provided for @chartRange90.
  ///
  /// In th, this message translates to:
  /// **'90 วัน'**
  String get chartRange90;

  /// No description provided for @chartRange180.
  ///
  /// In th, this message translates to:
  /// **'6 เดือน'**
  String get chartRange180;

  /// No description provided for @chartEmpty.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีคะแนนผิวในช่วงนี้ ลองบันทึกผิวทุกวันดูนะ'**
  String get chartEmpty;

  /// No description provided for @chartMarkers.
  ///
  /// In th, this message translates to:
  /// **'เริ่มใช้ / ใช้หมด'**
  String get chartMarkers;

  /// No description provided for @chartMarkerStart.
  ///
  /// In th, this message translates to:
  /// **'เริ่มใช้ {name}'**
  String chartMarkerStart(String name);

  /// No description provided for @chartMarkerEnd.
  ///
  /// In th, this message translates to:
  /// **'ใช้หมด {name}'**
  String chartMarkerEnd(String name);

  /// No description provided for @searchPrompt.
  ///
  /// In th, this message translates to:
  /// **'เลือกอาการหรือปัจจัย เพื่อดูว่าวันนั้นและ 3 วันก่อนหน้าใช้อะไรไปบ้าง'**
  String get searchPrompt;

  /// No description provided for @searchNoDays.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีวันที่ติดแท็กนี้'**
  String get searchNoDays;

  /// No description provided for @searchDaysFound.
  ///
  /// In th, this message translates to:
  /// **'พบ {count} วัน'**
  String searchDaysFound(int count);

  /// No description provided for @searchRecentProducts.
  ///
  /// In th, this message translates to:
  /// **'ใช้ในช่วง 3 วันก่อน'**
  String get searchRecentProducts;

  /// No description provided for @spendingThisMonth.
  ///
  /// In th, this message translates to:
  /// **'เดือนนี้'**
  String get spendingThisMonth;

  /// No description provided for @spendingSixMonths.
  ///
  /// In th, this message translates to:
  /// **'6 เดือนล่าสุด'**
  String get spendingSixMonths;

  /// No description provided for @spendingPerMonth.
  ///
  /// In th, this message translates to:
  /// **'ค่าใช้จ่ายต่อเดือน'**
  String get spendingPerMonth;

  /// No description provided for @spendingNote.
  ///
  /// In th, this message translates to:
  /// **'นับตามวันที่ซื้อ (หรือวันที่เปิดใช้) ไม่รวมรายการอยากได้'**
  String get spendingNote;

  /// No description provided for @spendingValue.
  ///
  /// In th, this message translates to:
  /// **'ความคุ้มค่าต่อสินค้า'**
  String get spendingValue;

  /// No description provided for @spendingValueHint.
  ///
  /// In th, this message translates to:
  /// **'เรียงจากบาทต่อครั้งถูกสุด'**
  String get spendingValueHint;

  /// No description provided for @spendingNoProducts.
  ///
  /// In th, this message translates to:
  /// **'ใส่ราคาสินค้าเพื่อดูสรุปค่าใช้จ่าย'**
  String get spendingNoProducts;

  /// No description provided for @perUseShort.
  ///
  /// In th, this message translates to:
  /// **'{price}/ครั้ง'**
  String perUseShort(String price);

  /// No description provided for @settingsLanguage.
  ///
  /// In th, this message translates to:
  /// **'ภาษา'**
  String get settingsLanguage;

  /// No description provided for @languageThai.
  ///
  /// In th, this message translates to:
  /// **'ไทย'**
  String get languageThai;

  /// No description provided for @languageEnglish.
  ///
  /// In th, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @settingsPrivacy.
  ///
  /// In th, this message translates to:
  /// **'ความเป็นส่วนตัว'**
  String get settingsPrivacy;

  /// No description provided for @settingsAppLock.
  ///
  /// In th, this message translates to:
  /// **'ล็อกแอพ'**
  String get settingsAppLock;

  /// No description provided for @settingsAppLockHint.
  ///
  /// In th, this message translates to:
  /// **'ใช้ลายนิ้วมือ ใบหน้า หรือรหัสของเครื่องเพื่อเปิดแอพ'**
  String get settingsAppLockHint;

  /// No description provided for @settingsAppLockUnavailable.
  ///
  /// In th, this message translates to:
  /// **'เครื่องนี้ยังไม่ได้ตั้งรหัสหรือไบโอเมตริก'**
  String get settingsAppLockUnavailable;

  /// No description provided for @settingsSecureScreen.
  ///
  /// In th, this message translates to:
  /// **'ป้องกันการแคปหน้าจอ'**
  String get settingsSecureScreen;

  /// No description provided for @settingsSecureScreenHint.
  ///
  /// In th, this message translates to:
  /// **'กันการแคปหรืออัดหน้าจอแอพ (Android)'**
  String get settingsSecureScreenHint;

  /// No description provided for @settingsData.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลและการสำรอง'**
  String get settingsData;

  /// No description provided for @backupExport.
  ///
  /// In th, this message translates to:
  /// **'สำรองข้อมูล (Export)'**
  String get backupExport;

  /// No description provided for @backupExportHint.
  ///
  /// In th, this message translates to:
  /// **'สร้างไฟล์ .zip รวมข้อมูลและรูปทั้งหมด แล้วเลือกเก็บไว้ที่ไหนก็ได้'**
  String get backupExportHint;

  /// No description provided for @backupImport.
  ///
  /// In th, this message translates to:
  /// **'กู้คืนข้อมูล (Import)'**
  String get backupImport;

  /// No description provided for @backupImportHint.
  ///
  /// In th, this message translates to:
  /// **'เลือกไฟล์สำรอง .zip เพื่อนำข้อมูลกลับมา'**
  String get backupImportHint;

  /// No description provided for @backupLast.
  ///
  /// In th, this message translates to:
  /// **'สำรองล่าสุด {date}'**
  String backupLast(String date);

  /// No description provided for @backupNever.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่เคยสำรองข้อมูล'**
  String get backupNever;

  /// No description provided for @backupReminders.
  ///
  /// In th, this message translates to:
  /// **'เตือนให้สำรองข้อมูลทุกเดือน'**
  String get backupReminders;

  /// No description provided for @backupWorking.
  ///
  /// In th, this message translates to:
  /// **'กำลังเตรียมไฟล์สำรอง…'**
  String get backupWorking;

  /// No description provided for @backupRestoring.
  ///
  /// In th, this message translates to:
  /// **'กำลังกู้คืนข้อมูล…'**
  String get backupRestoring;

  /// No description provided for @backupShareSubject.
  ///
  /// In th, this message translates to:
  /// **'ไฟล์สำรอง Very Beauty'**
  String get backupShareSubject;

  /// No description provided for @backupDone.
  ///
  /// In th, this message translates to:
  /// **'สำรองข้อมูลแล้ว'**
  String get backupDone;

  /// No description provided for @backupFailed.
  ///
  /// In th, this message translates to:
  /// **'สำรองข้อมูลไม่สำเร็จ: {error}'**
  String backupFailed(String error);

  /// No description provided for @restoreConfirmTitle.
  ///
  /// In th, this message translates to:
  /// **'กู้คืนข้อมูลจากไฟล์นี้?'**
  String get restoreConfirmTitle;

  /// No description provided for @restoreConfirmBody.
  ///
  /// In th, this message translates to:
  /// **'ไฟล์สำรองวันที่ {date} มีรูป {count} รูป\n\nข้อมูลและรูปทั้งหมดในเครื่องตอนนี้จะถูกแทนที่ และย้อนกลับไม่ได้'**
  String restoreConfirmBody(String date, int count);

  /// No description provided for @restoreAction.
  ///
  /// In th, this message translates to:
  /// **'แทนที่ด้วยข้อมูลสำรอง'**
  String get restoreAction;

  /// No description provided for @restoreDone.
  ///
  /// In th, this message translates to:
  /// **'กู้คืนข้อมูลเรียบร้อย'**
  String get restoreDone;

  /// No description provided for @restoreNotBackup.
  ///
  /// In th, this message translates to:
  /// **'ไฟล์นี้ไม่ใช่ไฟล์สำรองของ Very Beauty'**
  String get restoreNotBackup;

  /// No description provided for @restoreNewer.
  ///
  /// In th, this message translates to:
  /// **'ไฟล์สำรองนี้มาจากแอพเวอร์ชันใหม่กว่า ({version}) อัปเดตแอพก่อนนะ'**
  String restoreNewer(String version);

  /// No description provided for @restoreCorrupt.
  ///
  /// In th, this message translates to:
  /// **'ไฟล์สำรองเสียหาย ข้อมูลเดิมยังอยู่ครบ'**
  String get restoreCorrupt;

  /// No description provided for @alertBackupDue.
  ///
  /// In th, this message translates to:
  /// **'ไม่ได้สำรองข้อมูลมา {days} วัน'**
  String alertBackupDue(int days);

  /// No description provided for @lockTitle.
  ///
  /// In th, this message translates to:
  /// **'Very Beauty ถูกล็อกไว้'**
  String get lockTitle;

  /// No description provided for @lockUnlock.
  ///
  /// In th, this message translates to:
  /// **'ปลดล็อก'**
  String get lockUnlock;

  /// No description provided for @lockReason.
  ///
  /// In th, this message translates to:
  /// **'ยืนยันตัวตนเพื่อเปิด Very Beauty'**
  String get lockReason;

  /// No description provided for @lockEnableReason.
  ///
  /// In th, this message translates to:
  /// **'ยืนยันตัวตนเพื่อเปิดใช้การล็อกแอพ'**
  String get lockEnableReason;

  /// No description provided for @settingsUpdates.
  ///
  /// In th, this message translates to:
  /// **'อัปเดต'**
  String get settingsUpdates;

  /// No description provided for @updateCheck.
  ///
  /// In th, this message translates to:
  /// **'ตรวจสอบอัปเดต'**
  String get updateCheck;

  /// No description provided for @updateCurrent.
  ///
  /// In th, this message translates to:
  /// **'เวอร์ชันปัจจุบัน {version}'**
  String updateCurrent(String version);

  /// No description provided for @updateAuto.
  ///
  /// In th, this message translates to:
  /// **'ตรวจอัปเดตอัตโนมัติวันละครั้ง'**
  String get updateAuto;

  /// No description provided for @updateAutoHint.
  ///
  /// In th, this message translates to:
  /// **'เชื่อมต่อ GitHub เพื่อดูเวอร์ชันล่าสุดเท่านั้น ไม่ส่งข้อมูลของคุณ'**
  String get updateAutoHint;

  /// No description provided for @updateChecking.
  ///
  /// In th, this message translates to:
  /// **'กำลังตรวจสอบ…'**
  String get updateChecking;

  /// No description provided for @updateNone.
  ///
  /// In th, this message translates to:
  /// **'เป็นเวอร์ชันล่าสุดแล้ว (หรือยังเชื่อมต่อไม่ได้)'**
  String get updateNone;

  /// No description provided for @updateAvailableTitle.
  ///
  /// In th, this message translates to:
  /// **'มีเวอร์ชันใหม่ ✨'**
  String get updateAvailableTitle;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In th, this message translates to:
  /// **'ต้องอัปเดตก่อนใช้งานต่อ'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredBody.
  ///
  /// In th, this message translates to:
  /// **'เวอร์ชันนี้เก่าเกินไปสำหรับข้อมูลรูปแบบใหม่'**
  String get updateRequiredBody;

  /// No description provided for @updateKeepsData.
  ///
  /// In th, this message translates to:
  /// **'ดาวน์โหลดไฟล์ติดตั้งแล้วแตะเพื่ออัปเดต ข้อมูลยังอยู่ครบ (ถ้าแอพเซ็นด้วยกุญแจเดียวกัน) แนะนำให้สำรองข้อมูลก่อน'**
  String get updateKeepsData;

  /// No description provided for @updateDownload.
  ///
  /// In th, this message translates to:
  /// **'ดาวน์โหลด'**
  String get updateDownload;

  /// No description provided for @updateLater.
  ///
  /// In th, this message translates to:
  /// **'ภายหลัง'**
  String get updateLater;

  /// No description provided for @ingFnSurfactant.
  ///
  /// In th, this message translates to:
  /// **'สารทำความสะอาด'**
  String get ingFnSurfactant;

  /// No description provided for @ingFnUvChemical.
  ///
  /// In th, this message translates to:
  /// **'สารกันแดด (เคมี)'**
  String get ingFnUvChemical;

  /// No description provided for @ingFnUvMineral.
  ///
  /// In th, this message translates to:
  /// **'สารกันแดด (แร่)'**
  String get ingFnUvMineral;

  /// No description provided for @ingFnHumectant.
  ///
  /// In th, this message translates to:
  /// **'ดึงความชุ่มชื้น'**
  String get ingFnHumectant;

  /// No description provided for @ingFnEmollient.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มความนุ่มชุ่มชื่น'**
  String get ingFnEmollient;

  /// No description provided for @ingFnOcclusive.
  ///
  /// In th, this message translates to:
  /// **'เคลือบกักความชุ่มชื้น'**
  String get ingFnOcclusive;

  /// No description provided for @ingFnBarrier.
  ///
  /// In th, this message translates to:
  /// **'ฟื้นฟูเกราะผิว'**
  String get ingFnBarrier;

  /// No description provided for @ingFnBrightening.
  ///
  /// In th, this message translates to:
  /// **'ผิวกระจ่างใส'**
  String get ingFnBrightening;

  /// No description provided for @ingFnAntioxidant.
  ///
  /// In th, this message translates to:
  /// **'ต้านอนุมูลอิสระ'**
  String get ingFnAntioxidant;

  /// No description provided for @ingFnExfoliant.
  ///
  /// In th, this message translates to:
  /// **'ผลัดเซลล์ผิว'**
  String get ingFnExfoliant;

  /// No description provided for @ingFnAntiAcne.
  ///
  /// In th, this message translates to:
  /// **'ลดสิว'**
  String get ingFnAntiAcne;

  /// No description provided for @ingFnRetinoid.
  ///
  /// In th, this message translates to:
  /// **'เรตินอยด์'**
  String get ingFnRetinoid;

  /// No description provided for @ingFnAntiAging.
  ///
  /// In th, this message translates to:
  /// **'ลดริ้วรอย'**
  String get ingFnAntiAging;

  /// No description provided for @ingFnSoothing.
  ///
  /// In th, this message translates to:
  /// **'ปลอบประโลมผิว'**
  String get ingFnSoothing;

  /// No description provided for @ingFnAbsorbent.
  ///
  /// In th, this message translates to:
  /// **'ดูดซับความมัน'**
  String get ingFnAbsorbent;

  /// No description provided for @ingFnFilmFormer.
  ///
  /// In th, this message translates to:
  /// **'สร้างฟิล์มบนผิว'**
  String get ingFnFilmFormer;

  /// No description provided for @ingFnEmulsifier.
  ///
  /// In th, this message translates to:
  /// **'ผสานน้ำกับน้ำมัน'**
  String get ingFnEmulsifier;

  /// No description provided for @ingFnThickener.
  ///
  /// In th, this message translates to:
  /// **'ปรับเนื้อสัมผัส'**
  String get ingFnThickener;

  /// No description provided for @ingFnPreservative.
  ///
  /// In th, this message translates to:
  /// **'สารกันเสีย'**
  String get ingFnPreservative;

  /// No description provided for @ingFnChelating.
  ///
  /// In th, this message translates to:
  /// **'จับโลหะ (คีเลต)'**
  String get ingFnChelating;

  /// No description provided for @ingFnPhAdjuster.
  ///
  /// In th, this message translates to:
  /// **'ปรับค่า pH'**
  String get ingFnPhAdjuster;

  /// No description provided for @ingFnSolvent.
  ///
  /// In th, this message translates to:
  /// **'ตัวทำละลาย'**
  String get ingFnSolvent;

  /// No description provided for @ingFnFragrance.
  ///
  /// In th, this message translates to:
  /// **'น้ำหอม/กลิ่น'**
  String get ingFnFragrance;

  /// No description provided for @ingFnOther.
  ///
  /// In th, this message translates to:
  /// **'อื่นๆ'**
  String get ingFnOther;

  /// No description provided for @ingredientsSearchHint.
  ///
  /// In th, this message translates to:
  /// **'เช่น ไนอะซินาไมด์, zinc oxide'**
  String get ingredientsSearchHint;

  /// No description provided for @ingredientsCommonIn.
  ///
  /// In th, this message translates to:
  /// **'พบบ่อยใน{category} · แตะเพื่อเพิ่ม'**
  String ingredientsCommonIn(String category);

  /// No description provided for @ingredientsAddCustom.
  ///
  /// In th, this message translates to:
  /// **'เพิ่ม “{name}”'**
  String ingredientsAddCustom(String name);

  /// No description provided for @ingredientsCustomSubtitle.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีในฐานข้อมูล'**
  String get ingredientsCustomSubtitle;

  /// No description provided for @ingredientsUsedBefore.
  ///
  /// In th, this message translates to:
  /// **'เคยใช้ในสินค้าอื่น'**
  String get ingredientsUsedBefore;

  /// No description provided for @ingredientsUnknown.
  ///
  /// In th, this message translates to:
  /// **'ส่วนผสมนี้ยังไม่มีในฐานข้อมูลของแอพ'**
  String get ingredientsUnknown;

  /// No description provided for @ingredientsTitle.
  ///
  /// In th, this message translates to:
  /// **'ฐานข้อมูลส่วนผสม'**
  String get ingredientsTitle;

  /// No description provided for @ingredientsCount.
  ///
  /// In th, this message translates to:
  /// **'{count} รายการ'**
  String ingredientsCount(int count);

  /// No description provided for @ingredientsAlsoKnownAs.
  ///
  /// In th, this message translates to:
  /// **'ชื่ออื่น'**
  String get ingredientsAlsoKnownAs;

  /// No description provided for @ingredientsTypicalIn.
  ///
  /// In th, this message translates to:
  /// **'พบบ่อยใน'**
  String get ingredientsTypicalIn;

  /// No description provided for @ingredientsCaution.
  ///
  /// In th, this message translates to:
  /// **'ควรรู้'**
  String get ingredientsCaution;

  /// No description provided for @ingredientsNoMatch.
  ///
  /// In th, this message translates to:
  /// **'ไม่พบส่วนผสมที่ค้นหา'**
  String get ingredientsNoMatch;

  /// No description provided for @ingredientsDisclaimer.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลทั่วไปเพื่อประกอบการเลือกใช้ ไม่ใช่คำแนะนำทางการแพทย์'**
  String get ingredientsDisclaimer;

  /// No description provided for @ingredientsFilterAll.
  ///
  /// In th, this message translates to:
  /// **'ทุกหน้าที่'**
  String get ingredientsFilterAll;

  /// No description provided for @fieldEmptyWeightAuto.
  ///
  /// In th, this message translates to:
  /// **'เว้นว่างได้ — คำนวณให้: {start} − {net} = {packaging} กรัม'**
  String fieldEmptyWeightAuto(String start, String net, String packaging);

  /// No description provided for @packagingCalculated.
  ///
  /// In th, this message translates to:
  /// **'{grams} (คำนวณ)'**
  String packagingCalculated(String grams);

  /// No description provided for @statPackaging.
  ///
  /// In th, this message translates to:
  /// **'บรรจุภัณฑ์ {grams} กรัม'**
  String statPackaging(String grams);

  /// No description provided for @weighPackagingPreview.
  ///
  /// In th, this message translates to:
  /// **'บรรจุภัณฑ์ ≈ {packaging} กรัม ({total} − ปริมาณสุทธิ {net})'**
  String weighPackagingPreview(String packaging, String total, String net);

  /// No description provided for @weighRemainingPreview.
  ///
  /// In th, this message translates to:
  /// **'เหลือ {grams} กรัม ({percent}%)'**
  String weighRemainingPreview(String grams, String percent);

  /// No description provided for @weighMlNote.
  ///
  /// In th, this message translates to:
  /// **'สินค้าหน่วย มล. คิดประมาณ 1 มล. ≈ 1 กรัม'**
  String get weighMlNote;

  /// No description provided for @ingFnColorant.
  ///
  /// In th, this message translates to:
  /// **'สี/เม็ดสี'**
  String get ingFnColorant;

  /// No description provided for @ingredientWhat.
  ///
  /// In th, this message translates to:
  /// **'คืออะไร'**
  String get ingredientWhat;

  /// No description provided for @ingredientGood.
  ///
  /// In th, this message translates to:
  /// **'ช่วยอะไร'**
  String get ingredientGood;

  /// No description provided for @ingredientTips.
  ///
  /// In th, this message translates to:
  /// **'วิธีใช้และเคล็ดลับ'**
  String get ingredientTips;

  /// No description provided for @ingredientAbout.
  ///
  /// In th, this message translates to:
  /// **'ข้อมูลโดยย่อ'**
  String get ingredientAbout;

  /// No description provided for @ingredientStructure.
  ///
  /// In th, this message translates to:
  /// **'โครงสร้างทางเคมี'**
  String get ingredientStructure;

  /// No description provided for @ingredientFormula.
  ///
  /// In th, this message translates to:
  /// **'สูตรโมเลกุล {formula}'**
  String ingredientFormula(String formula);

  /// No description provided for @ingredientMw.
  ///
  /// In th, this message translates to:
  /// **'มวลโมเลกุล {mw} g/mol'**
  String ingredientMw(String mw);

  /// No description provided for @ingredientZoomHint.
  ///
  /// In th, this message translates to:
  /// **'จีบนิ้วเพื่อซูม · แสดงโครงสร้างแบบเส้น (มุมคือคาร์บอน)'**
  String get ingredientZoomHint;

  /// No description provided for @ingredientKindPolymer.
  ///
  /// In th, this message translates to:
  /// **'เป็นพอลิเมอร์ (โมเลกุลสายยาวที่ต่อกันซ้ำๆ หลายขนาด) จึงไม่มีโครงสร้างเดียว'**
  String get ingredientKindPolymer;

  /// No description provided for @ingredientKindExtract.
  ///
  /// In th, this message translates to:
  /// **'เป็นสารสกัดจากธรรมชาติ ประกอบด้วยสารหลายชนิดรวมกัน'**
  String get ingredientKindExtract;

  /// No description provided for @ingredientKindOil.
  ///
  /// In th, this message translates to:
  /// **'เป็นน้ำมัน/ไขมันธรรมชาติ ประกอบด้วยไตรกลีเซอไรด์ของกรดไขมันหลายชนิด'**
  String get ingredientKindOil;

  /// No description provided for @ingredientKindMixture.
  ///
  /// In th, this message translates to:
  /// **'เป็นสารผสมของโมเลกุลหลายขนาด (เช่น กรดไขมันจากมะพร้าวที่ยาวไม่เท่ากัน)'**
  String get ingredientKindMixture;

  /// No description provided for @ingredientKindMineral.
  ///
  /// In th, this message translates to:
  /// **'เป็นแร่หรือสารอนินทรีย์ที่อยู่ในรูปผลึก ไม่ใช่โมเลกุลเดี่ยว'**
  String get ingredientKindMineral;

  /// No description provided for @ingredientKindProtein.
  ///
  /// In th, this message translates to:
  /// **'เป็นโปรตีนหรือเอนไซม์ขนาดใหญ่'**
  String get ingredientKindProtein;

  /// No description provided for @ingredientKindFerment.
  ///
  /// In th, this message translates to:
  /// **'เป็นผลิตภัณฑ์จากการหมักจุลินทรีย์ มีสารหลายชนิดรวมกัน'**
  String get ingredientKindFerment;

  /// No description provided for @ingredientKindPeptide.
  ///
  /// In th, this message translates to:
  /// **'เป็นเปปไทด์ (กรดอะมิโนหลายตัวต่อกัน) โมเลกุลใหญ่เกินกว่าจะแสดงชัดบนจอ'**
  String get ingredientKindPeptide;

  /// No description provided for @ingredientKindUnknown.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่มีข้อมูลโครงสร้างของสารนี้'**
  String get ingredientKindUnknown;

  /// No description provided for @ingredientMyProducts.
  ///
  /// In th, this message translates to:
  /// **'สินค้าของฉันที่มีส่วนผสมนี้'**
  String get ingredientMyProducts;

  /// No description provided for @ingredientFunctions.
  ///
  /// In th, this message translates to:
  /// **'หน้าที่'**
  String get ingredientFunctions;

  /// No description provided for @ingFnAboutSurfactant.
  ///
  /// In th, this message translates to:
  /// **'สารลดแรงตึงผิวที่จับทั้งน้ำและน้ำมัน ทำให้คราบมัน เครื่องสำอาง และสิ่งสกปรกหลุดออกไปกับน้ำ'**
  String get ingFnAboutSurfactant;

  /// No description provided for @ingFnAboutUvChemical.
  ///
  /// In th, this message translates to:
  /// **'ดูดซับรังสี UV แล้วเปลี่ยนเป็นพลังงานความร้อนเล็กน้อย ป้องกันผิวไหม้ ฝ้า และผิวแก่ก่อนวัย'**
  String get ingFnAboutUvChemical;

  /// No description provided for @ingFnAboutUvMineral.
  ///
  /// In th, this message translates to:
  /// **'อนุภาคแร่ที่สะท้อน กระจาย และดูดซับรังสี UV บนผิว อ่อนโยน เหมาะกับผิวแพ้ง่าย'**
  String get ingFnAboutUvMineral;

  /// No description provided for @ingFnAboutHumectant.
  ///
  /// In th, this message translates to:
  /// **'ดึงน้ำจากอากาศและชั้นผิวด้านล่างมากักเก็บไว้ที่ผิวชั้นบน ทำให้ผิวอิ่มน้ำ'**
  String get ingFnAboutHumectant;

  /// No description provided for @ingFnAboutEmollient.
  ///
  /// In th, this message translates to:
  /// **'เติมช่องว่างระหว่างเซลล์ผิวที่แห้งลอก ทำให้ผิวเรียบ นุ่ม ลื่น'**
  String get ingFnAboutEmollient;

  /// No description provided for @ingFnAboutOcclusive.
  ///
  /// In th, this message translates to:
  /// **'สร้างชั้นเคลือบบนผิว ลดการระเหยของน้ำ เหมาะทาเป็นขั้นตอนสุดท้าย'**
  String get ingFnAboutOcclusive;

  /// No description provided for @ingFnAboutBarrier.
  ///
  /// In th, this message translates to:
  /// **'เป็นไขมันหรือสารที่ผิวใช้สร้างเกราะป้องกัน ช่วยซ่อมแซมผิวที่แห้ง แดง แสบง่าย'**
  String get ingFnAboutBarrier;

  /// No description provided for @ingFnAboutBrightening.
  ///
  /// In th, this message translates to:
  /// **'ลดการสร้างหรือการกระจายของเม็ดสี ช่วยให้จุดด่างดำจางและสีผิวสม่ำเสมอ'**
  String get ingFnAboutBrightening;

  /// No description provided for @ingFnAboutAntioxidant.
  ///
  /// In th, this message translates to:
  /// **'ดักจับอนุมูลอิสระจากแสงแดดและมลภาวะ ช่วยชะลอริ้วรอยและจุดด่างดำ หรือปกป้องสูตรไม่ให้เสื่อม'**
  String get ingFnAboutAntioxidant;

  /// No description provided for @ingFnAboutExfoliant.
  ///
  /// In th, this message translates to:
  /// **'ช่วยให้เซลล์ผิวเก่าหลุดออก ผิวเรียบ กระจ่างใส ไม่หมองคล้ำ'**
  String get ingFnAboutExfoliant;

  /// No description provided for @ingFnAboutAntiAcne.
  ///
  /// In th, this message translates to:
  /// **'ช่วยลดสิวโดยลดเชื้อแบคทีเรีย ความมัน หรือการอุดตันของรูขุมขน'**
  String get ingFnAboutAntiAcne;

  /// No description provided for @ingFnAboutRetinoid.
  ///
  /// In th, this message translates to:
  /// **'อนุพันธ์วิตามินเอที่เร่งการผลัดเซลล์และสร้างคอลลาเจน ลดริ้วรอยและสิว'**
  String get ingFnAboutRetinoid;

  /// No description provided for @ingFnAboutAntiAging.
  ///
  /// In th, this message translates to:
  /// **'ช่วยลดเลือนริ้วรอยหรือกระตุ้นการสร้างคอลลาเจน ทำให้ผิวกระชับ'**
  String get ingFnAboutAntiAging;

  /// No description provided for @ingFnAboutSoothing.
  ///
  /// In th, this message translates to:
  /// **'ลดการระคายเคือง รอยแดง และอาการแสบคัน ช่วยให้ผิวสงบ'**
  String get ingFnAboutSoothing;

  /// No description provided for @ingFnAboutAbsorbent.
  ///
  /// In th, this message translates to:
  /// **'ดูดซับความมันหรือความชื้นส่วนเกิน ให้ผิวดูแมตต์และเนียน'**
  String get ingFnAboutAbsorbent;

  /// No description provided for @ingFnAboutFilmFormer.
  ///
  /// In th, this message translates to:
  /// **'สร้างฟิล์มบางๆ บนผิว ช่วยให้ผลิตภัณฑ์ติดทน กันน้ำ หรือให้ความรู้สึกเรียบตึง'**
  String get ingFnAboutFilmFormer;

  /// No description provided for @ingFnAboutEmulsifier.
  ///
  /// In th, this message translates to:
  /// **'ทำให้น้ำกับน้ำมันผสมกันเป็นเนื้อครีม/โลชั่นที่ไม่แยกชั้น'**
  String get ingFnAboutEmulsifier;

  /// No description provided for @ingFnAboutThickener.
  ///
  /// In th, this message translates to:
  /// **'ปรับความข้นหนืดและเนื้อสัมผัสของผลิตภัณฑ์ให้ใช้ง่ายและคงตัว'**
  String get ingFnAboutThickener;

  /// No description provided for @ingFnAboutPreservative.
  ///
  /// In th, this message translates to:
  /// **'ป้องกันเชื้อโรคและเชื้อราในผลิตภัณฑ์ ทำให้ใช้ได้อย่างปลอดภัยจนหมด'**
  String get ingFnAboutPreservative;

  /// No description provided for @ingFnAboutChelating.
  ///
  /// In th, this message translates to:
  /// **'จับแร่ธาตุโลหะในน้ำ ช่วยให้สูตรคงตัว ไม่เปลี่ยนสีหรือกลิ่น'**
  String get ingFnAboutChelating;

  /// No description provided for @ingFnAboutPhAdjuster.
  ///
  /// In th, this message translates to:
  /// **'ปรับความเป็นกรด-ด่างของสูตรให้เหมาะกับผิวและสารสำคัญ'**
  String get ingFnAboutPhAdjuster;

  /// No description provided for @ingFnAboutSolvent.
  ///
  /// In th, this message translates to:
  /// **'ตัวทำละลายที่ช่วยละลายส่วนผสมอื่นและกำหนดเนื้อสัมผัสของสูตร'**
  String get ingFnAboutSolvent;

  /// No description provided for @ingFnAboutFragrance.
  ///
  /// In th, this message translates to:
  /// **'ให้กลิ่นหอมแก่ผลิตภัณฑ์ ไม่ได้บำรุงผิวโดยตรง และอาจก่อการแพ้ได้'**
  String get ingFnAboutFragrance;

  /// No description provided for @ingFnAboutColorant.
  ///
  /// In th, this message translates to:
  /// **'ให้สีกับผลิตภัณฑ์หรือผิว เช่น เม็ดสีในรองพื้นหรือกันแดดสีเนื้อ'**
  String get ingFnAboutColorant;

  /// No description provided for @ingFnAboutOther.
  ///
  /// In th, this message translates to:
  /// **'มีบทบาทเฉพาะในสูตร เช่น ทำให้เย็น ให้ประกาย หรือช่วยให้สารอื่นคงตัว'**
  String get ingFnAboutOther;

  /// No description provided for @ingredientRoles.
  ///
  /// In th, this message translates to:
  /// **'หน้าที่ในสูตร'**
  String get ingredientRoles;

  /// No description provided for @updateNow.
  ///
  /// In th, this message translates to:
  /// **'อัปเดตเลย'**
  String get updateNow;

  /// No description provided for @updateInAppBody.
  ///
  /// In th, this message translates to:
  /// **'กด \"อัปเดตเลย\" แอปจะดาวน์โหลดและติดตั้งเวอร์ชันใหม่ให้เอง ข้อมูลทั้งหมดยังอยู่ครบ'**
  String get updateInAppBody;

  /// No description provided for @updateDownloading.
  ///
  /// In th, this message translates to:
  /// **'กำลังดาวน์โหลดอัปเดต…'**
  String get updateDownloading;

  /// No description provided for @updateInstalling.
  ///
  /// In th, this message translates to:
  /// **'กำลังติดตั้ง… แอปจะปิดลงเมื่อเสร็จ แตะการแจ้งเตือนเพื่อเปิดอีกครั้ง'**
  String get updateInstalling;

  /// No description provided for @updatePermissionTitle.
  ///
  /// In th, this message translates to:
  /// **'อนุญาตให้ Very Beauty ติดตั้งอัปเดต'**
  String get updatePermissionTitle;

  /// No description provided for @updatePermissionBody.
  ///
  /// In th, this message translates to:
  /// **'ทำแค่ครั้งเดียว: เปิดสวิตช์ \"อนุญาตจากแหล่งที่มานี้\" แล้วกดย้อนกลับมาที่แอป'**
  String get updatePermissionBody;

  /// No description provided for @updatePermissionOpen.
  ///
  /// In th, this message translates to:
  /// **'ไปที่การตั้งค่า'**
  String get updatePermissionOpen;

  /// No description provided for @updatePermissionMissing.
  ///
  /// In th, this message translates to:
  /// **'ยังไม่ได้อนุญาต ลองใหม่ได้ที่ ตั้งค่า → ตรวจสอบอัปเดต'**
  String get updatePermissionMissing;

  /// No description provided for @updateDownloadFailed.
  ///
  /// In th, this message translates to:
  /// **'ดาวน์โหลดไม่สำเร็จ ตรวจการเชื่อมต่อแล้วลองใหม่'**
  String get updateDownloadFailed;

  /// No description provided for @updateInstallFailed.
  ///
  /// In th, this message translates to:
  /// **'ติดตั้งไม่สำเร็จ ลองใหม่อีกครั้ง'**
  String get updateInstallFailed;

  /// No description provided for @updateCancelled.
  ///
  /// In th, this message translates to:
  /// **'ยกเลิกการอัปเดตแล้ว'**
  String get updateCancelled;

  /// No description provided for @updateSignatureTitle.
  ///
  /// In th, this message translates to:
  /// **'ต้องติดตั้งใหม่อีกครั้งสุดท้าย'**
  String get updateSignatureTitle;

  /// No description provided for @updateSignatureBody.
  ///
  /// In th, this message translates to:
  /// **'แอปที่ติดตั้งอยู่เป็นรุ่นที่เซ็นด้วยกุญแจชั่วคราว จึงอัปเดตทับไม่ได้ ให้กด \"สำรองข้อมูล\" ลบแอป แล้วติดตั้งไฟล์ใหม่และกู้คืนข้อมูล ครั้งต่อไปจะกดอัปเดตในแอปได้เลย'**
  String get updateSignatureBody;

  /// No description provided for @productPhotoAdd.
  ///
  /// In th, this message translates to:
  /// **'เพิ่มรูป'**
  String get productPhotoAdd;

  /// No description provided for @productPhotoCamera.
  ///
  /// In th, this message translates to:
  /// **'ถ่ายรูป'**
  String get productPhotoCamera;

  /// No description provided for @productPhotoGallery.
  ///
  /// In th, this message translates to:
  /// **'เลือกจากคลังภาพ'**
  String get productPhotoGallery;

  /// No description provided for @productPhotoRemove.
  ///
  /// In th, this message translates to:
  /// **'ลบรูป'**
  String get productPhotoRemove;

  /// No description provided for @productPhotoFailed.
  ///
  /// In th, this message translates to:
  /// **'เปิดรูปนี้ไม่ได้ ลองรูปอื่น'**
  String get productPhotoFailed;

  /// No description provided for @fieldCategoryMultiHint.
  ///
  /// In th, this message translates to:
  /// **'เลือกได้หลายหมวด · หมวดแรกเป็นหมวดหลัก ★'**
  String get fieldCategoryMultiHint;

  /// No description provided for @ingredientsMissing.
  ///
  /// In th, this message translates to:
  /// **'มี {count} ส่วนผสมในสินค้าของคุณที่ยังไม่มีข้อมูล'**
  String ingredientsMissing(int count);

  /// No description provided for @ingredientsMissingShow.
  ///
  /// In th, this message translates to:
  /// **'ดูรายชื่อ'**
  String get ingredientsMissingShow;

  /// No description provided for @ingredientsMissingTitle.
  ///
  /// In th, this message translates to:
  /// **'ส่วนผสมที่ยังไม่มีข้อมูล'**
  String get ingredientsMissingTitle;

  /// No description provided for @ingredientsMissingHint.
  ///
  /// In th, this message translates to:
  /// **'คัดลอกรายชื่อแล้วส่งให้ผู้พัฒนา เพื่อเพิ่มข้อมูลในเวอร์ชันถัดไป'**
  String get ingredientsMissingHint;

  /// No description provided for @ingredientsMissingCopy.
  ///
  /// In th, this message translates to:
  /// **'คัดลอกรายชื่อ'**
  String get ingredientsMissingCopy;

  /// No description provided for @ingredientsMissingCopied.
  ///
  /// In th, this message translates to:
  /// **'คัดลอกแล้ว'**
  String get ingredientsMissingCopied;

  /// No description provided for @ingredientsFix.
  ///
  /// In th, this message translates to:
  /// **'แก้ชื่อ'**
  String get ingredientsFix;

  /// No description provided for @ingredientsFixTitle.
  ///
  /// In th, this message translates to:
  /// **'แก้ชื่อ “{name}”'**
  String ingredientsFixTitle(String name);

  /// No description provided for @ingredientsFixHint.
  ///
  /// In th, this message translates to:
  /// **'เลือกชื่อที่ถูกต้อง ระบบจะแก้ให้ในทุกสินค้าที่ใช้ชื่อนี้'**
  String get ingredientsFixHint;

  /// No description provided for @ingredientsDidYouMean.
  ///
  /// In th, this message translates to:
  /// **'หมายถึง {name} ไหม?'**
  String ingredientsDidYouMean(String name);

  /// No description provided for @ingredientsFixed.
  ///
  /// In th, this message translates to:
  /// **'แก้เป็น {name} แล้ว'**
  String ingredientsFixed(String name);
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

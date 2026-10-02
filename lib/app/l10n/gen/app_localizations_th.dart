// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Very Beauty';

  @override
  String get navToday => 'วันนี้';

  @override
  String get navProducts => 'สินค้า';

  @override
  String get navPhotos => 'รูปถ่าย';

  @override
  String get navInsights => 'สรุป';

  @override
  String get navSettings => 'ตั้งค่า';

  @override
  String get comingSoon => 'กำลังพัฒนา — จะมาในเฟสถัดไป';

  @override
  String get todayGreeting => 'วันนี้ดูแลผิวแล้วหรือยัง?';

  @override
  String get settingsAppearance => 'รูปลักษณ์';

  @override
  String get settingsTheme => 'ธีม';

  @override
  String get themeSystem => 'ตามระบบ';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get settingsAbout => 'เกี่ยวกับแอพ';

  @override
  String aboutVersion(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get aboutDisclaimerTitle => 'ข้อควรทราบ';

  @override
  String get aboutDisclaimer =>
      'Very Beauty เป็นเครื่องมือช่วยบันทึกการดูแลผิวส่วนตัวเท่านั้น ไม่ใช่เครื่องมือวินิจฉัยหรือรักษาทางการแพทย์ หากมีอาการผิวผิดปกติ ควรปรึกษาแพทย์ผิวหนัง';

  @override
  String get aboutPrivacyTitle => 'ความเป็นส่วนตัว';

  @override
  String get aboutPrivacy =>
      'ข้อมูลและรูปถ่ายทั้งหมดถูกเก็บไว้ในเครื่องของคุณเท่านั้น แอพไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ และไม่มีระบบติดตามการใช้งาน\n\nการเชื่อมต่ออินเทอร์เน็ตเพียงอย่างเดียวคือการตรวจสอบเวอร์ชันใหม่จาก GitHub (ปิดได้ในการตั้งค่า) ซึ่งไม่ส่งข้อมูลใดๆ ของคุณออกไป';

  @override
  String get todayHello => 'สวัสดีค่ะ';

  @override
  String get todayHeroSubtitle => 'ดูแลผิวทีละนิด ให้สวยในแบบของคุณ';

  @override
  String get todayRoutinesTitle => 'รูทีนของวันนี้';

  @override
  String get routineNoSteps => 'ยังไม่มีขั้นตอน · เพิ่มสินค้าได้เร็วๆ นี้';

  @override
  String get todayQuickTitle => 'บันทึกด่วน';

  @override
  String get quickPhoto => 'ถ่ายรูปผิว';

  @override
  String get quickSkinLog => 'บันทึกสภาพผิว';

  @override
  String get productsEmptyTitle => 'ยังไม่มีสินค้า';

  @override
  String get productsEmptyBody =>
      'เก็บสกินแคร์ทุกขวด พร้อมราคา ปริมาณ และความคุ้มค่า';

  @override
  String get photosEmptyTitle => 'ยังไม่มีรูปถ่าย';

  @override
  String get photosEmptyBody =>
      'ถ่ายรูปผิวในมุมเดิมทุกครั้ง แล้วเทียบผลลัพธ์ตามเวลา';

  @override
  String get insightsEmptyTitle => 'ยังไม่มีข้อมูลสรุป';

  @override
  String get insightsEmptyBody =>
      'ปฏิทิน กราฟสภาพผิว และความคุ้มค่าจะแสดงที่นี่';

  @override
  String get comingSoonBadge => 'เร็วๆ นี้';

  @override
  String get settingsAppInfo => 'ข้อมูลแอพ';

  @override
  String get categoryCleanser => 'คลีนเซอร์';

  @override
  String get categoryToner => 'โทนเนอร์';

  @override
  String get categorySerum => 'เซรั่ม';

  @override
  String get categoryMoisturizer => 'มอยส์เจอไรเซอร์';

  @override
  String get categorySunscreen => 'กันแดด';

  @override
  String get categoryTreatment => 'ทรีตเมนต์';

  @override
  String get categoryMask => 'มาสก์';

  @override
  String get categoryOther => 'อื่นๆ';

  @override
  String get statusInUse => 'ใช้อยู่';

  @override
  String get statusFinished => 'ใช้หมดแล้ว';

  @override
  String get statusPaused => 'พักไว้';

  @override
  String get statusWishlist => 'อยากได้';

  @override
  String get unitG => 'กรัม';

  @override
  String get unitMl => 'มล.';

  @override
  String get filterAll => 'ทั้งหมด';

  @override
  String get productsSearchHint => 'ค้นหาชื่อหรือแบรนด์';

  @override
  String get productsAdd => 'เพิ่มสินค้า';

  @override
  String get productsNoMatch => 'ไม่พบสินค้าที่ตรงกับตัวกรอง';

  @override
  String get productFormNew => 'เพิ่มสินค้า';

  @override
  String get productFormEdit => 'แก้ไขสินค้า';

  @override
  String get fieldName => 'ชื่อสินค้า';

  @override
  String get fieldNameRequired => 'กรุณาใส่ชื่อสินค้า';

  @override
  String get fieldCategory => 'ประเภท';

  @override
  String get fieldPrice => 'ราคา (บาท)';

  @override
  String get fieldNetContent => 'ปริมาณสุทธิ';

  @override
  String get fieldMoreDetails => 'รายละเอียดเพิ่มเติม';

  @override
  String get fieldMoreDetailsHint => 'แบรนด์ วันที่เปิดใช้ น้ำหนัก ส่วนผสม ฯลฯ';

  @override
  String get fieldBrand => 'แบรนด์';

  @override
  String get fieldStatus => 'สถานะ';

  @override
  String get fieldPurchasePlace => 'ซื้อจากที่ไหน';

  @override
  String get fieldPurchaseDate => 'วันที่ซื้อ';

  @override
  String get fieldOpenedDate => 'วันที่เปิดใช้';

  @override
  String get fieldPao => 'อายุหลังเปิด (เดือน)';

  @override
  String get fieldExpiry => 'วันหมดอายุบนฉลาก';

  @override
  String get fieldStartWeight =>
      'น้ำหนักทั้งหมดตอนยังไม่ใช้ (กรัม รวมบรรจุภัณฑ์)';

  @override
  String get fieldEmptyWeight => 'น้ำหนักบรรจุภัณฑ์เปล่า (กรัม)';

  @override
  String get fieldEmptyWeightHelp =>
      'เว้นว่างได้ แอพจะคำนวณให้จาก น้ำหนักทั้งหมด − ปริมาณสุทธิ';

  @override
  String get fieldNote => 'โน้ต';

  @override
  String get fieldIngredients => 'ส่วนผสม';

  @override
  String get fieldIngredientsHelp =>
      'พิมพ์ชื่อไทยหรืออังกฤษแล้วเลือกจากรายการ หรือวางรายชื่อจากฉลาก (คั่นด้วยจุลภาค)';

  @override
  String get fieldInvalidNumber => 'ตัวเลขไม่ถูกต้อง';

  @override
  String get pickDate => 'เลือกวันที่';

  @override
  String get actionSave => 'บันทึก';

  @override
  String get actionCancel => 'ยกเลิก';

  @override
  String get actionDelete => 'ลบ';

  @override
  String get actionEdit => 'แก้ไข';

  @override
  String get actionClear => 'ล้าง';

  @override
  String remainingExact(String percent) {
    return 'เหลือ $percent%';
  }

  @override
  String remainingApprox(String percent) {
    return 'เหลือประมาณ $percent%';
  }

  @override
  String get remainingUnknown => 'ชั่งน้ำหนักเพื่อดูว่าเหลือเท่าไหร่';

  @override
  String get statUsed => 'ใช้ไปแล้ว';

  @override
  String get statRemaining => 'คงเหลือ';

  @override
  String get statPerDay => 'ใช้ต่อวัน';

  @override
  String statPricePerUnit(String unit) {
    return 'ราคาต่อ$unit';
  }

  @override
  String get statCostUsed => 'มูลค่าที่ใช้ไป';

  @override
  String get statCostPerUse => 'บาทต่อครั้ง (ประมาณ)';

  @override
  String get statUsageCount => 'จำนวนครั้งที่ใช้';

  @override
  String get statEmptyOn => 'คาดว่าจะหมด';

  @override
  String get notEnoughData => 'ยังประมาณไม่ได้';

  @override
  String get weightAnomaly =>
      'น้ำหนักล่าสุดมากกว่าตอนเริ่มต้น อาจชั่งผิด ลองชั่งใหม่หรือลบรายการที่ผิด';

  @override
  String get weightHistory => 'ประวัติการชั่ง';

  @override
  String get weightChartTitle => 'น้ำหนักตามเวลา';

  @override
  String get weighNow => 'ชั่งใหม่';

  @override
  String get weighTitle => 'ชั่งน้ำหนัก';

  @override
  String get weighHint => 'น้ำหนักรวมขวด (กรัม)';

  @override
  String weighDiff(String diff) {
    return '$diff กรัม จากครั้งก่อน';
  }

  @override
  String get weighFirst =>
      'ครั้งแรก ชั่งตอนยังไม่ได้ใช้ (รวมบรรจุภัณฑ์) จะใช้เป็นน้ำหนักเริ่มต้น';

  @override
  String get weighHeavier => 'หนักกว่าครั้งก่อน ตรวจสอบอีกครั้งนะ';

  @override
  String get weighEmpty => 'ยังไม่มีการชั่ง';

  @override
  String get skinWhileUsing => 'ผิวช่วงที่ใช้สินค้านี้';

  @override
  String get skinWhileUsingEmpty => 'ยังไม่มีบันทึกผิวในวันที่ใช้สินค้านี้';

  @override
  String basedOnDays(int count) {
    return 'จาก $count วันที่บันทึก';
  }

  @override
  String get scoreOil => 'ความมัน';

  @override
  String get scoreMoisture => 'ความชุ่มชื้น';

  @override
  String get scoreAcne => 'สิว';

  @override
  String get scoreRedness => 'ความแดง';

  @override
  String get scoreDullness => 'ความหมองคล้ำ';

  @override
  String get finishAction => 'ใช้หมดแล้ว';

  @override
  String get finishTitle => 'ปิดสินค้านี้';

  @override
  String get finishRating => 'ให้คะแนน';

  @override
  String get finishRepurchase => 'จะซื้อซ้ำไหม?';

  @override
  String get repurchaseYes => 'ซื้อซ้ำ';

  @override
  String get repurchaseNo => 'ไม่ซื้อซ้ำ';

  @override
  String get actionReopen => 'นำกลับมาใช้';

  @override
  String get actionStartUsing => 'เริ่มใช้';

  @override
  String get actionPause => 'พักไว้';

  @override
  String get deleteProductTitle => 'ลบสินค้านี้?';

  @override
  String get deleteProductBody =>
      'ประวัติการชั่งและการใช้ของสินค้านี้จะถูกลบด้วย';

  @override
  String get deleteWeighingTitle => 'ลบรายการชั่งนี้?';

  @override
  String get wishlistCompare => 'เทียบความคุ้มค่า';

  @override
  String get wishlistCompareEmpty =>
      'ยังไม่มีสินค้าประเภทเดียวกันที่มีราคาต่อหน่วยให้เทียบ';

  @override
  String get wishlistCompareNeedsPrice =>
      'ใส่ราคาและปริมาณเพื่อเทียบความคุ้มค่า';

  @override
  String cheaperBy(String percent) {
    return 'ถูกกว่า $percent%';
  }

  @override
  String pricierBy(String percent) {
    return 'แพงกว่า $percent%';
  }

  @override
  String get samePrice => 'ราคาพอๆ กัน';

  @override
  String get infoSection => 'ข้อมูลสินค้า';

  @override
  String get expiresOn => 'หมดอายุ';

  @override
  String get ratingLabel => 'คะแนน';

  @override
  String get repurchaseLabel => 'ซื้อซ้ำ';

  @override
  String get finishedOn => 'ใช้หมดเมื่อ';

  @override
  String perUnitShort(String price, String unit) {
    return '฿$price/$unit';
  }

  @override
  String get productNotFound => 'ไม่พบสินค้านี้';

  @override
  String get valueSection => 'ความคุ้มค่า';

  @override
  String reminderRoutineTitle(String name) {
    return 'ถึงเวลารูทีน$nameแล้ว ✨';
  }

  @override
  String get reminderRoutineBody => 'แตะเพื่อติ๊กว่าใช้อะไรไปบ้างวันนี้';

  @override
  String get reminderWeighTitle => 'ถึงเวลาชั่งสกินแคร์';

  @override
  String get reminderWeighBody =>
      'ชั่งขวดที่ใช้อยู่ จะได้รู้ว่าเหลือเท่าไหร่และหมดเมื่อไหร่';

  @override
  String get reminderExpiryTitle => 'สินค้าใกล้หมดอายุ';

  @override
  String reminderExpiryBody(String name) {
    return '$name จะหมดอายุในอีก 7 วัน';
  }

  @override
  String get reminderBackupTitle => 'สำรองข้อมูลกันไว้หน่อยไหม?';

  @override
  String get reminderBackupBody =>
      'ข้อมูลทั้งหมดอยู่ในเครื่องนี้เท่านั้น สำรองไว้กันหายเวลาเปลี่ยนเครื่อง';

  @override
  String get routinesTitle => 'รูทีนของฉัน';

  @override
  String get routinesManage => 'จัดการรูทีน';

  @override
  String get routineNew => 'รูทีนใหม่';

  @override
  String get routineName => 'ชื่อรูทีน';

  @override
  String get routineSlot => 'ช่วงเวลา';

  @override
  String get slotMorning => 'เช้า';

  @override
  String get slotEvening => 'เย็น';

  @override
  String get slotOther => 'อื่นๆ';

  @override
  String get routineSteps => 'ขั้นตอน';

  @override
  String get routineStepsHint => 'กดค้างแล้วลากเพื่อจัดลำดับ';

  @override
  String get routineAddSteps => 'เพิ่มขั้นตอน';

  @override
  String get routineAddStepsTitle => 'เลือกสินค้าที่ใช้ในรูทีนนี้';

  @override
  String get routineAddStepsEmpty =>
      'ยังไม่มีสินค้าที่ใช้อยู่ เพิ่มสินค้าก่อนนะ';

  @override
  String routineAddSelected(int count) {
    return 'เพิ่ม $count รายการ';
  }

  @override
  String get routineReminder => 'แจ้งเตือนรูทีนนี้';

  @override
  String routineReminderAt(String time) {
    return 'ทุกวัน เวลา $time';
  }

  @override
  String get routineDeleteTitle => 'ลบรูทีนนี้?';

  @override
  String get routineDeleteBody => 'ประวัติการใช้สินค้าจะยังอยู่';

  @override
  String routineStepCount(int count) {
    return '$count ขั้นตอน';
  }

  @override
  String get routineNotInUse => 'ไม่ได้ใช้อยู่';

  @override
  String get routineEmptySteps => 'ยังไม่มีขั้นตอน แตะเพื่อเพิ่มสินค้า';

  @override
  String get routineUseAsUsual => 'ใช้ตามปกติ';

  @override
  String get routineAllDone => 'ครบแล้ว';

  @override
  String routineProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String todayProgress(int done, int total) {
    return 'วันนี้ทำไปแล้ว $done จาก $total ขั้นตอน';
  }

  @override
  String get todayAllDone => 'ครบทุกขั้นตอนแล้ว เก่งมาก! 💗';

  @override
  String get todayAlertsTitle => 'ควรรู้วันนี้';

  @override
  String alertLow(String name, String percent) {
    return '$name เหลือประมาณ $percent%';
  }

  @override
  String alertEmptySoon(String name, String date) {
    return '$name คาดว่าจะหมด $date';
  }

  @override
  String alertExpired(String name, String date) {
    return '$name หมดอายุแล้ว ($date)';
  }

  @override
  String alertExpiring(String name, String date) {
    return '$name จะหมดอายุ $date';
  }

  @override
  String alertWeighDue(String name, int days) {
    return 'ถึงเวลาชั่ง $name (ชั่งล่าสุด $days วันก่อน)';
  }

  @override
  String get todaySkinTitle => 'ผิววันนี้';

  @override
  String get todaySkinEmpty => 'ยังไม่ได้บันทึก แตะเพื่อบันทึกสภาพผิว';

  @override
  String get todaySkinEdit => 'แก้ไขบันทึก';

  @override
  String get dailyLogTitle => 'บันทึกสภาพผิว';

  @override
  String get dailyLogScores => 'ให้คะแนนผิว';

  @override
  String get dailyLogScoresHint =>
      '1 = น้อยมาก · 5 = มากที่สุด แตะซ้ำเพื่อล้าง';

  @override
  String get dailyLogSymptoms => 'อาการ';

  @override
  String get dailyLogFactors => 'ปัจจัยแวดล้อม';

  @override
  String get dailyLogLifestyle => 'ไลฟ์สไตล์';

  @override
  String get dailyLogSleep => 'นอน (ชั่วโมง)';

  @override
  String get dailyLogStress => 'ความเครียด';

  @override
  String get dailyLogSun => 'โดนแดด';

  @override
  String get sunNone => 'ไม่โดน';

  @override
  String get sunLow => 'เล็กน้อย';

  @override
  String get sunHigh => 'นาน';

  @override
  String get dailyLogPeriod => 'รอบเดือน';

  @override
  String get periodMenstruation => 'มีประจำเดือน';

  @override
  String get periodFollicular => 'หลังมีประจำเดือน';

  @override
  String get periodOvulation => 'ช่วงไข่ตก';

  @override
  String get periodLuteal => 'ก่อนมีประจำเดือน';

  @override
  String get dailyLogNote => 'โน้ต';

  @override
  String get dailyLogNoteHint => 'วันนี้ผิวเป็นยังไงบ้าง ลองอะไรใหม่ไหม';

  @override
  String get dailyLogSaved => 'บันทึกแล้ว';

  @override
  String get tagAdd => 'เพิ่ม';

  @override
  String get tagAddTitle => 'เพิ่มแท็กใหม่';

  @override
  String get tagName => 'ชื่อแท็ก';

  @override
  String get settingsNotifications => 'การแจ้งเตือน';

  @override
  String get settingsRoutineReminders => 'แจ้งเตือนรูทีนเช้า/เย็น';

  @override
  String get settingsRoutineRemindersHint => 'ตั้งเวลาได้ในแต่ละรูทีน';

  @override
  String get settingsWeighReminder => 'เตือนให้ชั่งน้ำหนักสินค้า';

  @override
  String get weighReminderOff => 'ปิด';

  @override
  String get weighReminderWeekly => 'ทุกสัปดาห์';

  @override
  String get weighReminderBiweekly => 'ทุก 2 สัปดาห์';

  @override
  String get settingsExpiryReminders => 'เตือนก่อนหมดอายุ 7 วัน';

  @override
  String get settingsExpiryRemindersHint =>
      'นับจากวันหมดอายุบนฉลาก หรืออายุหลังเปิด (PAO)';

  @override
  String get notificationPermissionTitle => 'ขอสิทธิ์แจ้งเตือน';

  @override
  String get notificationPermissionBody =>
      'Very Beauty จะส่งการแจ้งเตือนจากในเครื่องเท่านั้น เพื่อเตือนรูทีน การชั่ง และวันหมดอายุ ไม่มีการส่งข้อมูลออกไปไหน';

  @override
  String get notificationPermissionDenied =>
      'ยังไม่ได้รับสิทธิ์แจ้งเตือน เปิดได้ในการตั้งค่าของเครื่อง';

  @override
  String get actionContinue => 'ดำเนินการต่อ';

  @override
  String get actionDone => 'เสร็จ';

  @override
  String get pickTime => 'เลือกเวลา';

  @override
  String get cameraTitle => 'ถ่ายรูปผิว';

  @override
  String get cameraTipTitle => 'เคล็ดลับให้เทียบผลได้แม่น';

  @override
  String get cameraTip =>
      'ถ่ายใกล้หน้าต่าง ใช้แสงธรรมชาติแบบเดิมทุกครั้ง ไม่ใช้แฟลช จัดหน้าให้อยู่ในกรอบวงรี';

  @override
  String get cameraPermissionTitle => 'ขอใช้กล้อง';

  @override
  String get cameraPermissionBody =>
      'ใช้กล้องเพื่อถ่ายรูปผิวไว้เทียบผล รูปจะเก็บในแอพนี้เท่านั้น ไม่ลงแกลเลอรีและไม่ส่งออกไปไหน';

  @override
  String get cameraDenied =>
      'ไม่ได้รับสิทธิ์ใช้กล้อง เปิดได้ในการตั้งค่าของเครื่อง';

  @override
  String get cameraUnavailable => 'ไม่พบกล้องบนอุปกรณ์นี้';

  @override
  String get cameraOnionSkin => 'ภาพครั้งก่อน';

  @override
  String get cameraSwitch => 'สลับกล้อง';

  @override
  String get cameraCapture => 'ถ่ายรูป';

  @override
  String get cameraSaving => 'กำลังบันทึก…';

  @override
  String get cameraSaved => 'บันทึกรูปแล้ว';

  @override
  String get photoSession => 'ช่วง';

  @override
  String get photosCompare => 'เทียบรูป';

  @override
  String get photosSelectTwo => 'เลือก 2 รูปที่จะเทียบ';

  @override
  String photosSelected(int count) {
    return 'เลือกแล้ว $count/2';
  }

  @override
  String get photosTake => 'ถ่ายรูป';

  @override
  String get photoDeleteTitle => 'ลบรูปนี้?';

  @override
  String get photoDeleteBody => 'รูปจะถูกลบออกจากเครื่องถาวร';

  @override
  String get photoNote => 'โน้ตของรูป';

  @override
  String get compareTitle => 'เทียบรูป';

  @override
  String get compareHint => 'ลากเส้นกลางเพื่อเทียบ';

  @override
  String compareDaysApart(int days) {
    return 'ห่างกัน $days วัน';
  }

  @override
  String get insightsTabCalendar => 'ปฏิทิน';

  @override
  String get insightsTabChart => 'กราฟผิว';

  @override
  String get insightsTabSearch => 'ค้นหา';

  @override
  String get insightsTabSpending => 'ค่าใช้จ่าย';

  @override
  String get calendarLegendCalm => 'ผิวดี';

  @override
  String get calendarLegendTroubled => 'มีปัญหา';

  @override
  String get calendarLegendPhoto => 'มีรูป';

  @override
  String get calendarLegendUsage => 'ใช้สินค้า';

  @override
  String get daySummaryNoLog => 'ยังไม่มีบันทึกผิววันนี้';

  @override
  String get daySummaryProducts => 'สินค้าที่ใช้';

  @override
  String get daySummaryNoProducts => 'ไม่ได้บันทึกการใช้สินค้า';

  @override
  String daySummaryTimes(int count) {
    return '$count ครั้ง';
  }

  @override
  String get daySummaryEdit => 'แก้ไขบันทึกวันนี้';

  @override
  String get daySummaryPhotos => 'รูปถ่าย';

  @override
  String get chartRange30 => '30 วัน';

  @override
  String get chartRange90 => '90 วัน';

  @override
  String get chartRange180 => '6 เดือน';

  @override
  String get chartEmpty => 'ยังไม่มีคะแนนผิวในช่วงนี้ ลองบันทึกผิวทุกวันดูนะ';

  @override
  String get chartMarkers => 'เริ่มใช้ / ใช้หมด';

  @override
  String chartMarkerStart(String name) {
    return 'เริ่มใช้ $name';
  }

  @override
  String chartMarkerEnd(String name) {
    return 'ใช้หมด $name';
  }

  @override
  String get searchPrompt =>
      'เลือกอาการหรือปัจจัย เพื่อดูว่าวันนั้นและ 3 วันก่อนหน้าใช้อะไรไปบ้าง';

  @override
  String get searchNoDays => 'ยังไม่มีวันที่ติดแท็กนี้';

  @override
  String searchDaysFound(int count) {
    return 'พบ $count วัน';
  }

  @override
  String get searchRecentProducts => 'ใช้ในช่วง 3 วันก่อน';

  @override
  String get spendingThisMonth => 'เดือนนี้';

  @override
  String get spendingSixMonths => '6 เดือนล่าสุด';

  @override
  String get spendingPerMonth => 'ค่าใช้จ่ายต่อเดือน';

  @override
  String get spendingNote =>
      'นับตามวันที่ซื้อ (หรือวันที่เปิดใช้) ไม่รวมรายการอยากได้';

  @override
  String get spendingValue => 'ความคุ้มค่าต่อสินค้า';

  @override
  String get spendingValueHint => 'เรียงจากบาทต่อครั้งถูกสุด';

  @override
  String get spendingNoProducts => 'ใส่ราคาสินค้าเพื่อดูสรุปค่าใช้จ่าย';

  @override
  String perUseShort(String price) {
    return '$price/ครั้ง';
  }

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get languageThai => 'ไทย';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsPrivacy => 'ความเป็นส่วนตัว';

  @override
  String get settingsAppLock => 'ล็อกแอพ';

  @override
  String get settingsAppLockHint =>
      'ใช้ลายนิ้วมือ ใบหน้า หรือรหัสของเครื่องเพื่อเปิดแอพ';

  @override
  String get settingsAppLockUnavailable =>
      'เครื่องนี้ยังไม่ได้ตั้งรหัสหรือไบโอเมตริก';

  @override
  String get settingsSecureScreen => 'ป้องกันการแคปหน้าจอ';

  @override
  String get settingsSecureScreenHint => 'กันการแคปหรืออัดหน้าจอแอพ (Android)';

  @override
  String get settingsData => 'ข้อมูลและการสำรอง';

  @override
  String get backupExport => 'สำรองข้อมูล (Export)';

  @override
  String get backupExportHint =>
      'สร้างไฟล์ .zip รวมข้อมูลและรูปทั้งหมด แล้วเลือกเก็บไว้ที่ไหนก็ได้';

  @override
  String get backupImport => 'กู้คืนข้อมูล (Import)';

  @override
  String get backupImportHint => 'เลือกไฟล์สำรอง .zip เพื่อนำข้อมูลกลับมา';

  @override
  String backupLast(String date) {
    return 'สำรองล่าสุด $date';
  }

  @override
  String get backupNever => 'ยังไม่เคยสำรองข้อมูล';

  @override
  String get backupReminders => 'เตือนให้สำรองข้อมูลทุกเดือน';

  @override
  String get backupWorking => 'กำลังเตรียมไฟล์สำรอง…';

  @override
  String get backupRestoring => 'กำลังกู้คืนข้อมูล…';

  @override
  String get backupShareSubject => 'ไฟล์สำรอง Very Beauty';

  @override
  String get backupDone => 'สำรองข้อมูลแล้ว';

  @override
  String backupFailed(String error) {
    return 'สำรองข้อมูลไม่สำเร็จ: $error';
  }

  @override
  String get restoreConfirmTitle => 'กู้คืนข้อมูลจากไฟล์นี้?';

  @override
  String restoreConfirmBody(String date, int count) {
    return 'ไฟล์สำรองวันที่ $date มีรูป $count รูป\n\nข้อมูลและรูปทั้งหมดในเครื่องตอนนี้จะถูกแทนที่ และย้อนกลับไม่ได้';
  }

  @override
  String get restoreAction => 'แทนที่ด้วยข้อมูลสำรอง';

  @override
  String get restoreDone => 'กู้คืนข้อมูลเรียบร้อย';

  @override
  String get restoreNotBackup => 'ไฟล์นี้ไม่ใช่ไฟล์สำรองของ Very Beauty';

  @override
  String restoreNewer(String version) {
    return 'ไฟล์สำรองนี้มาจากแอพเวอร์ชันใหม่กว่า ($version) อัปเดตแอพก่อนนะ';
  }

  @override
  String get restoreCorrupt => 'ไฟล์สำรองเสียหาย ข้อมูลเดิมยังอยู่ครบ';

  @override
  String alertBackupDue(int days) {
    return 'ไม่ได้สำรองข้อมูลมา $days วัน';
  }

  @override
  String get lockTitle => 'Very Beauty ถูกล็อกไว้';

  @override
  String get lockUnlock => 'ปลดล็อก';

  @override
  String get lockReason => 'ยืนยันตัวตนเพื่อเปิด Very Beauty';

  @override
  String get lockEnableReason => 'ยืนยันตัวตนเพื่อเปิดใช้การล็อกแอพ';

  @override
  String get settingsUpdates => 'อัปเดต';

  @override
  String get updateCheck => 'ตรวจสอบอัปเดต';

  @override
  String updateCurrent(String version) {
    return 'เวอร์ชันปัจจุบัน $version';
  }

  @override
  String get updateAuto => 'ตรวจอัปเดตอัตโนมัติวันละครั้ง';

  @override
  String get updateAutoHint =>
      'เชื่อมต่อ GitHub เพื่อดูเวอร์ชันล่าสุดเท่านั้น ไม่ส่งข้อมูลของคุณ';

  @override
  String get updateChecking => 'กำลังตรวจสอบ…';

  @override
  String get updateNone => 'เป็นเวอร์ชันล่าสุดแล้ว (หรือยังเชื่อมต่อไม่ได้)';

  @override
  String get updateAvailableTitle => 'มีเวอร์ชันใหม่ ✨';

  @override
  String get updateRequiredTitle => 'ต้องอัปเดตก่อนใช้งานต่อ';

  @override
  String get updateRequiredBody =>
      'เวอร์ชันนี้เก่าเกินไปสำหรับข้อมูลรูปแบบใหม่';

  @override
  String get updateKeepsData =>
      'ดาวน์โหลดไฟล์ติดตั้งแล้วแตะเพื่ออัปเดต ข้อมูลยังอยู่ครบ (ถ้าแอพเซ็นด้วยกุญแจเดียวกัน) แนะนำให้สำรองข้อมูลก่อน';

  @override
  String get updateDownload => 'ดาวน์โหลด';

  @override
  String get updateLater => 'ภายหลัง';

  @override
  String get ingFnSurfactant => 'สารทำความสะอาด';

  @override
  String get ingFnUvChemical => 'สารกันแดด (เคมี)';

  @override
  String get ingFnUvMineral => 'สารกันแดด (แร่)';

  @override
  String get ingFnHumectant => 'ดึงความชุ่มชื้น';

  @override
  String get ingFnEmollient => 'เพิ่มความนุ่มชุ่มชื่น';

  @override
  String get ingFnOcclusive => 'เคลือบกักความชุ่มชื้น';

  @override
  String get ingFnBarrier => 'ฟื้นฟูเกราะผิว';

  @override
  String get ingFnBrightening => 'ผิวกระจ่างใส';

  @override
  String get ingFnAntioxidant => 'ต้านอนุมูลอิสระ';

  @override
  String get ingFnExfoliant => 'ผลัดเซลล์ผิว';

  @override
  String get ingFnAntiAcne => 'ลดสิว';

  @override
  String get ingFnRetinoid => 'เรตินอยด์';

  @override
  String get ingFnAntiAging => 'ลดริ้วรอย';

  @override
  String get ingFnSoothing => 'ปลอบประโลมผิว';

  @override
  String get ingFnAbsorbent => 'ดูดซับความมัน';

  @override
  String get ingFnFilmFormer => 'สร้างฟิล์มบนผิว';

  @override
  String get ingFnEmulsifier => 'ผสานน้ำกับน้ำมัน';

  @override
  String get ingFnThickener => 'ปรับเนื้อสัมผัส';

  @override
  String get ingFnPreservative => 'สารกันเสีย';

  @override
  String get ingFnChelating => 'จับโลหะ (คีเลต)';

  @override
  String get ingFnPhAdjuster => 'ปรับค่า pH';

  @override
  String get ingFnSolvent => 'ตัวทำละลาย';

  @override
  String get ingFnFragrance => 'น้ำหอม/กลิ่น';

  @override
  String get ingFnOther => 'อื่นๆ';

  @override
  String get ingredientsSearchHint => 'เช่น ไนอะซินาไมด์, zinc oxide';

  @override
  String ingredientsCommonIn(String category) {
    return 'พบบ่อยใน$category · แตะเพื่อเพิ่ม';
  }

  @override
  String ingredientsAddCustom(String name) {
    return 'เพิ่ม “$name”';
  }

  @override
  String get ingredientsCustomSubtitle => 'ยังไม่มีในฐานข้อมูล';

  @override
  String get ingredientsUsedBefore => 'เคยใช้ในสินค้าอื่น';

  @override
  String get ingredientsUnknown => 'ส่วนผสมนี้ยังไม่มีในฐานข้อมูลของแอพ';

  @override
  String get ingredientsTitle => 'ฐานข้อมูลส่วนผสม';

  @override
  String ingredientsCount(int count) {
    return '$count รายการ';
  }

  @override
  String get ingredientsAlsoKnownAs => 'ชื่ออื่น';

  @override
  String get ingredientsTypicalIn => 'พบบ่อยใน';

  @override
  String get ingredientsCaution => 'ควรรู้';

  @override
  String get ingredientsNoMatch => 'ไม่พบส่วนผสมที่ค้นหา';

  @override
  String get ingredientsDisclaimer =>
      'ข้อมูลทั่วไปเพื่อประกอบการเลือกใช้ ไม่ใช่คำแนะนำทางการแพทย์';

  @override
  String get ingredientsFilterAll => 'ทุกหน้าที่';

  @override
  String fieldEmptyWeightAuto(String start, String net, String packaging) {
    return 'เว้นว่างได้ — คำนวณให้: $start − $net = $packaging กรัม';
  }

  @override
  String packagingCalculated(String grams) {
    return '$grams (คำนวณ)';
  }

  @override
  String statPackaging(String grams) {
    return 'บรรจุภัณฑ์ $grams กรัม';
  }

  @override
  String weighPackagingPreview(String packaging, String total, String net) {
    return 'บรรจุภัณฑ์ ≈ $packaging กรัม ($total − ปริมาณสุทธิ $net)';
  }

  @override
  String weighRemainingPreview(String grams, String percent) {
    return 'เหลือ $grams กรัม ($percent%)';
  }

  @override
  String get weighMlNote => 'สินค้าหน่วย มล. คิดประมาณ 1 มล. ≈ 1 กรัม';

  @override
  String get ingFnColorant => 'สี/เม็ดสี';

  @override
  String get ingredientWhat => 'คืออะไร';

  @override
  String get ingredientGood => 'ช่วยอะไร';

  @override
  String get ingredientTips => 'วิธีใช้และเคล็ดลับ';

  @override
  String get ingredientAbout => 'ข้อมูลโดยย่อ';

  @override
  String get ingredientStructure => 'โครงสร้างทางเคมี';

  @override
  String ingredientFormula(String formula) {
    return 'สูตรโมเลกุล $formula';
  }

  @override
  String ingredientMw(String mw) {
    return 'มวลโมเลกุล $mw g/mol';
  }

  @override
  String get ingredientZoomHint =>
      'จีบนิ้วเพื่อซูม · แสดงโครงสร้างแบบเส้น (มุมคือคาร์บอน)';

  @override
  String get ingredientKindPolymer =>
      'เป็นพอลิเมอร์ (โมเลกุลสายยาวที่ต่อกันซ้ำๆ หลายขนาด) จึงไม่มีโครงสร้างเดียว';

  @override
  String get ingredientKindExtract =>
      'เป็นสารสกัดจากธรรมชาติ ประกอบด้วยสารหลายชนิดรวมกัน';

  @override
  String get ingredientKindOil =>
      'เป็นน้ำมัน/ไขมันธรรมชาติ ประกอบด้วยไตรกลีเซอไรด์ของกรดไขมันหลายชนิด';

  @override
  String get ingredientKindMixture =>
      'เป็นสารผสมของโมเลกุลหลายขนาด (เช่น กรดไขมันจากมะพร้าวที่ยาวไม่เท่ากัน)';

  @override
  String get ingredientKindMineral =>
      'เป็นแร่หรือสารอนินทรีย์ที่อยู่ในรูปผลึก ไม่ใช่โมเลกุลเดี่ยว';

  @override
  String get ingredientKindProtein => 'เป็นโปรตีนหรือเอนไซม์ขนาดใหญ่';

  @override
  String get ingredientKindFerment =>
      'เป็นผลิตภัณฑ์จากการหมักจุลินทรีย์ มีสารหลายชนิดรวมกัน';

  @override
  String get ingredientKindPeptide =>
      'เป็นเปปไทด์ (กรดอะมิโนหลายตัวต่อกัน) โมเลกุลใหญ่เกินกว่าจะแสดงชัดบนจอ';

  @override
  String get ingredientKindUnknown => 'ยังไม่มีข้อมูลโครงสร้างของสารนี้';

  @override
  String get ingredientMyProducts => 'สินค้าของฉันที่มีส่วนผสมนี้';

  @override
  String get ingredientFunctions => 'หน้าที่';

  @override
  String get ingFnAboutSurfactant =>
      'สารลดแรงตึงผิวที่จับทั้งน้ำและน้ำมัน ทำให้คราบมัน เครื่องสำอาง และสิ่งสกปรกหลุดออกไปกับน้ำ';

  @override
  String get ingFnAboutUvChemical =>
      'ดูดซับรังสี UV แล้วเปลี่ยนเป็นพลังงานความร้อนเล็กน้อย ป้องกันผิวไหม้ ฝ้า และผิวแก่ก่อนวัย';

  @override
  String get ingFnAboutUvMineral =>
      'อนุภาคแร่ที่สะท้อน กระจาย และดูดซับรังสี UV บนผิว อ่อนโยน เหมาะกับผิวแพ้ง่าย';

  @override
  String get ingFnAboutHumectant =>
      'ดึงน้ำจากอากาศและชั้นผิวด้านล่างมากักเก็บไว้ที่ผิวชั้นบน ทำให้ผิวอิ่มน้ำ';

  @override
  String get ingFnAboutEmollient =>
      'เติมช่องว่างระหว่างเซลล์ผิวที่แห้งลอก ทำให้ผิวเรียบ นุ่ม ลื่น';

  @override
  String get ingFnAboutOcclusive =>
      'สร้างชั้นเคลือบบนผิว ลดการระเหยของน้ำ เหมาะทาเป็นขั้นตอนสุดท้าย';

  @override
  String get ingFnAboutBarrier =>
      'เป็นไขมันหรือสารที่ผิวใช้สร้างเกราะป้องกัน ช่วยซ่อมแซมผิวที่แห้ง แดง แสบง่าย';

  @override
  String get ingFnAboutBrightening =>
      'ลดการสร้างหรือการกระจายของเม็ดสี ช่วยให้จุดด่างดำจางและสีผิวสม่ำเสมอ';

  @override
  String get ingFnAboutAntioxidant =>
      'ดักจับอนุมูลอิสระจากแสงแดดและมลภาวะ ช่วยชะลอริ้วรอยและจุดด่างดำ หรือปกป้องสูตรไม่ให้เสื่อม';

  @override
  String get ingFnAboutExfoliant =>
      'ช่วยให้เซลล์ผิวเก่าหลุดออก ผิวเรียบ กระจ่างใส ไม่หมองคล้ำ';

  @override
  String get ingFnAboutAntiAcne =>
      'ช่วยลดสิวโดยลดเชื้อแบคทีเรีย ความมัน หรือการอุดตันของรูขุมขน';

  @override
  String get ingFnAboutRetinoid =>
      'อนุพันธ์วิตามินเอที่เร่งการผลัดเซลล์และสร้างคอลลาเจน ลดริ้วรอยและสิว';

  @override
  String get ingFnAboutAntiAging =>
      'ช่วยลดเลือนริ้วรอยหรือกระตุ้นการสร้างคอลลาเจน ทำให้ผิวกระชับ';

  @override
  String get ingFnAboutSoothing =>
      'ลดการระคายเคือง รอยแดง และอาการแสบคัน ช่วยให้ผิวสงบ';

  @override
  String get ingFnAboutAbsorbent =>
      'ดูดซับความมันหรือความชื้นส่วนเกิน ให้ผิวดูแมตต์และเนียน';

  @override
  String get ingFnAboutFilmFormer =>
      'สร้างฟิล์มบางๆ บนผิว ช่วยให้ผลิตภัณฑ์ติดทน กันน้ำ หรือให้ความรู้สึกเรียบตึง';

  @override
  String get ingFnAboutEmulsifier =>
      'ทำให้น้ำกับน้ำมันผสมกันเป็นเนื้อครีม/โลชั่นที่ไม่แยกชั้น';

  @override
  String get ingFnAboutThickener =>
      'ปรับความข้นหนืดและเนื้อสัมผัสของผลิตภัณฑ์ให้ใช้ง่ายและคงตัว';

  @override
  String get ingFnAboutPreservative =>
      'ป้องกันเชื้อโรคและเชื้อราในผลิตภัณฑ์ ทำให้ใช้ได้อย่างปลอดภัยจนหมด';

  @override
  String get ingFnAboutChelating =>
      'จับแร่ธาตุโลหะในน้ำ ช่วยให้สูตรคงตัว ไม่เปลี่ยนสีหรือกลิ่น';

  @override
  String get ingFnAboutPhAdjuster =>
      'ปรับความเป็นกรด-ด่างของสูตรให้เหมาะกับผิวและสารสำคัญ';

  @override
  String get ingFnAboutSolvent =>
      'ตัวทำละลายที่ช่วยละลายส่วนผสมอื่นและกำหนดเนื้อสัมผัสของสูตร';

  @override
  String get ingFnAboutFragrance =>
      'ให้กลิ่นหอมแก่ผลิตภัณฑ์ ไม่ได้บำรุงผิวโดยตรง และอาจก่อการแพ้ได้';

  @override
  String get ingFnAboutColorant =>
      'ให้สีกับผลิตภัณฑ์หรือผิว เช่น เม็ดสีในรองพื้นหรือกันแดดสีเนื้อ';

  @override
  String get ingFnAboutOther =>
      'มีบทบาทเฉพาะในสูตร เช่น ทำให้เย็น ให้ประกาย หรือช่วยให้สารอื่นคงตัว';

  @override
  String get ingredientRoles => 'หน้าที่ในสูตร';

  @override
  String get updateNow => 'อัปเดตเลย';

  @override
  String get updateInAppBody =>
      'กด \"อัปเดตเลย\" แอปจะดาวน์โหลดและติดตั้งเวอร์ชันใหม่ให้เอง ข้อมูลทั้งหมดยังอยู่ครบ';

  @override
  String get updateDownloading => 'กำลังดาวน์โหลดอัปเดต…';

  @override
  String get updateInstalling =>
      'กำลังติดตั้ง… แอปจะปิดลงเมื่อเสร็จ แตะการแจ้งเตือนเพื่อเปิดอีกครั้ง';

  @override
  String get updatePermissionTitle => 'อนุญาตให้ Very Beauty ติดตั้งอัปเดต';

  @override
  String get updatePermissionBody =>
      'ทำแค่ครั้งเดียว: เปิดสวิตช์ \"อนุญาตจากแหล่งที่มานี้\" แล้วกดย้อนกลับมาที่แอป';

  @override
  String get updatePermissionOpen => 'ไปที่การตั้งค่า';

  @override
  String get updatePermissionMissing =>
      'ยังไม่ได้อนุญาต ลองใหม่ได้ที่ ตั้งค่า → ตรวจสอบอัปเดต';

  @override
  String get updateDownloadFailed =>
      'ดาวน์โหลดไม่สำเร็จ ตรวจการเชื่อมต่อแล้วลองใหม่';

  @override
  String get updateInstallFailed => 'ติดตั้งไม่สำเร็จ ลองใหม่อีกครั้ง';

  @override
  String get updateCancelled => 'ยกเลิกการอัปเดตแล้ว';

  @override
  String get updateSignatureTitle => 'ต้องติดตั้งใหม่อีกครั้งสุดท้าย';

  @override
  String get updateSignatureBody =>
      'แอปที่ติดตั้งอยู่เป็นรุ่นที่เซ็นด้วยกุญแจชั่วคราว จึงอัปเดตทับไม่ได้ ให้กด \"สำรองข้อมูล\" ลบแอป แล้วติดตั้งไฟล์ใหม่และกู้คืนข้อมูล ครั้งต่อไปจะกดอัปเดตในแอปได้เลย';

  @override
  String get productPhotoAdd => 'เพิ่มรูป';

  @override
  String get productPhotoCamera => 'ถ่ายรูป';

  @override
  String get productPhotoGallery => 'เลือกจากคลังภาพ';

  @override
  String get productPhotoRemove => 'ลบรูป';

  @override
  String get productPhotoFailed => 'เปิดรูปนี้ไม่ได้ ลองรูปอื่น';

  @override
  String get fieldCategoryMultiHint =>
      'เลือกได้หลายหมวด · หมวดแรกเป็นหมวดหลัก ★';
}

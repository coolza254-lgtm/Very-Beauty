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
      'ข้อมูลและรูปถ่ายทั้งหมดถูกเก็บไว้ในเครื่องของคุณเท่านั้น แอพไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ และไม่มีระบบติดตามการใช้งาน';
}

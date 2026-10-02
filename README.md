# Very Beauty 💗

แอพบันทึกและติดตามสกินแคร์แบบออฟไลน์ (Android + iOS) สร้างด้วย Flutter

- spec ฉบับเต็ม: [`docs/SPEC.md`](docs/SPEC.md)
- สถานะตอนนี้: **Phase 0 — Foundation** เสร็จแล้ว (โครงแอพ, ธีมชมพูพาสเทล, ไอคอนแอพ, เมนูล่าง, ฐานข้อมูล, ภาษาไทย, CI + APK อัตโนมัติ)

---

## 1. ติดตั้งเครื่องมือ (ทำครั้งเดียว)

1. **ติดตั้ง Flutter** ตามคู่มือทางการ: <https://docs.flutter.dev/get-started/install>
   เลือกระบบปฏิบัติการของคุณ แล้วเลือก "Android" หรือ "iOS" เป็นเป้าหมาย
   โปรเจกต์นี้ทดสอบกับ Flutter **3.47.6 (stable)**
2. **สำหรับ Android**: ติดตั้ง [Android Studio](https://developer.android.com/studio)
   เปิดครั้งแรกให้มันดาวน์โหลด Android SDK ให้เสร็จ แล้วรันในเทอร์มินัล
   `flutter doctor --android-licenses` และกด `y` ยอมรับทั้งหมด
3. **สำหรับ iOS** (ต้องใช้ Mac เท่านั้น): ติดตั้ง Xcode จาก App Store แล้วเปิดหนึ่งครั้งเพื่อติดตั้งส่วนเสริม
   จากนั้นติดตั้ง CocoaPods: `sudo gem install cocoapods`
4. ตรวจว่าพร้อมไหม: `flutter doctor` — ขอให้ขึ้นเครื่องหมายถูก ✓ ในส่วนที่จะใช้

## 2. รันแอพ

```bash
git clone <ที่อยู่ repo นี้>
cd Very-Beauty
flutter pub get
flutter run
```

- เสียบมือถือ (เปิด USB debugging บน Android) หรือเปิด emulator/simulator ก่อน `flutter run`
- ถ้ามีหลายเครื่อง: `flutter devices` แล้ว `flutter run -d <id>`

## 2.1 ดาวน์โหลดไฟล์ APK ไปติดตั้งบนมือถือ Android (ไม่ต้องติดตั้งเครื่องมือใดๆ)

ทุกครั้งที่มีการ push โค้ด GitHub จะสร้างไฟล์ APK ให้อัตโนมัติ (ใช้เวลาราว 10 นาที)

1. เปิดหน้า repo บนมือถือ → แตะ **Releases** (หรือเข้า `https://github.com/coolza254-lgtm/Very-Beauty/releases`)
2. เลือกรายการบนสุด → แตะไฟล์ `VeryBeauty-v….apk` เพื่อดาวน์โหลด
3. แตะไฟล์ที่ดาวน์โหลดเสร็จ → ระบบจะถามให้อนุญาต "ติดตั้งแอปที่ไม่รู้จัก" → อนุญาต → ติดตั้ง

### เซ็นแอพ (สำคัญ ถ้าต้องการอัปเดตโดยข้อมูลไม่หาย)

Android จะยอมให้ติดตั้งเวอร์ชันใหม่ทับเวอร์ชันเดิมได้ ก็ต่อเมื่อทั้งสองเวอร์ชันเซ็นด้วย "กุญแจ" (keystore) ชุดเดียวกัน
ถ้ายังไม่ได้ตั้งกุญแจ ระบบจะใช้กุญแจชั่วคราวที่เปลี่ยนทุกครั้ง → ต้องลบแอปเดิมก่อนติดตั้งใหม่ และ**ข้อมูลในแอปจะหาย**

วิธีตั้งกุญแจถาวร (ทำครั้งเดียว ห้าม commit ไฟล์กุญแจลง repo เพราะ repo นี้เป็นสาธารณะ):

1. สร้างกุญแจ (เครื่องที่มี Java):
   `keytool -genkey -v -keystore release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias verybeauty`
2. แปลงเป็นข้อความ: `base64 -w0 release.jks` (macOS: `base64 -i release.jks`)
3. ใน GitHub ไปที่ **Settings → Secrets and variables → Actions → New repository secret** แล้วเพิ่ม 3 ค่า:
   - `ANDROID_KEYSTORE_BASE64` = ข้อความจากข้อ 2
   - `ANDROID_KEYSTORE_PASSWORD` = รหัสผ่านที่ตั้งตอนสร้างกุญแจ
   - `ANDROID_KEY_ALIAS` = `verybeauty`
4. **เก็บไฟล์ `release.jks` และรหัสผ่านไว้ให้ดี** ถ้าหาย จะอัปเดตแอปทับของเดิมไม่ได้อีก

## 3. ทดสอบและตรวจโค้ด

```bash
flutter test          # รัน unit test + widget test
# ภาพหน้าจอตัวอย่าง (ออกที่ build/screenshots/)
flutter test test/screenshots --update-goldens --dart-define=SCREENSHOTS=true
flutter analyze       # ตรวจ lint
dart format lib test  # จัดรูปแบบโค้ด
```

## 4. โค้ดที่สร้างอัตโนมัติ

ไฟล์ `*.g.dart` (ฐานข้อมูล drift) และ `lib/app/l10n/gen/` (ข้อความภาษา) ถูก commit ไว้แล้ว
ถ้าแก้ตารางฐานข้อมูลหรือไฟล์ `.arb` ให้สร้างใหม่ด้วย:

```bash
dart run build_runner build
flutter gen-l10n
```

### เมื่อแก้โครงสร้างฐานข้อมูล (schema)

1. แก้ตารางใน `lib/core/db/tables.dart`
2. เพิ่ม `schemaVersion` ใน `lib/core/db/app_database.dart`
3. รัน `dart run drift_dev make-migrations` — จะบันทึก schema ใหม่ไว้ที่ `drift_schemas/`
   และสร้างไฟล์ช่วย migrate + test ใน `test/drift/`
4. เขียนขั้นตอน migrate ใน `onUpgrade` แล้วรัน `flutter test`
5. อัปเดต `docs/SPEC.md` หัวข้อ 5

## 5. โครงสร้างโปรเจกต์

```
lib/
  main.dart
  app/            # app shell, ธีม, router, ข้อความภาษา (l10n)
  core/
    db/           # ตาราง drift, DAO, migration, ข้อมูลตั้งต้น
    utils/        # ตัวช่วยวันที่, สูตรคำนวณ
    storage/ notifications/ update/   # สำหรับเฟสถัดไป
  features/       # today, products, routines, log, photos, insights, settings
assets/branding/  # โลโก้
assets/icon/      # ไอคอนแอพ + splash (สร้างใหม่: dart run flutter_launcher_icons, dart run flutter_native_splash:create)
assets/fonts/     # ฟอนต์ Mali (หัวข้อ) + Prompt (เนื้อความ), สัญญาอนุญาต OFL
drift_schemas/    # ประวัติ schema สำหรับทดสอบ migration
test/
```

## 6. ความเป็นส่วนตัว

ข้อมูลทั้งหมดอยู่ในเครื่อง ไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ ไม่มี analytics
การเชื่อมต่ออินเทอร์เน็ตเดียวที่จะมีคือการตรวจเวอร์ชันใหม่ (Phase 6)

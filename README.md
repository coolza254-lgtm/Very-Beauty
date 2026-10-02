# Very Beauty 💗

แอพบันทึกและติดตามสกินแคร์แบบออฟไลน์ (Android + iOS) สร้างด้วย Flutter

- spec ฉบับเต็ม: [`docs/SPEC.md`](docs/SPEC.md)
- สถานะตอนนี้: **Phase 0 — Foundation** เสร็จแล้ว (โครงแอพ, ธีม, เมนูล่าง, ฐานข้อมูล, ภาษาไทย, CI)

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

**ไม่อยากติดตั้งอะไรเลย?** ทุกครั้งที่ push โค้ด GitHub Actions จะสร้างไฟล์ APK (Android) ให้
เข้าไปที่แท็บ **Actions** ของ repo → เลือกรอบล่าสุด → ดาวน์โหลด `very-beauty-debug-apk`
แล้วนำไปติดตั้งบนมือถือ Android ได้เลย (ต้องอนุญาต "ติดตั้งจากแหล่งที่ไม่รู้จัก")

## 3. ทดสอบและตรวจโค้ด

```bash
flutter test          # รัน unit test + widget test
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
drift_schemas/    # ประวัติ schema สำหรับทดสอบ migration
test/
```

## 6. ความเป็นส่วนตัว

ข้อมูลทั้งหมดอยู่ในเครื่อง ไม่มีบัญชีผู้ใช้ ไม่มีเซิร์ฟเวอร์ ไม่มี analytics
การเชื่อมต่ออินเทอร์เน็ตเดียวที่จะมีคือการตรวจเวอร์ชันใหม่ (Phase 6)

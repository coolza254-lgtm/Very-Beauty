import 'enums.dart';

/// Default tags inserted on first install. Users can add their own later.
const seedTags = <TagType, List<String>>{
  TagType.symptom: [
    'ระคายเคือง',
    'แสบ',
    'ผิวลอก',
    'ผื่น',
    'สิวขึ้นใหม่',
    'คัน',
  ],
  TagType.factor: [
    'นอนน้อย',
    'เครียด',
    'ตากแดดนาน',
    'อาหารที่สงสัย',
    'ออกกำลังกาย',
    'แต่งหน้าจัด',
  ],
};

/// Default routine templates inserted on first install.
const seedRoutines = <(String, TimeOfDaySlot)>[
  ('เช้า', TimeOfDaySlot.morning),
  ('เย็น', TimeOfDaySlot.evening),
];

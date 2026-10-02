"""Ingredients users reported as missing (from the in-app "no info yet" list)."""
from common import C, E, I, M, S, T

ROWS = [
    I('Melaleuca Alternifolia Leaf Extract', 'สารสกัดใบทีทรี', ['antiAcne', 'soothing'], [C, T, E],
      'สารสกัดจากใบทีทรี (คนละอย่างกับน้ำมันหอมระเหยทีทรี) มีสารต้านเชื้อแบคทีเรียในความเข้มข้นที่อ่อนกว่า',
      good='ช่วยลดเชื้อแบคทีเรียที่เกี่ยวกับสิวและลดการอักเสบ เหมาะกับผิวมันและผิวเป็นสิวง่าย',
      tips='ระคายเคืองน้อยกว่าน้ำมันทีทรี แต่ผิวแพ้ง่ายมากควรทดสอบก่อน',
      aka=['Tea Tree Leaf Extract', 'Melaleuca Alternifolia (Tea Tree) Leaf Extract', 'ทีทรี'],
      en='Tea tree leaf extract; anti-blemish', kind='extract'),
    I('Nylon-6', 'ไนลอน-6', 'absorbent', [S, M], 'ผงไนลอนทรงกลมละเอียด ช่วยเบลอรูขุมขน ลดความมันวาว และให้สัมผัสนุ่มแห้ง',
      en='Soft-focus nylon powder', kind='polymer'),
    I('Nylon-6/12', 'ไนลอน-6/12', 'absorbent', [S, M], 'ผงไนลอนชนิดโคพอลิเมอร์ (ไนลอน-6 ผสมไนลอน-12) ใช้ดูดซับความมันและทำให้ผิวดูเนียนแมตต์ พบบ่อยในกันแดดเนื้อแมตต์และแป้ง',
      en='Mattifying nylon copolymer powder', kind='polymer'),
    I('Polylysine', 'โพลีไลซีน', 'preservative', [M, E, T],
      'พอลิเมอร์ของกรดอะมิโนไลซีน (ε-polylysine) ที่ได้จากการหมักจุลินทรีย์ ใช้เป็นสารกันเสียจากธรรมชาติ (ใช้ในอาหารญี่ปุ่นด้วย)',
      good='ช่วยยับยั้งเชื้อแบคทีเรียและยีสต์ในสูตร ทำให้ใช้สารกันเสียสังเคราะห์น้อยลง',
      aka=['ε-Polylysine', 'Epsilon-Polylysine'], en='Natural amino-acid based preservative', kind='polymer'),
]

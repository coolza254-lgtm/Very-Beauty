"""Fragrance, EU-labelled fragrance allergens, essential oils and cooling agents."""
from common import C, E, I, M, S, T

_ALLERGEN = ('สารให้กลิ่นที่พบในน้ำหอมและน้ำมันหอมระเหยหลายชนิด '
             'ตามกฎหมายยุโรปต้องระบุชื่อบนฉลากเมื่อเกินปริมาณที่กำหนด เพราะเป็นสารก่อภูมิแพ้ที่พบบ่อย')
_ALLERGEN_TIPS = 'ถ้าเคยแพ้เครื่องสำอางโดยไม่ทราบสาเหตุ ลองสังเกตว่าผลิตภัณฑ์มีสารนี้หรือไม่ และทดสอบที่ท้องแขนก่อนใช้'
_EO = 'น้ำมันหอมระเหยที่กลั่นจาก'
_EO_TIPS = 'ให้กลิ่นหอมและอาจมีฤทธิ์อ่อนๆ ต่อผิว แต่มีสารก่อภูมิแพ้ตามธรรมชาติ ผิวแพ้ง่ายควรหลีกเลี่ยง'


def allergen(inci, th, smell, smi=None, f=None, aka=(), use=(C, M)):
    return I(inci, th, 'fragrance', list(use), _ALLERGEN + ' (กลิ่น' + smell + ')', tips=_ALLERGEN_TIPS, aka=aka,
             note='allergen', en='EU-labelled fragrance allergen', smi=smi, f=f)


def eo(inci, th, source, extra='', aka=(), use=(C, M), note='essential', fn='fragrance'):
    return I(inci, th, fn, list(use), _EO + source + extra, tips=_EO_TIPS, aka=aka, note=note, en='Essential oil', kind='extract')


ROWS = [
    I('Parfum', 'น้ำหอม', 'fragrance', [C, S, M, E, T],
      'ส่วนผสมของสารให้กลิ่นหลายสิบชนิดที่ไม่ต้องเปิดเผยสูตร (ความลับทางการค้า) อาจมาจากธรรมชาติหรือสังเคราะห์',
      good='ทำให้ผลิตภัณฑ์มีกลิ่นหอมน่าใช้', tips='สูตรที่เขียนว่า "fragrance-free" ไม่ใส่น้ำหอม ส่วน "unscented" อาจใส่สารกลบกลิ่น',
      aka=['Fragrance', 'กลิ่น', 'Aroma', 'Perfume'], note='fragrance', en='Undisclosed fragrance blend', kind='mixture'),
    allergen('Linalool', 'ลินาลูล', 'ดอกไม้ ลาเวนเดอร์', 'CC(C)=CCCC(C)(O)C=C', 'C10H18O', use=(C, S, M)),
    allergen('Limonene', 'ลิโมนีน', 'ส้ม', 'CC1=CCC(CC1)C(C)=C', 'C10H16', use=(C, S, M)),
    allergen('Citronellol', 'ซิโทรเนลลอล', 'กุหลาบ', 'CC(C)=CCCC(C)CCO', 'C10H20O'),
    allergen('Geraniol', 'เจอรานิออล', 'กุหลาบ เจอเรเนียม', 'CC(C)=CCC/C(C)=C/CO', 'C10H18O'),
    allergen('Citral', 'ซิทรัล', 'มะนาว ตะไคร้', 'CC(C)=CCC/C(C)=C/C=O', 'C10H16O'),
    allergen('Eugenol', 'ยูจีนอล', 'กานพลู', 'COc1cc(CC=C)ccc1O', 'C10H12O2'),
    allergen('Isoeugenol', 'ไอโซยูจีนอล', 'กานพลู', 'C/C=C/c1ccc(O)c(OC)c1', 'C10H12O2'),
    allergen('Coumarin', 'คูมาริน', 'หญ้าแห้ง วานิลลา', 'O=c1ccc2ccccc2o1', 'C9H6O2'),
    allergen('Hexyl Cinnamal', 'เฮกซิลซินนามัล', 'ดอกมะลิ', 'CCCCCC/C(=C/c1ccccc1)C=O', 'C15H20O'),
    allergen('Amyl Cinnamal', 'อะมิลซินนามัล', 'ดอกมะลิ', 'CCCCC/C(=C/c1ccccc1)C=O', 'C14H18O'),
    allergen('Cinnamal', 'ซินนามัล', 'อบเชย', 'O=C/C=C/c1ccccc1', 'C9H8O'),
    allergen('Cinnamyl Alcohol', 'ซินนามิลแอลกอฮอล์', 'อบเชย ดอกไฮยาซินธ์', 'OC/C=C/c1ccccc1', 'C9H10O'),
    allergen('Benzyl Salicylate', 'เบนซิลซาลิไซเลต', 'ดอกไม้หวานๆ', 'O=C(OCc1ccccc1)c1ccccc1O', 'C14H12O3', use=(C, S, M)),
    allergen('Benzyl Benzoate', 'เบนซิลเบนโซเอต', 'บัลซัมอ่อนๆ', 'O=C(OCc1ccccc1)c1ccccc1', 'C14H12O2'),
    allergen('Benzyl Cinnamate', 'เบนซิลซินนาเมต', 'บัลซัม', 'O=C(/C=C/c1ccccc1)OCc1ccccc1', 'C16H14O2'),
    allergen('Anise Alcohol', 'แอนิสแอลกอฮอล์', 'โป๊ยกั๊ก', 'COc1ccc(CO)cc1', 'C8H10O2'),
    allergen('Farnesol', 'ฟาร์นีซอล', 'ดอกไม้', 'CC(C)=CCC/C(C)=C/CC/C(C)=C/CO', 'C15H26O'),
    allergen('Hydroxycitronellal', 'ไฮดรอกซีซิโทรเนลลัล', 'ดอกลิลลี่', 'CC(CCCC(C)(C)O)CC=O', 'C10H20O2'),
    allergen('Alpha-Isomethyl Ionone', 'อัลฟาไอโซเมทิลไอโอโนน', 'ดอกไวโอเล็ต', 'CC(=O)C(C)=CC1C(C)=CCCC1(C)C', 'C14H22O'),
    I('Butylphenyl Methylpropional', 'ลิเลียล', 'fragrance', [C, M], 'สารให้กลิ่นดอกลิลลี่ที่ EU ห้ามใช้ตั้งแต่ปี 2022 เพราะอาจเป็นพิษต่อระบบสืบพันธุ์',
      aka=['Lilial'], note='allergen', en='Banned in the EU since 2022',
      smi='CC(Cc1ccc(cc1)C(C)(C)C)C=O', f='C14H20O'),
    I('Evernia Prunastri Extract', 'สารสกัดโอ๊คมอส', 'fragrance', [M], 'สารสกัดจากไลเคนโอ๊คมอส ให้กลิ่นป่าไม้ เป็นสารก่อภูมิแพ้ที่รุนแรง', aka=['Oakmoss'],
      note='allergen', en='Oakmoss (strong allergen)', kind='extract'),
    I('Vanillin', 'วานิลลิน', 'fragrance', [M], 'สารให้กลิ่นวานิลลา', aka=['vanilla', 'วานิลลา'], en='Vanilla scent',
      smi='COc1cc(C=O)ccc1O', f='C8H8O3'),
    # ---------- Essential oils ----------
    eo('Lavandula Angustifolia Oil', 'น้ำมันลาเวนเดอร์', 'ดอกลาเวนเดอร์ มีลินาลูลและลินาลิลอะซิเตต', ' ช่วยให้ผ่อนคลาย', aka=['Lavender Oil', 'ลาเวนเดอร์']),
    eo('Citrus Aurantium Dulcis Peel Oil', 'น้ำมันผิวส้ม', 'ผิวส้ม มีลิโมนีนสูง', aka=['Orange Peel Oil', 'ส้ม']),
    eo('Citrus Limon Peel Oil', 'น้ำมันผิวมะนาว', 'ผิวเลมอน', note='citrus', aka=['Lemon Peel Oil', 'เลมอน']),
    eo('Citrus Aurantium Bergamia Fruit Oil', 'น้ำมันเบอร์กาม็อต', 'ผิวส้มเบอร์กาม็อต', note='citrus', aka=['Bergamot Oil']),
    eo('Citrus Paradisi Peel Oil', 'น้ำมันผิวเกรปฟรุต', 'ผิวเกรปฟรุต', note='citrus', aka=['Grapefruit Oil']),
    eo('Citrus Aurantium Amara Flower Oil', 'น้ำมันเนโรลี', 'ดอกส้มขม', aka=['Neroli Oil']),
    eo('Mentha Piperita Oil', 'น้ำมันเปปเปอร์มินต์', 'ใบเปปเปอร์มินต์ มีเมนทอลสูง ให้ความเย็น', aka=['Peppermint Oil'], note='menthol'),
    eo('Eucalyptus Globulus Leaf Oil', 'น้ำมันยูคาลิปตัส', 'ใบยูคาลิปตัส ให้กลิ่นสดชื่น', aka=['Eucalyptus Oil']),
    eo('Rosmarinus Officinalis Leaf Oil', 'น้ำมันโรสแมรี่', 'ใบโรสแมรี่', aka=['Rosemary Oil']),
    eo('Pelargonium Graveolens Oil', 'น้ำมันเจอเรเนียม', 'ใบเจอเรเนียม กลิ่นคล้ายกุหลาบ', aka=['Geranium Oil']),
    eo('Rosa Damascena Flower Oil', 'น้ำมันกุหลาบ', 'ดอกกุหลาบดามัสก์ ราคาสูงมาก', aka=['Rose Oil', 'กุหลาบ']),
    eo('Cymbopogon Citratus Leaf Oil', 'น้ำมันตะไคร้', 'ใบตะไคร้ มีซิทรัลสูง', aka=['Lemongrass Oil', 'ตะไคร้']),
    eo('Cymbopogon Nardus Oil', 'น้ำมันตะไคร้หอม', 'ตะไคร้หอม (ซิโทรเนลลา) ใช้กันยุง', aka=['Citronella Oil', 'ตะไคร้หอม']),
    eo('Cananga Odorata Flower Oil', 'น้ำมันกระดังงา (อีลางอีลาง)', 'ดอกกระดังงา', aka=['Ylang Ylang Oil', 'กระดังงา']),
    eo('Santalum Album Oil', 'น้ำมันไม้จันทน์', 'แก่นไม้จันทน์หอม', aka=['Sandalwood Oil', 'ไม้จันทน์']),
    eo('Boswellia Carterii Oil', 'น้ำมันกำยานแฟรงคินเซนส์', 'ยางไม้แฟรงคินเซนส์', aka=['Frankincense Oil']),
    eo('Cedrus Atlantica Bark Oil', 'น้ำมันซีดาร์วูด', 'เปลือกไม้ซีดาร์', aka=['Cedarwood Oil']),
    eo('Jasminum Officinale Oil', 'น้ำมันมะลิ', 'ดอกมะลิ', aka=['Jasmine Oil', 'มะลิ']),
    eo('Melaleuca Alternifolia Leaf Oil', 'น้ำมันทีทรี', 'ใบทีทรี มีเทอร์พิเนน-4-ออลที่ต้านเชื้อแบคทีเรีย',
       ' งานวิจัยพบว่าเจล 5% ช่วยลดสิวได้แต่ช้ากว่าเบนโซอิลเปอร์ออกไซด์', aka=['Tea Tree Oil', 'ทีทรี'], use=(C, T), fn=['antiAcne', 'fragrance']),
    # ---------- Cooling agents ----------
    I('Menthol', 'เมนทอล', ['other', 'fragrance'], [C, T], 'สารจากสะระแหน่/เปปเปอร์มินต์ที่กระตุ้นตัวรับความเย็นบนผิว ให้ความรู้สึกเย็นสดชื่น',
      note='menthol', en='Cooling agent', smi='CC(C)C1CCC(C)CC1O', f='C10H20O'),
    I('Menthyl Lactate', 'เมนทิลแลคเตต', 'other', [C, T, M], 'สารให้ความเย็นที่อ่อนโยนกว่าเมนทอลและแทบไม่มีกลิ่น', en='Gentle cooling agent',
      smi='CC(O)C(=O)OC1CC(C)CCC1C(C)C', f='C13H24O3'),
    I('Camphor', 'การบูร', ['other', 'fragrance'], [C], 'สารให้ความเย็นและกลิ่นฉุน', note='menthol', aka=['การบูร'], en='Camphor',
      smi='CC1(C)C2CCC1(C)C(=O)C2', f='C10H16O'),
    I('Eucalyptol', 'ยูคาลิปตอล', 'fragrance', [C], 'สารให้กลิ่นหลักของยูคาลิปตัส ให้ความสดชื่น', aka=['1,8-Cineole'], en='Eucalyptus scent compound',
      smi='CC12CCC(CC1)C(C)(C)O2', f='C10H18O'),
]

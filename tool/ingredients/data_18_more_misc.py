"""More preservatives, minerals/salts, colorants and fragrance compounds."""
from common import ALL, C, E, I, M, S, T

_PRES = 'สารกันเสีย/ต้านเชื้อจุลินทรีย์ ช่วยให้ผลิตภัณฑ์ปลอดภัยตลอดอายุการใช้งาน'
_SALT = 'เกลือแร่ที่ใช้ปรับเนื้อสัมผัส ความคงตัว หรือเติมแร่ธาตุให้ผิว'
_PIG = 'เม็ดสีที่ใช้ในเครื่องสำอาง'
_DYE = 'สีสังเคราะห์ที่ใช้แต่งสีผลิตภัณฑ์'
_FRAG = 'สารให้กลิ่นที่พบในน้ำหอมและน้ำมันหอมระเหย'


def frag(inci, th, smell, smi=None, f=None, note='allergen', aka=()):
    return I(inci, th, 'fragrance', [C, M], _FRAG + ' (กลิ่น' + smell + ')', aka=aka, note=note, en='Fragrance compound', smi=smi, f=f)


ROWS = [
    # ---------- Preservatives & antimicrobials ----------
    I('Chlorhexidine Digluconate', 'คลอร์เฮกซิดีนไดกลูโคเนต', ['preservative', 'antiAcne'], [C, T], _PRES + ' ฤทธิ์ฆ่าเชื้อแรง ใช้ในน้ำยาฆ่าเชื้อด้วย', en='Antiseptic preservative'),
    I('Benzalkonium Chloride', 'เบนซัลโคเนียมคลอไรด์', 'preservative', [C, T], _PRES + ' ประจุบวก ใช้ในน้ำยาฆ่าเชื้อ', note='sensitize', en='Quaternary antiseptic', kind='mixture'),
    I('Cetylpyridinium Chloride', 'ซีทิลไพริดิเนียมคลอไรด์', 'preservative', [C], _PRES, en='Antiseptic', smi='CCCCCCCCCCCCCCCC[n+]1ccccc1.[Cl-]', f='C21H38ClN'),
    I('Ethyl Lauroyl Arginate HCl', 'เอทิลลอรอยล์อาร์จิเนต', 'preservative', [C, M], _PRES + ' จากกรดอะมิโนอาร์จินีน ใช้ในอาหารด้วย', aka=['LAE'], en='Amino-acid based preservative'),
    I('Undecylenic Acid', 'กรดอันเดซิลีนิก', ['preservative', 'antiAcne'], [C, M], 'กรดไขมันจากน้ำมันละหุ่ง ต้านเชื้อราได้ดี', en='Antifungal fatty acid',
      smi='C=CCCCCCCCCC(=O)O', f='C11H20O2'),
    I('Sodium Salicylate', 'โซเดียมซาลิไซเลต', ['preservative', 'exfoliant'], [C, M], 'เกลือของกรดซาลิไซลิก ใช้เป็นสารกันเสีย', en='Salicylate preservative',
      smi='[Na+].[O-]C(=O)c1ccccc1O', f='C7H5NaO3'),
    I('Benzisothiazolinone', 'เบนซิโซไทอะโซลิโนน', 'preservative', [C], _PRES, note='mit', en='Isothiazolinone preservative', smi='O=c1[nH]sc2ccccc12', f='C7H5NOS'),
    I('Quaternium-15', 'ควอเทอร์เนียม-15', 'preservative', [C], _PRES, note='formaldehyde', en='Formaldehyde releaser'),
    I('Climbazole', 'ไคลมบาโซล', ['preservative', 'antiAcne'], [C], 'สารต้านเชื้อรา นิยมในแชมพูขจัดรังแค', en='Antifungal'),
    I('Zinc Pyrithione', 'ซิงค์ไพริไทโอน', ['preservative', 'antiAcne'], [C], 'สารต้านเชื้อราที่ใช้ในแชมพูขจัดรังแคและสบู่สำหรับสิวจากเชื้อรา', en='Antifungal (dandruff)'),
    I('Chloroxylenol', 'คลอโรไซลีนอล', 'preservative', [C], _PRES + ' ใช้ในสบู่ฆ่าเชื้อ', aka=['PCMX'], en='Antiseptic', smi='Cc1cc(O)cc(C)c1Cl', f='C8H9ClO'),
    I('Silver Citrate', 'ซิลเวอร์ซิเตรต', 'preservative', [C, T], _PRES + ' จากไอออนเงิน', en='Silver preservative'),
    I('Lactic Acid/Glycolic Acid Copolymer', 'กรดแลคติก/ไกลโคลิกโคพอลิเมอร์', 'filmFormer', [E], 'พอลิเมอร์ย่อยสลายได้ ใช้ทำแคปซูลห่อหุ้มสารสำคัญ', aka=['PLGA'], en='Encapsulating polymer',
      kind='polymer'),
    I('Hydrogen Peroxide', 'ไฮโดรเจนเปอร์ออกไซด์', ['antiAcne', 'other'], [C], 'สารออกซิไดซ์ที่ฆ่าเชื้อและฟอกสี ใช้ปริมาณน้อยมากในเครื่องสำอาง', note='sensitize',
      en='Oxidiser/antiseptic', smi='OO', f='H2O2'),
    # ---------- Minerals & salts ----------
    I('Magnesium Sulfate', 'แมกนีเซียมซัลเฟต', ['thickener', 'other'], [M, C], _SALT + ' (ดีเกลือ) ช่วยให้ครีมน้ำในน้ำมันคงตัว', aka=['Epsom Salt'], en='Epsom salt; stabiliser',
      kind='mineral', f='MgSO4'),
    I('Magnesium Chloride', 'แมกนีเซียมคลอไรด์', ['humectant', 'other'], [M, T], _SALT, en='Mineral salt', kind='mineral', f='MgCl2'),
    I('Potassium Chloride', 'โพแทสเซียมคลอไรด์', ['thickener', 'other'], [C, T], _SALT, en='Mineral salt', kind='mineral', f='KCl'),
    I('Calcium Chloride', 'แคลเซียมคลอไรด์', 'other', [M, T], _SALT, en='Mineral salt', kind='mineral', f='CaCl2'),
    I('Zinc Chloride', 'ซิงค์คลอไรด์', ['antiAcne', 'other'], [T, C], _SALT + ' ช่วยกระชับและต้านเชื้อ', en='Astringent salt', kind='mineral', f='ZnCl2'),
    I('Calcium Gluconate', 'แคลเซียมกลูโคเนต', ['humectant', 'barrier'], [M, E], 'เกลือแคลเซียมที่ช่วยกระบวนการสร้างเกราะผิว', en='Calcium salt for the barrier'),
    I('Manganese Gluconate', 'แมงกานีสกลูโคเนต', 'antioxidant', [E], 'เกลือแร่แมงกานีสที่ช่วยกระบวนการต้านอนุมูลอิสระของเซลล์', en='Mineral salt'),
    I('Sodium Silicate', 'โซเดียมซิลิเกต', 'phAdjuster', [C], _SALT + ' (ด่าง) ใช้ในสบู่', en='Alkaline salt', kind='mineral'),
    I('Aluminum Chlorohydrate', 'อะลูมิเนียมคลอโรไฮเดรต', 'other', [M], 'สารลดเหงื่อในโรลออนและสเปรย์ระงับกลิ่นกาย', en='Antiperspirant', kind='mineral'),
    I('Potassium Alum', 'สารส้ม', ['other', 'antiAcne'], [C, T], 'สารส้ม ช่วยระงับกลิ่นกายและกระชับผิว', aka=['Alum', 'สารส้ม'], en='Alum', kind='mineral'),
    I('Barium Sulfate', 'แบเรียมซัลเฟต', ['absorbent', 'colorant'], [M], 'ผงแร่สีขาวที่ใช้ปรับความทึบของเครื่องสำอาง', aka=['CI 77120'], en='White filler', kind='mineral', f='BaSO4'),
    I('Hydroxyapatite', 'ไฮดรอกซีอะพาไทต์', 'absorbent', [M], 'แร่แคลเซียมฟอสเฟตชนิดเดียวกับในฟันและกระดูก ใช้ดูดซับความมัน', en='Calcium phosphate mineral', kind='mineral'),
    I('Diamond Powder', 'ผงเพชร', 'colorant', [M], 'ผงเพชรละเอียด ให้ประกาย ส่วนใหญ่เพื่อความหรูหรา', en='Diamond powder (shimmer)', kind='mineral', f='C'),
    I('Tourmaline', 'ทัวร์มาลีน', 'other', [M], 'ผงแร่ทัวร์มาลีน มักอ้างเรื่องพลังงาน แต่หลักฐานทางวิทยาศาสตร์จำกัด', en='Tourmaline powder', kind='mineral'),
    I('Volcanic Ash', 'เถ้าภูเขาไฟ', ['absorbent', 'exfoliant'], [C], 'เถ้าภูเขาไฟละเอียด (เช่น เกาะเชจู) ดูดซับความมันและสิ่งสกปรก', aka=['Jeju Volcanic'], en='Volcanic ash',
      kind='mineral'),
    I('Sericite', 'เซริไซต์', ['absorbent', 'colorant'], [M], 'ไมกาชนิดละเอียด ให้สัมผัสนุ่มลื่นในแป้ง', en='Fine mica', kind='mineral'),
    # ---------- Colorants ----------
    I('CI 15985', 'สีเหลืองซันเซ็ต', 'colorant', [C, T], _DYE + ' สีส้มเหลือง', aka=['Yellow 6', 'Sunset Yellow'], en='Yellow-orange dye'),
    I('CI 17200', 'สีแดง D&C Red 33', 'colorant', [C, T], _DYE + ' สีแดงชมพู', aka=['Red 33'], en='Red dye'),
    I('CI 45410', 'สีแดง D&C Red 28', 'colorant', [M], _DYE + ' สีชมพู', aka=['Red 28', 'Phloxine B'], en='Pink dye'),
    I('CI 15850', 'สีแดงลิโทล (Red 6/7)', 'colorant', [M], _PIG + ' สีแดง', aka=['Red 6', 'Red 7'], en='Red pigment'),
    I('CI 77742', 'แมงกานีสไวโอเล็ต', 'colorant', [M], _PIG + ' สีม่วง', aka=['Manganese Violet'], en='Violet pigment', kind='mineral'),
    I('CI 77510', 'เฟอร์ริกเฟอร์โรไซยาไนด์', 'colorant', [M], _PIG + ' สีน้ำเงิน', aka=['Ferric Ferrocyanide', 'Prussian Blue'], en='Blue pigment', kind='mineral'),
    I('CI 77288', 'โครเมียมออกไซด์กรีน', 'colorant', [M], _PIG + ' สีเขียว', aka=['Chromium Oxide Greens'], en='Green pigment', kind='mineral'),
    I('CI 77289', 'โครเมียมไฮดรอกไซด์กรีน', 'colorant', [M], _PIG + ' สีเขียวอมฟ้า', aka=['Chromium Hydroxide Green'], en='Green pigment', kind='mineral'),
    I('CI 75120', 'สีแอนแนตโต', 'colorant', [M], _PIG + ' สีส้มจากเมล็ดคำแสด', aka=['Annatto', 'คำแสด'], en='Natural orange colour', kind='extract'),
    I('Calcium Sodium Borosilicate', 'แคลเซียมโซเดียมโบโรซิลิเกต', 'colorant', [M], 'เกล็ดแก้วบางที่เคลือบให้มีประกาย (glitter)', en='Glass flake shimmer', kind='mineral'),
    I('Calcium Aluminum Borosilicate', 'แคลเซียมอะลูมิเนียมโบโรซิลิเกต', 'colorant', [M], 'เกล็ดแก้วบางที่ให้ประกายวิบวับ', en='Glass flake shimmer', kind='mineral'),
    I('Capsanthin/Capsorubin', 'สีแดงจากพริกหวาน', 'colorant', [M], 'สีแดงส้มธรรมชาติจากพริกหวาน', aka=['Paprika Extract'], en='Natural red colour', kind='extract'),
    # ---------- Fragrance compounds ----------
    frag('Amylcinnamyl Alcohol', 'อะมิลซินนามิลแอลกอฮอล์', 'ดอกไม้', 'CCCCC/C(=C\\c1ccccc1)CO', 'C14H20O'),
    frag('Methyl 2-Octynoate', 'เมทิลออกไทโนเอต', 'ใบไวโอเล็ต', 'CCCCCC#CC(=O)OC', 'C9H14O2'),
    frag('Hydroxyisohexyl 3-Cyclohexene Carboxaldehyde', 'ไลรัล', 'ดอกลิลลี่ — EU ห้ามใช้แล้ว'),
    I('Evernia Furfuracea Extract', 'สารสกัดทรีมอส', 'fragrance', [M], _FRAG + ' (กลิ่นป่าไม้) ก่อการแพ้รุนแรง', aka=['Treemoss'], note='allergen', en='Treemoss (strong allergen)',
      kind='extract'),
    frag('Benzaldehyde', 'เบนซัลดีไฮด์', 'อัลมอนด์', 'O=Cc1ccccc1', 'C7H6O', note=None),
    frag('Carvone', 'คาร์โวน', 'มินต์', 'CC(=C)C1CC=C(C)C(=O)C1', 'C10H14O'),
    frag('Pinene', 'พินีน', 'สน', 'CC1=CCC2CC1C2(C)C', 'C10H16'),
    frag('Terpineol', 'เทอร์พินีออล', 'ไลแลค', 'CC1=CCC(CC1)C(C)(C)O', 'C10H18O'),
    frag('Linalyl Acetate', 'ลินาลิลอะซิเตต', 'ลาเวนเดอร์ เบอร์กาม็อต', 'CC(=O)OC(C)(CCC=C(C)C)C=C', 'C12H20O2'),
    frag('Geranyl Acetate', 'เจอรานิลอะซิเตต', 'กุหลาบ ผลไม้', 'CC(=O)OC/C=C(\\C)CCC=C(C)C', 'C12H20O2'),
    frag('Citronellal', 'ซิโทรเนลลัล', 'ตะไคร้หอม', 'CC(CC=O)CCC=C(C)C', 'C10H18O'),
    frag('Ethylene Brassylate', 'เอทิลีนบราสซิเลต', 'มัสก์', 'O=C1CCCCCCCCCCCC(=O)OCCO1', 'C15H26O4', note=None),
    frag('Galaxolide', 'กาแลกโซไลด์', 'มัสก์'),
    frag('Iso E Super', 'ไอโซอีซุปเปอร์', 'ไม้ซีดาร์'),
    frag('Ethyl Vanillin', 'เอทิลวานิลลิน', 'วานิลลา', 'CCOc1cc(C=O)ccc1O', 'C9H10O3', note=None),
    I('Phenoxyisopropanol', 'ฟีนอกซีไอโซโพรพานอล', ['preservative', 'solvent'], [C, M], _PRES + ' คล้ายฟีนอกซีเอทานอล', en='Preservative',
      smi='CC(O)COc1ccccc1', f='C9H12O2'),
]

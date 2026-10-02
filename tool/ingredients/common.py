"""Shared helpers for the ingredient data modules.

Each data module defines ROWS, a list built with I(...). Text fields are Thai
(the app's main language) except `en`, a one-line English summary.
"""

C, S, M, E, T = 'cleanser', 'sunscreen', 'moisturizer', 'serum', 'toner'
ALL = [C, S, M, E, T]

# Caution notes (Thai, English) referenced by key.
NOTES = {
    'harsh': ('ทำความสะอาดแรง อาจทำให้ผิวแห้งตึงหรือระคายเคืองในผิวแพ้ง่าย',
              'Strong cleanser; may dry or irritate sensitive skin'),
    'acid': ('กรดผลัดเซลล์ อาจแสบหรือทำให้ผิวไวต่อแดด ควรทากันแดดทุกวันและไม่ควรใช้ซ้อนกับกรดหลายตัว',
             'Exfoliating acid; may sting and increase sun sensitivity — wear sunscreen, avoid stacking acids'),
    'retinoid': ('อาจทำให้ผิวลอก แดง แสบ และไวต่อแดด ควรเริ่มทีละน้อยตอนกลางคืน และหลีกเลี่ยงระหว่างตั้งครรภ์/ให้นมบุตร',
                 'May cause peeling, redness and sun sensitivity; start slowly at night; avoid in pregnancy/breastfeeding'),
    'bpo': ('อาจทำให้ผิวแห้ง ลอก แสบ และฟอกสีผ้าขนหนู/ปลอกหมอนให้ซีดได้',
            'May dry, peel or sting, and bleaches towels and pillowcases'),
    'fragrance': ('สารแต่งกลิ่นเป็นสาเหตุของการแพ้เครื่องสำอางที่พบบ่อย ผิวแพ้ง่ายควรเลือกสูตรไม่มีน้ำหอม',
                  'Fragrance is a common cause of cosmetic allergy; sensitive skin may prefer fragrance-free'),
    'allergen': ('เป็นสารแต่งกลิ่นที่ EU กำหนดให้ระบุบนฉลากเพราะก่อการแพ้ได้ โดยเฉพาะเมื่อถูกออกซิไดซ์',
                 'EU-labelled fragrance allergen, especially once oxidised'),
    'essential': ('น้ำมันหอมระเหยมีสารแต่งกลิ่นธรรมชาติหลายตัว อาจระคายเคืองหรือแพ้ในผิวแพ้ง่าย',
                  'Essential oil with natural fragrance compounds; may irritate sensitive skin'),
    'citrus': ('น้ำมันจากผิวส้มบางชนิดมีสารที่ทำให้ผิวไวต่อแสง (photosensitizing) หลีกเลี่ยงการใช้ก่อนออกแดด',
               'Some citrus peel oils are photosensitising; avoid before sun exposure'),
    'alcohol': ('ช่วยให้เนื้อบางเบาแห้งไวและซึมเร็ว แต่ถ้าอยู่ลำดับต้นๆ อาจทำให้ผิวแห้งหรือแสบในผิวแพ้ง่าย',
                'Light and quick-drying; high up the list it may dry or sting sensitive skin'),
    'mit': ('สารกันเสียที่พบการแพ้สัมผัสได้บ่อย EU อนุญาตเฉพาะในผลิตภัณฑ์ที่ล้างออก',
            'Preservative with frequent contact allergy; EU allows it only in rinse-off products'),
    'formaldehyde': ('ค่อยๆ ปลดปล่อยฟอร์มาลดีไฮด์ปริมาณน้อยเพื่อกันเสีย อาจระคายเคืองหรือแพ้ในบางคน',
                     'Slowly releases small amounts of formaldehyde; may irritate or sensitise'),
    'reef': ('บางพื้นที่ (เช่น ฮาวาย ปาเลา) จำกัดการใช้เพราะประเด็นแนวปะการัง และบางคนแพ้ได้',
             'Restricted in some places (e.g. Hawaii, Palau) over reef concerns; some people react to it'),
    'menthol': ('ให้ความรู้สึกเย็นซ่า แต่ระคายเคืองผิวแพ้ง่ายได้',
                'Cooling sensation; can irritate sensitive skin'),
    'comedo': ('เนื้อค่อนข้างหนัก อาจอุดตันรูขุมขนในผิวที่เป็นสิวง่าย',
               'Rich; may clog pores in acne-prone skin'),
    'hydroquinone': ('ใช้ได้เฉพาะตามแพทย์สั่ง ใช้นานเกินไปอาจทำให้เกิดฝ้าดำถาวร (ochronosis) ไทยห้ามใช้ในเครื่องสำอาง',
                     'Prescription only; long use can cause ochronosis; banned in cosmetics in Thailand'),
    'pregnancy': ('ผู้ที่ตั้งครรภ์หรือให้นมบุตรควรปรึกษาแพทย์ก่อนใช้',
                  'If pregnant or breastfeeding, ask a doctor first'),
    'sensitize': ('มีรายงานการแพ้สัมผัส ควรทดสอบที่ท้องแขนก่อนใช้',
                  'Contact allergy has been reported; patch test first'),
    'stain': ('อาจทำให้ผิว/เสื้อผ้าเปลี่ยนสี และเสื่อมสภาพเร็วเมื่อโดนแสง/อากาศ',
              'May discolour skin or fabric and degrades with light and air'),
}

_FN = {'surfactant', 'uvChemical', 'uvMineral', 'humectant', 'emollient',
       'occlusive', 'barrier', 'brightening', 'antioxidant', 'exfoliant',
       'antiAcne', 'retinoid', 'antiAging', 'soothing', 'absorbent',
       'filmFormer', 'emulsifier', 'thickener', 'preservative', 'chelating',
       'phAdjuster', 'solvent', 'fragrance', 'colorant', 'other'}

# Why an ingredient has no single structure.
KINDS = {'polymer', 'extract', 'oil', 'mixture', 'mineral', 'protein',
         'ferment', 'peptide', 'water'}


def I(inci, th, fn, use, what, *, aka=(), good=None, tips=None, note=None,
      en=None, smi=None, f=None, kind=None):
    """One ingredient.

    fn   -- function code or list of codes (first is the main one)
    use  -- product categories it is common in
    what -- what it is; good -- what it does; tips -- how to use
    note -- key of NOTES, or a (thai, english) tuple
    smi  -- SMILES of a representative structure; f -- expected formula
    kind -- why there is no single structure (see KINDS)
    """
    fns = [fn] if isinstance(fn, str) else list(fn)
    for x in fns:
        assert x in _FN, (inci, x)
    assert kind is None or kind in KINDS, (inci, kind)
    assert not (smi and kind), inci
    return dict(inci=inci, th=th, fn=fns, use=list(use), what=what,
                aka=list(aka), good=good, tips=tips, note=note, en=en,
                smi=smi, f=f, kind=kind)

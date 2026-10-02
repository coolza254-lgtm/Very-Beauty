"""Builds assets/data/ingredients.json from the data_*.py modules.

    pip install rdkit
    python3 tool/ingredients/build.py

For every SMILES it checks the expected formula (when given) and computes a
2D layout so the app can draw the structure offline.
"""
import importlib
import json
import math
import pathlib
import sys

from rdkit import Chem, RDLogger
from rdkit.Chem import Descriptors, rdDepictor
from rdkit.Chem.rdMolDescriptors import CalcMolFormula

from common import ALL, NOTES

RDLogger.DisableLog('rdApp.*')
HERE = pathlib.Path(__file__).parent
OUT = HERE.parent.parent / 'assets' / 'data' / 'ingredients.json'
MODULES = sorted(p.stem for p in HERE.glob('data_*.py'))

FUNCS = ['surfactant', 'uvChemical', 'uvMineral', 'humectant', 'emollient',
         'occlusive', 'barrier', 'brightening', 'antioxidant', 'exfoliant',
         'antiAcne', 'retinoid', 'antiAging', 'soothing', 'absorbent',
         'filmFormer', 'emulsifier', 'thickener', 'preservative', 'chelating',
         'phAdjuster', 'solvent', 'fragrance', 'colorant', 'other']


def layout(mol):
    """Lays out each fragment (e.g. an anion and its Na+) on its own and places
    them side by side, so counter-ions never overlap the main molecule."""
    frags = Chem.GetMolFrags(mol, asMols=True, sanitizeFrags=True)
    frags = sorted(frags, key=lambda m: -m.GetNumAtoms())
    atoms, bonds, x0 = [], [], 0.0
    parts = [_layout_one(Chem.Mol(f)) for f in frags]
    height = max((max((a[1] for a in fa), default=0) for fa, _ in parts), default=0)
    for fa, fb in parts:
        offset = len(atoms)
        w = max((a[0] for a in fa), default=0)
        h = max((a[1] for a in fa), default=0)
        dy = (height - h) / 2
        for a in fa:
            atoms.append([round(a[0] + x0, 2), round(a[1] + dy, 2)] + a[2:])
        for b in fb:
            bonds.append([b[0] + offset, b[1] + offset] + b[2:])
        x0 += w + (1.9 if len(fa) == 1 else 1.3)
    return atoms, bonds


def _layout_one(mol):
    """Atoms [x, y] (carbon) or [x, y, element, hydrogens, charge] and bonds
    [a, b, order, side]; side tells which way a ring double bond is drawn."""
    rdDepictor.SetPreferCoordGen(True)
    rdDepictor.Compute2DCoords(mol)
    Chem.Kekulize(mol, clearAromaticFlags=True)
    conf = mol.GetConformer()
    pts = [conf.GetAtomPosition(i) for i in range(mol.GetNumAtoms())]
    lengths = [(pts[b.GetBeginAtomIdx()] - pts[b.GetEndAtomIdx()]).Length()
               for b in mol.GetBonds()]
    unit = sorted(lengths)[len(lengths) // 2] if lengths else 1.0
    xs = [p.x / unit for p in pts]
    ys = [-p.y / unit for p in pts]  # screen y grows downwards
    minx, miny = min(xs), min(ys)
    atoms = []
    for a, x, y in zip(mol.GetAtoms(), xs, ys):
        row = [round(x - minx, 2), round(y - miny, 2)]
        sym, h, q = a.GetSymbol(), a.GetTotalNumHs(), a.GetFormalCharge()
        if sym != 'C' or q or a.GetDegree() == 0:
            row += [sym, h, q]
            while row[-1] == 0 and len(row) > 3:
                row.pop()
        atoms.append(row)
    ring_info = mol.GetRingInfo()
    bonds = []
    for b in mol.GetBonds():
        i, j = b.GetBeginAtomIdx(), b.GetEndAtomIdx()
        order = {Chem.BondType.SINGLE: 1, Chem.BondType.DOUBLE: 2,
                 Chem.BondType.TRIPLE: 3}.get(b.GetBondType(), 1)
        side = 0
        if order == 2 and ring_info.NumBondRings(b.GetIdx()):
            ring = min((r for r in ring_info.AtomRings() if i in r and j in r),
                       key=len)
            cx = sum(xs[k] for k in ring) / len(ring)
            cy = sum(ys[k] for k in ring) / len(ring)
            cross = ((xs[j] - xs[i]) * (cy - ys[i])
                     - (ys[j] - ys[i]) * (cx - xs[i]))
            side = 1 if cross > 0 else -1
        bonds.append([i, j, order, side] if side else [i, j, order])
    return atoms, bonds


def main():
    rows, seen, errors = [], {}, []
    for name in MODULES:
        for r in importlib.import_module(name).ROWS:
            key = r['inci'].lower()
            if key in seen:
                errors.append(f"duplicate {r['inci']} ({seen[key]}, {name})")
            seen[key] = name
            rows.append(r)
    out = []
    for r in rows:
        row = {'inci': r['inci'], 'th': r['th']}
        if r['aka']:
            row['aka'] = r['aka']
        row['fn'] = r['fn']
        row['use'] = r['use']
        for k in ('what', 'good', 'tips', 'en'):
            if r[k]:
                row[k] = r[k]
        if r['note']:
            th, en = NOTES[r['note']] if isinstance(r['note'], str) else r['note']
            row['note'], row['noteEn'] = th, en
        if r['smi']:
            mol = Chem.MolFromSmiles(r['smi'])
            if mol is None:
                errors.append(f"bad SMILES for {r['inci']}")
                continue
            formula = CalcMolFormula(mol)
            if r['f'] and r['f'] != formula:
                errors.append(f"{r['inci']}: formula {formula} != expected {r['f']}")
            row['formula'] = formula
            row['mw'] = round(Descriptors.MolWt(mol), 2)
            atoms, bonds = layout(mol)
            row['mol'] = {'a': atoms, 'b': bonds}
        else:
            if r['f']:
                row['formula'] = r['f']
            if r['kind']:
                row['kind'] = r['kind']
        out.append(row)

    popular = importlib.import_module('popular').POPULAR
    names = {r['inci'] for r in out}
    for cat, items in popular.items():
        assert cat in ALL + ['treatment', 'mask'], cat
        for n in items:
            if n not in names:
                errors.append(f'popular {cat}: unknown {n}')
    if errors:
        print('\n'.join(errors))
        sys.exit(1)
    OUT.write_text(json.dumps({
        'version': 2,
        'source': 'Very Beauty curated reference of skincare ingredients '
                  '(INCI names). General information, not medical advice.',
        'functions': FUNCS,
        'popular': popular,
        'ingredients': out,
    }, ensure_ascii=False, separators=(',', ':')))
    with_mol = sum(1 for r in out if 'mol' in r)
    print(f'{len(out)} ingredients ({with_mol} with structures), '
          f'{OUT.stat().st_size // 1024} KB')
    for cat in ALL:
        print(f"  {cat}: {sum(1 for r in out if cat in r['use'])}")


if __name__ == '__main__':
    sys.path.insert(0, str(HERE))
    main()

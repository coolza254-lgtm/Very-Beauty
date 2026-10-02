# Ingredient database generator

`assets/data/ingredients.json` (bundled with the app, used offline) is generated
from the `data_*.py` modules here. Edit those, then:

```bash
pip install rdkit
python3 tool/ingredients/build.py
```

- One `I(...)` per ingredient: INCI name, Thai name, function(s), product
  categories, and a Thai article (`what` / `good` / `tips`), an English one-liner
  (`en`) and an optional caution (`note`, keys in `common.py`).
- Defined molecules get a SMILES (`smi`) plus the expected formula (`f`); the build
  fails if they disagree, then RDKit lays out the 2D structure the app draws.
  Polymers, extracts, oils and mixtures set `kind` instead.
- `popular.py` lists the quick-add suggestions per product category.

import 'package:flutter/material.dart';

import '../core/db/enums.dart';
import '../core/ingredients/ingredient_db.dart';
import 'l10n/gen/app_localizations.dart';
import 'theme.dart';

/// Localized labels, icons and colours for database enums.
extension EnumLabels on AppLocalizations {
  String category(ProductCategory c) => switch (c) {
    ProductCategory.cleanser => categoryCleanser,
    ProductCategory.toner => categoryToner,
    ProductCategory.serum => categorySerum,
    ProductCategory.moisturizer => categoryMoisturizer,
    ProductCategory.sunscreen => categorySunscreen,
    ProductCategory.treatment => categoryTreatment,
    ProductCategory.mask => categoryMask,
    ProductCategory.other => categoryOther,
  };

  String status(ProductStatus s) => switch (s) {
    ProductStatus.inUse => statusInUse,
    ProductStatus.finished => statusFinished,
    ProductStatus.paused => statusPaused,
    ProductStatus.wishlist => statusWishlist,
  };

  String unit(NetUnit u) => switch (u) {
    NetUnit.g => unitG,
    NetUnit.ml => unitMl,
  };
}

IconData categoryIcon(ProductCategory c) => switch (c) {
  ProductCategory.cleanser => Icons.soap_outlined,
  ProductCategory.toner => Icons.water_drop_outlined,
  ProductCategory.serum => Icons.science_outlined,
  ProductCategory.moisturizer => Icons.spa_outlined,
  ProductCategory.sunscreen => Icons.wb_sunny_outlined,
  ProductCategory.treatment => Icons.healing_outlined,
  ProductCategory.mask => Icons.face_retouching_natural_outlined,
  ProductCategory.other => Icons.category_outlined,
};

Color categoryColor(ProductCategory c) => switch (c) {
  ProductCategory.cleanser => BrandColors.sky,
  ProductCategory.toner => BrandColors.mint,
  ProductCategory.serum => BrandColors.lavender,
  ProductCategory.moisturizer => BrandColors.blush,
  ProductCategory.sunscreen => BrandColors.butter,
  ProductCategory.treatment => BrandColors.petal,
  ProductCategory.mask => BrandColors.mint,
  ProductCategory.other => BrandColors.sky,
};

extension SlotLabels on AppLocalizations {
  String slot(TimeOfDaySlot s) => switch (s) {
    TimeOfDaySlot.morning => slotMorning,
    TimeOfDaySlot.evening => slotEvening,
    TimeOfDaySlot.other => slotOther,
  };
}

(IconData, Color) slotStyle(TimeOfDaySlot s) => switch (s) {
  TimeOfDaySlot.morning => (Icons.wb_sunny_outlined, BrandColors.butter),
  TimeOfDaySlot.evening => (Icons.nightlight_outlined, BrandColors.lavender),
  TimeOfDaySlot.other => (Icons.spa_outlined, BrandColors.blush),
};

extension IngredientLabels on AppLocalizations {
  String ingredientFunction(IngredientFunction f) => switch (f) {
    IngredientFunction.surfactant => ingFnSurfactant,
    IngredientFunction.uvChemical => ingFnUvChemical,
    IngredientFunction.uvMineral => ingFnUvMineral,
    IngredientFunction.humectant => ingFnHumectant,
    IngredientFunction.emollient => ingFnEmollient,
    IngredientFunction.occlusive => ingFnOcclusive,
    IngredientFunction.barrier => ingFnBarrier,
    IngredientFunction.brightening => ingFnBrightening,
    IngredientFunction.antioxidant => ingFnAntioxidant,
    IngredientFunction.exfoliant => ingFnExfoliant,
    IngredientFunction.antiAcne => ingFnAntiAcne,
    IngredientFunction.retinoid => ingFnRetinoid,
    IngredientFunction.antiAging => ingFnAntiAging,
    IngredientFunction.soothing => ingFnSoothing,
    IngredientFunction.absorbent => ingFnAbsorbent,
    IngredientFunction.filmFormer => ingFnFilmFormer,
    IngredientFunction.emulsifier => ingFnEmulsifier,
    IngredientFunction.thickener => ingFnThickener,
    IngredientFunction.preservative => ingFnPreservative,
    IngredientFunction.chelating => ingFnChelating,
    IngredientFunction.phAdjuster => ingFnPhAdjuster,
    IngredientFunction.solvent => ingFnSolvent,
    IngredientFunction.fragrance => ingFnFragrance,
    IngredientFunction.colorant => ingFnColorant,
    IngredientFunction.other => ingFnOther,
  };

  /// One sentence explaining what an ingredient with this role does.
  String ingredientFunctionAbout(IngredientFunction f) => switch (f) {
    IngredientFunction.surfactant => ingFnAboutSurfactant,
    IngredientFunction.uvChemical => ingFnAboutUvChemical,
    IngredientFunction.uvMineral => ingFnAboutUvMineral,
    IngredientFunction.humectant => ingFnAboutHumectant,
    IngredientFunction.emollient => ingFnAboutEmollient,
    IngredientFunction.occlusive => ingFnAboutOcclusive,
    IngredientFunction.barrier => ingFnAboutBarrier,
    IngredientFunction.brightening => ingFnAboutBrightening,
    IngredientFunction.antioxidant => ingFnAboutAntioxidant,
    IngredientFunction.exfoliant => ingFnAboutExfoliant,
    IngredientFunction.antiAcne => ingFnAboutAntiAcne,
    IngredientFunction.retinoid => ingFnAboutRetinoid,
    IngredientFunction.antiAging => ingFnAboutAntiAging,
    IngredientFunction.soothing => ingFnAboutSoothing,
    IngredientFunction.absorbent => ingFnAboutAbsorbent,
    IngredientFunction.filmFormer => ingFnAboutFilmFormer,
    IngredientFunction.emulsifier => ingFnAboutEmulsifier,
    IngredientFunction.thickener => ingFnAboutThickener,
    IngredientFunction.preservative => ingFnAboutPreservative,
    IngredientFunction.chelating => ingFnAboutChelating,
    IngredientFunction.phAdjuster => ingFnAboutPhAdjuster,
    IngredientFunction.solvent => ingFnAboutSolvent,
    IngredientFunction.fragrance => ingFnAboutFragrance,
    IngredientFunction.colorant => ingFnAboutColorant,
    IngredientFunction.other => ingFnAboutOther,
  };
}

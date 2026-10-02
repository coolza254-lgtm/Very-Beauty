import 'package:flutter/material.dart';

import '../core/db/enums.dart';
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

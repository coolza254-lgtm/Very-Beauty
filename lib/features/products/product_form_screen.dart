import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../app/router.dart';
import '../../app/widgets/date_field.dart';
import '../../app/widgets/soft_card.dart';
import '../../core/db/app_database.dart';
import '../../core/db/products_dao.dart';
import '../../core/db/providers.dart';
import '../../core/storage/app_paths.dart';
import '../../core/storage/photo_storage.dart';
import '../../core/storage/product_photo_picker.dart';
import '../../core/utils/calculations.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'product_providers.dart';
import 'widgets/ingredient_widgets.dart';

/// Add/edit form in two levels: the essentials up top, everything else in a
/// collapsed "รายละเอียดเพิ่มเติม" section (docs/SPEC.md §2.4, §7.2).
class ProductFormScreen extends ConsumerWidget {
  const ProductFormScreen({super.key, this.productId, this.initialStatus});

  /// Null when creating.
  final int? productId;

  /// Status preset for new products (e.g. wishlist).
  final ProductStatus? initialStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = productId;
    if (id == null) return _ProductForm(initialStatus: initialStatus);
    final details = ref.watch(productDetailsProvider(id));
    return switch (details) {
      AsyncData(value: final d?) => _ProductForm(existing: d),
      AsyncData() => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(AppLocalizations.of(context).productNotFound)),
      ),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}

class _ProductForm extends ConsumerStatefulWidget {
  const _ProductForm({this.existing, this.initialStatus});

  final ProductDetails? existing;
  final ProductStatus? initialStatus;

  @override
  ConsumerState<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<_ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _brand;
  late final TextEditingController _price;
  late final TextEditingController _netContent;
  late final TextEditingController _place;
  late final TextEditingController _pao;
  late final TextEditingController _startWeight;
  late final TextEditingController _emptyWeight;
  late final TextEditingController _note;
  late List<String> _ingredients;
  List<String> _usedIngredients = const [];

  /// Selected categories in the order they were picked; the first is main.
  late List<ProductCategory> _categories;

  /// Photo currently shown; [_original] is the one the product had.
  StoredPhoto? _photo;
  StoredPhoto? _original;

  /// Photos saved while this form was open; unused ones are deleted.
  final _newPhotos = <StoredPhoto>[];
  bool _saved = false;
  late NetUnit _unit;
  late ProductStatus _status;
  DateTime? _purchaseDate;
  DateTime? _openedDate;
  DateTime? _expiryDate;
  bool _saving = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final p = widget.existing?.product;
    String num(double? v) =>
        v == null ? '' : formatNumber(v).replaceAll(',', '');
    DateTime? date(int? ms) => ms == null ? null : fromEpochMs(ms);

    _name = TextEditingController(text: p?.name);
    _brand = TextEditingController(text: p?.brand);
    _price = TextEditingController(text: num(p?.price));
    _netContent = TextEditingController(text: num(p?.netContent));
    _place = TextEditingController(text: p?.purchasePlace);
    _pao = TextEditingController(text: p?.paoMonths?.toString());
    _startWeight = TextEditingController(text: num(p?.startWeight));
    _emptyWeight = TextEditingController(text: num(p?.emptyBottleWeight));
    _note = TextEditingController(text: p?.note);
    _ingredients = [...?widget.existing?.ingredients];
    ref.read(productsDaoProvider).usedIngredientNames().then((names) {
      if (mounted) setState(() => _usedIngredients = names);
    });
    _categories = [...?p?.categories];
    if (p?.photoPath case final path?) {
      _original = _photo = StoredPhoto(
        filePath: path,
        thumbPath: p!.photoThumbPath ?? path,
      );
    }
    _unit = p?.netUnit ?? NetUnit.g;
    _status = p?.status ?? widget.initialStatus ?? ProductStatus.inUse;
    _purchaseDate = date(p?.purchaseDate);
    _openedDate =
        date(p?.openedDate) ??
        (p == null && _status == ProductStatus.inUse ? DateTime.now() : null);
    _expiryDate = date(p?.expiryDate);
  }

  @override
  void dispose() {
    if (!_saved) _deletePhotos(_newPhotos);
    for (final c in [
      _name,
      _brand,
      _price,
      _netContent,
      _place,
      _pao,
      _startWeight,
      _emptyWeight,
      _note,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _deletePhotos(Iterable<StoredPhoto> photos) async {
    final list = photos.toList();
    if (list.isEmpty) return;
    final paths = await ref.read(appPathsProvider.future);
    for (final photo in list) {
      await PhotoStorage(paths).delete(photo);
    }
  }

  Future<void> _pickPhoto() async {
    final l10n = AppLocalizations.of(context);
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.productPhotoCamera),
              onTap: () => Navigator.of(context).pop('camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.productPhotoGallery),
              onTap: () => Navigator.of(context).pop('gallery'),
            ),
            if (_photo != null)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded),
                title: Text(l10n.productPhotoRemove),
                onTap: () => Navigator.of(context).pop('remove'),
              ),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;
    if (choice == 'remove') {
      setState(() => _photo = null);
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    try {
      final bytes = await ref
          .read(productPhotoPickerProvider)
          .pick(fromCamera: choice == 'camera');
      if (bytes == null) return;
      final paths = await ref.read(appPathsProvider.future);
      final stored = await PhotoStorage(paths).saveProduct(bytes);
      _newPhotos.add(stored);
      if (mounted) setState(() => _photo = stored);
    } catch (e) {
      debugPrint('Product photo failed: $e');
      messenger.showSnackBar(SnackBar(content: Text(l10n.productPhotoFailed)));
    }
  }

  String? _validateNumber(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final n = parseNumber(v);
    return n == null || n < 0
        ? AppLocalizations.of(context).fieldInvalidNumber
        : null;
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_categories.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${l10n.fieldCategory}?')));
      return;
    }
    setState(() => _saving = true);
    final draft = ProductDraft(
      name: _name.text,
      category: _categories.first,
      extraCategories: _categories.skip(1).toList(),
      photoPath: _photo?.filePath,
      photoThumbPath: _photo?.thumbPath,
      brand: _brand.text,
      price: parseNumber(_price.text),
      netContent: parseNumber(_netContent.text),
      netUnit: _unit,
      status: _status,
      purchasePlace: _place.text,
      purchaseDate: _purchaseDate,
      openedDate: _openedDate,
      paoMonths: parseNumber(_pao.text)?.round(),
      expiryDate: _expiryDate,
      startWeight: parseNumber(_startWeight.text),
      emptyBottleWeight: parseNumber(_emptyWeight.text),
      note: _note.text,
      ingredients: _ingredients,
    );
    final dao = ref.read(productsDaoProvider);
    _saved = true;
    // Drop photo files nothing points to any more.
    await _deletePhotos([
      for (final photo in [..._newPhotos, ?_original])
        if (photo.filePath != _photo?.filePath) photo,
    ]);
    if (_isEdit) {
      await dao.updateProduct(widget.existing!.product.id, draft);
      if (mounted) context.pop();
    } else {
      final id = await dao.createProduct(draft);
      if (mounted) context.pushReplacement(AppRoutes.productDetail(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final numberKeyboard = const TextInputType.numberWithOptions(decimal: true);
    final numberFormatter = FilteringTextInputFormatter.allow(
      RegExp(r'[0-9.,]'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.productFormEdit : l10n.productFormNew),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(l10n.actionSave),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
          children: [
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PhotoBox(photo: _photo, onTap: _pickPhoto),
                      const SizedBox(width: 14),
                      Expanded(
                        child: TextFormField(
                          controller: _name,
                          autofocus: !_isEdit,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: l10n.fieldName,
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? l10n.fieldNameRequired
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.fieldCategory, style: theme.textTheme.labelLarge),
                  Text(
                    l10n.fieldCategoryMultiHint,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in ProductCategory.values)
                        FilterChip(
                          avatar: Icon(categoryIcon(c), size: 18),
                          label: Text(
                            _categories.length > 1 && _categories.first == c
                                ? '${l10n.category(c)} ★'
                                : l10n.category(c),
                          ),
                          selected: _categories.contains(c),
                          showCheckmark: false,
                          onSelected: (on) => setState(
                            () =>
                                on ? _categories.add(c) : _categories.remove(c),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _price,
                    keyboardType: numberKeyboard,
                    inputFormatters: [numberFormatter],
                    decoration: InputDecoration(
                      labelText: l10n.fieldPrice,
                      prefixText: '฿ ',
                    ),
                    validator: _validateNumber,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _netContent,
                          keyboardType: numberKeyboard,
                          inputFormatters: [numberFormatter],
                          decoration: InputDecoration(
                            labelText: l10n.fieldNetContent,
                          ),
                          validator: _validateNumber,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: SegmentedButton<NetUnit>(
                          showSelectedIcon: false,
                          segments: [
                            for (final u in NetUnit.values)
                              ButtonSegment(
                                value: u,
                                label: Text(l10n.unit(u)),
                              ),
                          ],
                          selected: {_unit},
                          onSelectionChanged: (s) =>
                              setState(() => _unit = s.single),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SoftCard(
              child: IngredientInput(
                values: _ingredients,
                categories: _categories,
                usedBefore: _usedIngredients,
                onChanged: (v) => setState(() => _ingredients = v),
              ),
            ),
            const SizedBox(height: 16),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: _isEdit,
                  shape: const Border(),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                  childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  title: Text(
                    l10n.fieldMoreDetails,
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    l10n.fieldMoreDetailsHint,
                    style: theme.textTheme.bodySmall,
                  ),
                  children: _moreFields(l10n, numberKeyboard, numberFormatter),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows `full − net = container` when the container weight is left blank.
  String _packagingHelp(AppLocalizations l10n) {
    final start = parseNumber(_startWeight.text);
    final net = parseNumber(_netContent.text);
    final packaging = packagingWeight(
      emptyBottle: null,
      start: start,
      netContent: net,
    );
    if (_emptyWeight.text.trim().isNotEmpty || packaging == null) {
      return l10n.fieldEmptyWeightHelp;
    }
    return l10n.fieldEmptyWeightAuto(
      formatNumber(start!),
      formatNumber(net!),
      formatNumber(packaging),
    );
  }

  List<Widget> _moreFields(
    AppLocalizations l10n,
    TextInputType numberKeyboard,
    TextInputFormatter numberFormatter,
  ) {
    const gap = SizedBox(height: 16);
    Widget numberField(
      TextEditingController c,
      String label, {
      String? helper,
    }) => TextFormField(
      controller: c,
      keyboardType: numberKeyboard,
      inputFormatters: [numberFormatter],
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        helperMaxLines: 2,
      ),
      validator: _validateNumber,
    );

    return [
      TextFormField(
        controller: _brand,
        decoration: InputDecoration(labelText: l10n.fieldBrand),
      ),
      gap,
      DropdownButtonFormField<ProductStatus>(
        initialValue: _status,
        decoration: InputDecoration(labelText: l10n.fieldStatus),
        items: [
          for (final s in ProductStatus.values)
            DropdownMenuItem(value: s, child: Text(l10n.status(s))),
        ],
        onChanged: (s) => setState(() => _status = s ?? _status),
      ),
      gap,
      DateField(
        label: l10n.fieldOpenedDate,
        value: _openedDate,
        onChanged: (d) => setState(() => _openedDate = d),
      ),
      gap,
      numberField(_pao, l10n.fieldPao),
      gap,
      DateField(
        label: l10n.fieldExpiry,
        value: _expiryDate,
        onChanged: (d) => setState(() => _expiryDate = d),
      ),
      gap,
      numberField(_startWeight, l10n.fieldStartWeight),
      gap,
      // Rebuilds the helper as the weights are typed.
      ListenableBuilder(
        listenable: Listenable.merge([_startWeight, _netContent, _emptyWeight]),
        builder: (context, _) => numberField(
          _emptyWeight,
          l10n.fieldEmptyWeight,
          helper: _packagingHelp(l10n),
        ),
      ),
      gap,
      TextFormField(
        controller: _place,
        decoration: InputDecoration(labelText: l10n.fieldPurchasePlace),
      ),
      gap,
      DateField(
        label: l10n.fieldPurchaseDate,
        value: _purchaseDate,
        onChanged: (d) => setState(() => _purchaseDate = d),
      ),
      gap,
      TextFormField(
        controller: _note,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(labelText: l10n.fieldNote),
      ),
    ];
  }
}

/// Square photo slot next to the name; tap to take/choose/remove a photo.
class _PhotoBox extends ConsumerWidget {
  const _PhotoBox({required this.photo, required this.onTap});

  final StoredPhoto? photo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final paths = ref.watch(appPathsProvider).value;
    final thumb = photo == null || paths == null
        ? null
        : File(paths.resolve(photo!.thumbPath));
    return Semantics(
      button: true,
      label: AppLocalizations.of(context).productPhotoAdd,
      child: InkWell(
        key: const Key('productPhotoBox'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 76,
          height: 76,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: thumb == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, color: scheme.primary),
                    const SizedBox(height: 2),
                    Text(
                      AppLocalizations.of(context).productPhotoAdd,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                )
              : Image.file(thumb, fit: BoxFit.cover, gaplessPlayback: true),
        ),
      ),
    );
  }
}

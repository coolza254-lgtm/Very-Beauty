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
import '../../core/utils/date_utils.dart';
import '../../core/utils/formatters.dart';
import 'barcode_fill.dart';
import 'product_providers.dart';

/// Add/edit form in two levels: the essentials up top, everything else in a
/// collapsed "รายละเอียดเพิ่มเติม" section (docs/SPEC.md §2.4, §7.2).
class ProductFormScreen extends ConsumerWidget {
  const ProductFormScreen({
    super.key,
    this.productId,
    this.initialStatus,
    this.startWithScan = false,
  });

  /// Null when creating.
  final int? productId;

  /// Status preset for new products (e.g. wishlist).
  final ProductStatus? initialStatus;

  /// Open the barcode scanner straight away (from the Products screen).
  final bool startWithScan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = productId;
    if (id == null) {
      return _ProductForm(
        initialStatus: initialStatus,
        startWithScan: startWithScan,
      );
    }
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
  const _ProductForm({
    this.existing,
    this.initialStatus,
    this.startWithScan = false,
  });

  final ProductDetails? existing;
  final ProductStatus? initialStatus;
  final bool startWithScan;

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
  late final TextEditingController _ingredients;

  ProductCategory? _category;
  late NetUnit _unit;
  late ProductStatus _status;
  DateTime? _purchaseDate;
  DateTime? _openedDate;
  DateTime? _expiryDate;
  bool _saving = false;
  String? _barcode;

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
    _ingredients = TextEditingController(
      text: widget.existing?.ingredients.join(', '),
    );
    _category = p?.category;
    _unit = p?.netUnit ?? NetUnit.g;
    _status = p?.status ?? widget.initialStatus ?? ProductStatus.inUse;
    _purchaseDate = date(p?.purchaseDate);
    _openedDate =
        date(p?.openedDate) ??
        (p == null && _status == ProductStatus.inUse ? DateTime.now() : null);
    _expiryDate = date(p?.expiryDate);
    _barcode = p?.barcode;
    if (widget.startWithScan) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scan());
    }
  }

  @override
  void dispose() {
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
      _ingredients,
    ]) {
      c.dispose();
    }
    super.dispose();
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
    if (_category == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${l10n.fieldCategory}?')));
      return;
    }
    setState(() => _saving = true);
    final draft = ProductDraft(
      name: _name.text,
      category: _category!,
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
      ingredients: _ingredients.text.split(RegExp(r'[,،、\n]')),
      barcode: _barcode,
    );
    final dao = ref.read(productsDaoProvider);
    if (_isEdit) {
      await dao.updateProduct(widget.existing!.product.id, draft);
      if (mounted) context.pop();
    } else {
      final id = await dao.createProduct(draft);
      if (mounted) context.pushReplacement(AppRoutes.productDetail(id));
    }
  }

  /// Scan, look up, and fill only the fields that are still empty.
  Future<void> _scan() async {
    final code = await ref.read(barcodeScannerProvider)(context);
    if (code == null || !mounted) return;
    setState(() => _barcode = code);
    final info = await lookUpBarcode(context, ref, code);
    if (info == null || !mounted) return;
    String num(double v) => formatNumber(v).replaceAll(',', '');
    void fill(TextEditingController c, String? value) {
      if (c.text.trim().isEmpty && value != null) c.text = value;
    }

    setState(() {
      fill(_name, info.name);
      fill(_brand, info.brand);
      fill(_netContent, info.netContent == null ? null : num(info.netContent!));
      fill(_price, info.price == null ? null : num(info.price!));
      _category ??= info.category;
      if (info.netUnit != null &&
          info.netContent != null &&
          _netContent.text == num(info.netContent!)) {
        _unit = info.netUnit!;
      }
    });
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
            OutlinedButton.icon(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              label: Text(l10n.scanButton),
              onPressed: _scan,
            ),
            if (_barcode != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: InputChip(
                    avatar: const Icon(Icons.barcode_reader, size: 18),
                    label: Text(l10n.scanBarcodeLabel(_barcode!)),
                    onDeleted: () => setState(() => _barcode = null),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _name,
                    autofocus: !_isEdit,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(labelText: l10n.fieldName),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? l10n.fieldNameRequired
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.fieldCategory, style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in ProductCategory.values)
                        ChoiceChip(
                          avatar: Icon(categoryIcon(c), size: 18),
                          label: Text(l10n.category(c)),
                          selected: _category == c,
                          showCheckmark: false,
                          onSelected: (_) => setState(() => _category = c),
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
      decoration: InputDecoration(labelText: label, helperText: helper),
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
      numberField(
        _emptyWeight,
        l10n.fieldEmptyWeight,
        helper: l10n.fieldEmptyWeightHelp,
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
        controller: _ingredients,
        decoration: InputDecoration(
          labelText: l10n.fieldIngredients,
          helperText: l10n.fieldIngredientsHelp,
          helperMaxLines: 2,
        ),
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

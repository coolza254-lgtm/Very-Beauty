import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/ingredients/ingredient_db.dart';

/// Skeletal formula drawn from a precomputed 2D layout. Carbon atoms are
/// plain vertices; other atoms are labelled with their hydrogens and charge.
class MoleculeView extends StatelessWidget {
  const MoleculeView({super.key, required this.molecule, this.maxHeight = 300});

  final Molecule molecule;
  final double maxHeight;

  static const _padding = 20.0;
  static const _maxBond = 34.0;

  @override
  Widget build(BuildContext context) {
    final atoms = molecule.atoms;
    var w = 0.0, h = 0.0;
    for (final a in atoms) {
      w = math.max(w, a.x);
      h = math.max(h, a.y);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var scale = _maxBond;
        if (w > 0) scale = math.min(scale, (width - 2 * _padding) / w);
        if (h > 0) scale = math.min(scale, (maxHeight - 2 * _padding) / h);
        final height = h * scale + 2 * _padding;
        return SizedBox(
          width: width,
          height: math.max(height, 64),
          child: CustomPaint(
            painter: _MoleculePainter(
              molecule: molecule,
              scale: scale,
              offset: Offset(
                (width - w * scale) / 2,
                (math.max(height, 64) - h * scale) / 2,
              ),
              theme: Theme.of(context),
            ),
          ),
        );
      },
    );
  }
}

class _MoleculePainter extends CustomPainter {
  _MoleculePainter({
    required this.molecule,
    required this.scale,
    required this.offset,
    required this.theme,
  });

  final Molecule molecule;
  final double scale;
  final Offset offset;
  final ThemeData theme;

  bool get _dark => theme.brightness == Brightness.dark;

  Color _elementColor(String element) => switch (element) {
    'O' => _dark ? const Color(0xFFFF9AA2) : const Color(0xFFC0392B),
    'N' => _dark ? const Color(0xFF9CC3FF) : const Color(0xFF2E5BB8),
    'S' => _dark ? const Color(0xFFF5D06F) : const Color(0xFFA67C00),
    'P' => _dark ? const Color(0xFFFFB877) : const Color(0xFFC0620B),
    'Cl' || 'F' => _dark ? const Color(0xFF8EE0A1) : const Color(0xFF1E8C45),
    _ => theme.colorScheme.onSurface,
  };

  Offset _p(MoleculeAtom a) => offset + Offset(a.x * scale, a.y * scale);

  static const _sub = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];

  static String _subscript(int n) =>
      n.toString().split('').map((d) => _sub[int.parse(d)]).join();

  static String _charge(int q) {
    if (q == 0) return '';
    final sign = q > 0 ? '⁺' : '⁻';
    final n = q.abs();
    const sup = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];
    return n == 1 ? sign : '${sup[n]}$sign';
  }

  /// "OH", "NH₂", "HO" (hydrogens put on the free side), "Na⁺", "O⁻".
  String _label(int index, MoleculeAtom a) {
    final element = a.element ?? 'C';
    final h = a.hydrogens == 0
        ? ''
        : a.hydrogens == 1
        ? 'H'
        : 'H${_subscript(a.hydrogens)}';
    var neighbourDx = 0.0;
    var neighbours = 0;
    for (final b in molecule.bonds) {
      final other = b.from == index
          ? b.to
          : b.to == index
          ? b.from
          : null;
      if (other == null) continue;
      neighbourDx += molecule.atoms[other].x - a.x;
      neighbours++;
    }
    // Lone molecules follow convention (H₂O, H₂S); otherwise hydrogens go on
    // the side away from the bonds.
    final hFirst =
        h.isNotEmpty &&
        (neighbours == 0
            ? const {'O', 'S', 'F', 'Cl', 'Br', 'I'}.contains(element)
            : neighbourDx > 0.1);
    final core = hFirst ? '$h$element' : '$element$h';
    return '$core${_charge(a.charge)}';
  }

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = theme.colorScheme.onSurface.withValues(alpha: 0.85)
      ..strokeWidth = math.max(1.2, scale * 0.055)
      ..strokeCap = StrokeCap.round;
    final fontSize = (scale * 0.48).clamp(9.0, 16.0);
    final labelRadius = fontSize * 0.62;
    final labelled = [for (final a in molecule.atoms) a.element != null];

    for (final b in molecule.bonds) {
      var p1 = _p(molecule.atoms[b.from]);
      var p2 = _p(molecule.atoms[b.to]);
      final d = p2 - p1;
      final len = d.distance;
      if (len == 0) continue;
      final u = d / len;
      if (labelled[b.from]) p1 += u * labelRadius;
      if (labelled[b.to]) p2 -= u * labelRadius;
      final n = Offset(-u.dy, u.dx);
      final gap = scale * 0.17;

      if (b.order == 2 && b.side != 0) {
        canvas.drawLine(p1, p2, line);
        final inner = n * (gap * 1.2 * b.side);
        final trim = u * (len * 0.14);
        canvas.drawLine(p1 + inner + trim, p2 + inner - trim, line);
      } else if (b.order == 2) {
        canvas.drawLine(p1 + n * gap / 2, p2 + n * gap / 2, line);
        canvas.drawLine(p1 - n * gap / 2, p2 - n * gap / 2, line);
      } else if (b.order == 3) {
        canvas.drawLine(p1, p2, line);
        canvas.drawLine(p1 + n * gap, p2 + n * gap, line);
        canvas.drawLine(p1 - n * gap, p2 - n * gap, line);
      } else {
        canvas.drawLine(p1, p2, line);
      }
    }

    for (final (i, a) in molecule.atoms.indexed) {
      final element = a.element;
      if (element == null) continue;
      final painter = TextPainter(
        text: TextSpan(
          text: _label(i, a),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: _elementColor(element),
            height: 1,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      // Centre the element letter (not the whole label) on the atom.
      final label = _label(i, a);
      final hFirst = label.startsWith('H') && element != 'H';
      final elementPainter = TextPainter(
        text: TextSpan(
          text: element,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final ew = elementPainter.width;
      final dx = hFirst ? painter.width - ew / 2 : ew / 2;
      painter.paint(canvas, _p(a) - Offset(dx, painter.height / 2));
    }
  }

  @override
  bool shouldRepaint(_MoleculePainter old) =>
      old.molecule != molecule || old.scale != scale || old.theme != theme;
}

/// "C12H25NaO4S" with subscript digits.
String formatFormula(String formula) {
  final out = StringBuffer();
  const sub = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];
  for (final ch in formula.split('')) {
    final d = int.tryParse(ch);
    out.write(d == null ? ch : sub[d]);
  }
  return out.toString();
}

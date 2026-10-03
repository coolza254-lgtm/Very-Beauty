/// Turns an ingredient list copied from a brand website, a product box or
/// recognised from a photo into individual names.
///
/// Handles "Ingredients:" headings, text after the list (directions,
/// warnings), names wrapped over several lines, bullets, footnote marks
/// (`*`, `†`), percentages and "May contain (+/-)" notes.
List<String> parseIngredientList(String raw) {
  final text = raw.replaceAll('\r', '');
  // Several lists can be pasted/scanned one after another; each
  // "Ingredients:" heading starts a new one.
  final headings = RegExp(
    r'(ingredients?|inci|composition|ส่วนประกอบ(สำคัญ)?|ส่วนผสม)\s*[:：]',
    caseSensitive: false,
  ).allMatches(text).toList();
  final segments = headings.isEmpty
      ? [text]
      : [
          for (final (i, h) in headings.indexed)
            text.substring(
              h.end,
              i + 1 < headings.length ? headings[i + 1].start : text.length,
            ),
        ];
  final names = <String>[];
  final seen = <String>{};
  for (final segment in segments) {
    for (final name in _parseSegment(segment)) {
      if (seen.add(name.toLowerCase())) names.add(name);
    }
  }
  return names;
}

List<String> _parseSegment(String segment) {
  var text = segment;

  // Stop at the next section of the label/page.
  final end = RegExp(
    r'(directions|how to use|usage|caution|warnings?|precautions?|'
    r'วิธีใช้|คำเตือน|ข้อควรระวัง|\*+\s*(organic|certified|from organic)|'
    r'\*+\s*ส่วนผสมจาก)',
    caseSensitive: false,
  ).firstMatch(text);
  if (end != null && end.start > 0) text = text.substring(0, end.start);

  // Join wrapped lines: "Methoxy-\nphenyl" -> "Methoxyphenyl",
  // "PEG-\n100" -> "PEG-100", other breaks become spaces when the list uses
  // commas; without commas, one name per line.
  text = text
      .replaceAllMapped(RegExp(r'-\s*\n\s*([a-z])'), (m) => m.group(1)!)
      .replaceAll(RegExp(r'-\s*\n\s*'), '-');
  // "May contain [+/-: CI 77891 ...]" starts a new group of names.
  text = text.replaceAll(
    RegExp(
      r'(may contain|peut contenir|\[\s*\+\s*/\s*-\s*:?|\(\s*\+\s*/\s*-\s*\)\s*:?|\+\s*/\s*-\s*:?)',
      caseSensitive: false,
    ),
    ',',
  );
  final separators = RegExp(r'[,，;•·|●▪◦]');
  text = text.contains(separators)
      ? text.replaceAll(RegExp(r'\s*\n\s*'), ' ')
      : text.replaceAll('\n', ',');

  final names = <String>[];
  for (var part in text.split(RegExp(r'[,，;•·|●▪◦\n]'))) {
    part = part
        // Percentages and footnote marks.
        .replaceAll(RegExp(r'\(?\s*\d+(\.\d+)?\s*%\s*\)?'), ' ')
        .replaceAll(RegExp(r'[*†‡¹²³°™®]+'), ' ')
        // Brackets left open/closed by the split, leading numbering.
        .replaceAll(RegExp(r'^[\s\[\]():.\-–—\d]+'), '')
        .replaceAll(RegExp(r'[\s\[\]:.]+$'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    // Drop a bracket left over from splitting "(...)" across names.
    final opens = '('.allMatches(part).length;
    final closes = ')'.allMatches(part).length;
    if (opens > closes && part.startsWith('(')) part = part.substring(1);
    if (closes > opens && part.endsWith(')')) {
      part = part.substring(0, part.length - 1);
    }
    part = part.trim();
    if (part.length < 2 || !RegExp(r'[A-Za-z฀-๿]').hasMatch(part)) {
      continue;
    }
    names.add(part);
  }
  return names;
}

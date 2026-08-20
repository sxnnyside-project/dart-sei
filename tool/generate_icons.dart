import 'dart:convert';
import 'dart:io';

String toCamelCase(String text) {
  final parts = text.split('-');
  if (parts.isEmpty) return text;
  final first = parts.first;
  final rest = parts
      .skip(1)
      .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
      .join('');
  return '$first$rest';
}

void main() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final packageDir = scriptDir.parent;
  final workspaceDir = packageDir.parent;
  final iconsDir =
      Directory('${workspaceDir.path}/sxnnyside-eloquent-icons/icons');

  if (!iconsDir.existsSync()) {
    stderr.writeln('Error: Could not find icons directory at ${iconsDir.path}');
    exit(1);
  }

  final outlineDir = Directory('${iconsDir.path}/outline');
  final filledDir = Directory('${iconsDir.path}/filled');

  final outlineFiles = outlineDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.svg'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  final filledFiles = filledDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.svg'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  print(
      'Found ${outlineFiles.length} outline icons and ${filledFiles.length} filled icons.');

  // Parse outline
  final outlineData = <String, Map<String, String>>{};
  for (final file in outlineFiles) {
    final fileName = file.uri.pathSegments.last.replaceAll('.svg', '');
    final raw = file.readAsStringSync().trim();
    final inner = raw
        .replaceAll(RegExp(r'^<svg[^>]*>', multiLine: true), '')
        .replaceAll(RegExp(r'</svg>\s*$', multiLine: true), '')
        .trim();
    outlineData[fileName] = {
      'fileName': fileName,
      'camel': toCamelCase(fileName),
      'inner': inner,
      'raw': raw,
    };
  }

  // Parse filled
  final filledData = <String, Map<String, String>>{};
  for (final file in filledFiles) {
    final fileName = file.uri.pathSegments.last.replaceAll('.svg', '');
    final raw = file.readAsStringSync().trim();
    final inner = raw
        .replaceAll(RegExp(r'^<svg[^>]*>', multiLine: true), '')
        .replaceAll(RegExp(r'</svg>\s*$', multiLine: true), '')
        .trim();
    filledData[fileName] = {
      'fileName': fileName,
      'camel': toCamelCase(fileName),
      'inner': inner,
      'raw': raw,
    };
  }

  // Generate src/sei_icons.dart
  final seiIconsBuffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln('// Generated from sxnnyside-eloquent-icons/icons/outline')
    ..writeln()
    ..writeln('import "sei_icon_data.dart";')
    ..writeln('import "data/outline_icons_data.dart";')
    ..writeln()
    ..writeln(
        '/// The complete set of outline icons in Sxnnyside Eloquent Icons (SEI).')
    ..writeln('///')
    ..writeln(
        '/// Every icon has an outline representation crafted on a 24x24 pixel grid.')
    ..writeln('enum SeiIcons {');

  for (final entry in outlineData.values) {
    final camel = entry['camel']!;
    final name = entry['fileName']!;
    seiIconsBuffer.writeln("  $camel('$name'),");
  }
  seiIconsBuffer
    ..writeln(';')
    ..writeln()
    ..writeln('  const SeiIcons(this.name);')
    ..writeln()
    ..writeln(
        '  /// The canonical kebab-case name of the icon (e.g. `arrow-right`).')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// Returns the detailed [SeiIconData] for this icon.')
    ..writeln('  SeiIconData get data => SeiOutlineData.lookup(this);')
    ..writeln()
    ..writeln(
        '  /// Returns the raw inner SVG elements/paths (without `<svg>` wrapper).')
    ..writeln('  String get innerSvg => data.innerSvg;')
    ..writeln()
    ..writeln('  /// Returns the complete SVG string.')
    ..writeln('  ///')
    ..writeln(
        '  /// Customize [size], [color], [strokeWidth], [className], or arbitrary SVG [attributes].')
    ..writeln('  String toSvg({')
    ..writeln('    double size = 24.0,')
    ..writeln('    double? width,')
    ..writeln('    double? height,')
    ..writeln("    String color = 'currentColor',")
    ..writeln('    double strokeWidth = 2.0,')
    ..writeln('    String? className,')
    ..writeln('    Map<String, String>? attributes,')
    ..writeln('  }) {')
    ..writeln('    return data.toSvg(')
    ..writeln('      size: size,')
    ..writeln('      width: width,')
    ..writeln('      height: height,')
    ..writeln('      color: color,')
    ..writeln('      strokeWidth: strokeWidth,')
    ..writeln('      className: className,')
    ..writeln('      attributes: attributes,')
    ..writeln('    );')
    ..writeln('  }')
    ..writeln()
    ..writeln(
        '  /// Returns an inline Data URI suitable for CSS or HTML `<img>` `src`.')
    ..writeln('  String toDataUri({')
    ..writeln('    String color = "currentColor",')
    ..writeln('    double strokeWidth = 2.0,')
    ..writeln('    bool base64Encode = false,')
    ..writeln('  }) {')
    ..writeln('    return data.toDataUri(')
    ..writeln('      color: color,')
    ..writeln('      strokeWidth: strokeWidth,')
    ..writeln('      base64Encode: base64Encode,')
    ..writeln('    );')
    ..writeln('  }')
    ..writeln('}')
    ..writeln();

  File('${packageDir.path}/lib/src/sei_icons.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync(seiIconsBuffer.toString());

  // Generate src/sei_icons_filled.dart
  final seiIconsFilledBuffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln('// Generated from sxnnyside-eloquent-icons/icons/filled')
    ..writeln()
    ..writeln('import "sei_icon_data.dart";')
    ..writeln('import "data/filled_icons_data.dart";')
    ..writeln()
    ..writeln(
        '/// The subset of icons in Sxnnyside Eloquent Icons (SEI) that have a filled style.')
    ..writeln('enum SeiIconsFilled {');

  for (final entry in filledData.values) {
    final camel = entry['camel']!;
    final name = entry['fileName']!;
    seiIconsFilledBuffer.writeln("  $camel('$name'),");
  }
  seiIconsFilledBuffer
    ..writeln(';')
    ..writeln()
    ..writeln('  const SeiIconsFilled(this.name);')
    ..writeln()
    ..writeln('  /// The canonical kebab-case name of the icon (e.g. `heart`).')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// Returns the detailed [SeiIconData] for this filled icon.')
    ..writeln('  SeiIconData get data => SeiFilledData.lookup(this);')
    ..writeln()
    ..writeln(
        '  /// Returns the raw inner SVG elements/paths (without `<svg>` wrapper).')
    ..writeln('  String get innerSvg => data.innerSvg;')
    ..writeln()
    ..writeln('  /// Returns the complete filled SVG string.')
    ..writeln('  String toSvg({')
    ..writeln('    double size = 24.0,')
    ..writeln('    double? width,')
    ..writeln('    double? height,')
    ..writeln("    String color = 'currentColor',")
    ..writeln('    String? className,')
    ..writeln('    Map<String, String>? attributes,')
    ..writeln('  }) {')
    ..writeln('    return data.toSvg(')
    ..writeln('      size: size,')
    ..writeln('      width: width,')
    ..writeln('      height: height,')
    ..writeln('      color: color,')
    ..writeln('      className: className,')
    ..writeln('      attributes: attributes,')
    ..writeln('    );')
    ..writeln('  }')
    ..writeln()
    ..writeln(
        '  /// Returns an inline Data URI suitable for CSS or HTML `<img>` `src`.')
    ..writeln('  String toDataUri({')
    ..writeln('    String color = "currentColor",')
    ..writeln('    bool base64Encode = false,')
    ..writeln('  }) {')
    ..writeln('    return data.toDataUri(')
    ..writeln('      color: color,')
    ..writeln('      base64Encode: base64Encode,')
    ..writeln('    );')
    ..writeln('  }')
    ..writeln('}')
    ..writeln();

  File('${packageDir.path}/lib/src/sei_icons_filled.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync(seiIconsFilledBuffer.toString());

  // Generate src/data/outline_icons_data.dart
  final outlineDataBuffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln()
    ..writeln('import "../sei_icons.dart";')
    ..writeln('import "../sei_icon_data.dart";')
    ..writeln('import "../sei_style.dart";')
    ..writeln()
    ..writeln('/// Internal lookup table for outline icons.')
    ..writeln('abstract final class SeiOutlineData {')
    ..writeln('  static SeiIconData lookup(SeiIcons icon) => _map[icon]!;')
    ..writeln('  static SeiIconData? byName(String name) => _nameMap[name];')
    ..writeln('  static List<SeiIconData> get all => _all;')
    ..writeln()
    ..writeln('  static final Map<SeiIcons, SeiIconData> _map = {');

  for (final entry in outlineData.values) {
    final camel = entry['camel']!;
    final name = entry['fileName']!;
    final encodedInner = jsonEncode(entry['inner']!);
    outlineDataBuffer.writeln("    SeiIcons.$camel: const SeiIconData(");
    outlineDataBuffer.writeln("      name: '$name',");
    outlineDataBuffer.writeln("      style: SeiStyle.outline,");
    outlineDataBuffer.writeln("      innerSvg: $encodedInner,");
    outlineDataBuffer.writeln("    ),");
  }
  outlineDataBuffer
    ..writeln('  };')
    ..writeln()
    ..writeln('  static final Map<String, SeiIconData> _nameMap = {')
    ..writeln(
        '    for (final entry in _map.entries) entry.value.name: entry.value,')
    ..writeln('  };')
    ..writeln()
    ..writeln(
        '  static final List<SeiIconData> _all = List.unmodifiable(_map.values);')
    ..writeln('}')
    ..writeln();

  File('${packageDir.path}/lib/src/data/outline_icons_data.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync(outlineDataBuffer.toString());

  // Generate src/data/filled_icons_data.dart
  final filledDataBuffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln()
    ..writeln('import "../sei_icons_filled.dart";')
    ..writeln('import "../sei_icon_data.dart";')
    ..writeln('import "../sei_style.dart";')
    ..writeln()
    ..writeln('/// Internal lookup table for filled icons.')
    ..writeln('abstract final class SeiFilledData {')
    ..writeln(
        '  static SeiIconData lookup(SeiIconsFilled icon) => _map[icon]!;')
    ..writeln('  static SeiIconData? byName(String name) => _nameMap[name];')
    ..writeln('  static List<SeiIconData> get all => _all;')
    ..writeln()
    ..writeln('  static final Map<SeiIconsFilled, SeiIconData> _map = {');

  for (final entry in filledData.values) {
    final camel = entry['camel']!;
    final name = entry['fileName']!;
    final encodedInner = jsonEncode(entry['inner']!);
    filledDataBuffer.writeln("    SeiIconsFilled.$camel: const SeiIconData(");
    filledDataBuffer.writeln("      name: '$name',");
    filledDataBuffer.writeln("      style: SeiStyle.filled,");
    filledDataBuffer.writeln("      innerSvg: $encodedInner,");
    filledDataBuffer.writeln("    ),");
  }
  filledDataBuffer
    ..writeln('  };')
    ..writeln()
    ..writeln('  static final Map<String, SeiIconData> _nameMap = {')
    ..writeln(
        '    for (final entry in _map.entries) entry.value.name: entry.value,')
    ..writeln('  };')
    ..writeln()
    ..writeln(
        '  static final List<SeiIconData> _all = List.unmodifiable(_map.values);')
    ..writeln('}')
    ..writeln();

  File('${packageDir.path}/lib/src/data/filled_icons_data.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync(filledDataBuffer.toString());

  print('Icon code generation complete!');
}

import 'dart:convert';
import 'sei_style.dart';

/// Immutable model containing the vector metadata and SVG content of a SEI icon.
class SeiIconData {
  /// Creates an immutable [SeiIconData] instance.
  const SeiIconData({
    required this.name,
    required this.style,
    required this.innerSvg,
    this.viewBox = '0 0 24 24',
    this.defaultSize = 24.0,
  });

  /// The canonical name of the icon in kebab-case (e.g. `arrow-right`, `heart`).
  final String name;

  /// The visual style (`outline` or `filled`).
  final SeiStyle style;

  /// The inner SVG content (paths, rects, masks, etc.) without the `<svg>` outer tag.
  final String innerSvg;

  /// The SVG viewBox definition (defaults to `0 0 24 24`).
  final String viewBox;

  /// The default icon dimension in pixels (24.0).
  final double defaultSize;

  /// Generates a standalone, fully-formed `<svg>...</svg>` XML/HTML string.
  ///
  /// Parameters:
  /// - [size]: Sets both `width` and `height` in CSS pixels (default: 24.0).
  /// - [width]: Overrides explicit `width` attribute if specified.
  /// - [height]: Overrides explicit `height` attribute if specified.
  /// - [color]: Stroke or fill color (default: `'currentColor'`).
  /// - [strokeWidth]: Stroke width for outline icons (default: 2.0).
  /// - [className]: CSS class added to the `<svg class="...">`.
  /// - [attributes]: Additional custom HTML/SVG attributes (e.g. `{'aria-hidden': 'true'}`).
  String toSvg({
    double? size,
    double? width,
    double? height,
    String color = 'currentColor',
    double strokeWidth = 2.0,
    String? className,
    Map<String, String>? attributes,
  }) {
    final w = (width ?? size ?? defaultSize).toStringAsFixed(
      (width ?? size ?? defaultSize).truncateToDouble() ==
              (width ?? size ?? defaultSize)
          ? 0
          : 1,
    );
    final h = (height ?? size ?? defaultSize).toStringAsFixed(
      (height ?? size ?? defaultSize).truncateToDouble() ==
              (height ?? size ?? defaultSize)
          ? 0
          : 1,
    );

    final buffer = StringBuffer('<svg xmlns="http://www.w3.org/2000/svg"')
      ..write(' width="$w"')
      ..write(' height="$h"')
      ..write(' viewBox="$viewBox"');

    if (style == SeiStyle.outline) {
      buffer
        ..write(' fill="none"')
        ..write(' stroke="$color"')
        ..write(
            ' stroke-width="${strokeWidth.toStringAsFixed(strokeWidth.truncateToDouble() == strokeWidth ? 0 : 1)}"')
        ..write(' stroke-linecap="round"')
        ..write(' stroke-linejoin="round"');
    } else {
      buffer.write(' fill="$color"');
    }

    if (className != null && className.isNotEmpty) {
      buffer.write(' class="$className"');
    }

    if (attributes != null) {
      for (final entry in attributes.entries) {
        buffer.write(' ${entry.key}="${_escapeAttr(entry.value)}"');
      }
    }

    buffer.write('>');
    buffer.write(innerSvg);
    buffer.write('</svg>');

    return buffer.toString();
  }

  /// Generates a Data URI string formatted for web `src` or CSS `background-image: url(...)`.
  ///
  /// Example:
  /// ```dart
  /// final uri = SeiIcons.home.data.toDataUri();
  /// // returns 'data:image/svg+xml;utf8,<svg ...'
  /// ```
  String toDataUri({
    String color = 'currentColor',
    double strokeWidth = 2.0,
    bool base64Encode = false,
  }) {
    final svg = toSvg(color: color, strokeWidth: strokeWidth);
    if (base64Encode) {
      final bytes = utf8.encode(svg);
      return 'data:image/svg+xml;base64,${base64.encode(bytes)}';
    }
    final encoded = Uri.encodeFull(svg).replaceAll('#', '%23');
    return 'data:image/svg+xml;utf8,$encoded';
  }

  static String _escapeAttr(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('"', '&quot;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }

  @override
  String toString() => 'SeiIconData(name: $name, style: ${style.name})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeiIconData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          style == other.style;

  @override
  int get hashCode => Object.hash(name, style);
}

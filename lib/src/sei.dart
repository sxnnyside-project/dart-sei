import 'data/filled_icons_data.dart';
import 'data/outline_icons_data.dart';
import 'sei_icon_data.dart';
import 'sei_icons.dart';
import 'sei_icons_filled.dart';
import 'sei_style.dart';

/// Primary interface for Sxnnyside Eloquent Icons (SEI) in pure Dart.
abstract final class Sei {
  /// Returns a complete standalone `<svg>` string for an outline [icon].
  static String svg(
    SeiIcons icon, {
    double size = 24.0,
    double? width,
    double? height,
    String color = 'currentColor',
    double strokeWidth = 2.0,
    String? className,
    Map<String, String>? attributes,
  }) {
    return icon.data.toSvg(
      size: size,
      width: width,
      height: height,
      color: color,
      strokeWidth: strokeWidth,
      className: className,
      attributes: attributes,
    );
  }

  /// Returns a complete standalone `<svg>` string for a filled [icon].
  static String svgFilled(
    SeiIconsFilled icon, {
    double size = 24.0,
    double? width,
    double? height,
    String color = 'currentColor',
    String? className,
    Map<String, String>? attributes,
  }) {
    return icon.data.toSvg(
      size: size,
      width: width,
      height: height,
      color: color,
      className: className,
      attributes: attributes,
    );
  }

  /// Looks up an icon by its kebab-case or camelCase name.
  ///
  /// Returns `null` if the icon does not exist for the requested [style].
  ///
  /// Example:
  /// ```dart
  /// final iconData = Sei.byName('arrow-right');
  /// final filledData = Sei.byName('heart', style: SeiStyle.filled);
  /// ```
  static SeiIconData? byName(String name, {SeiStyle style = SeiStyle.outline}) {
    final normalized = name.trim().toLowerCase().replaceAll('_', '-');
    if (style == SeiStyle.filled) {
      return SeiFilledData.byName(normalized);
    }
    return SeiOutlineData.byName(normalized);
  }

  /// Generates an SVG string by icon name.
  ///
  /// Throws [ArgumentError] if no matching icon exists.
  static String svgByName(
    String name, {
    SeiStyle style = SeiStyle.outline,
    double size = 24.0,
    double? width,
    double? height,
    String color = 'currentColor',
    double strokeWidth = 2.0,
    String? className,
    Map<String, String>? attributes,
  }) {
    final data = byName(name, style: style);
    if (data == null) {
      throw ArgumentError.value(
          name, 'name', 'No ${style.name} icon found named "$name"');
    }
    return data.toSvg(
      size: size,
      width: width,
      height: height,
      color: color,
      strokeWidth: strokeWidth,
      className: className,
      attributes: attributes,
    );
  }

  /// Returns an inline Data URI suitable for CSS `background-image` or HTML `<img>` `src`.
  static String dataUri(
    SeiIcons icon, {
    String color = 'currentColor',
    double strokeWidth = 2.0,
    bool base64Encode = false,
  }) {
    return icon.data.toDataUri(
      color: color,
      strokeWidth: strokeWidth,
      base64Encode: base64Encode,
    );
  }

  /// Returns an inline Data URI for a filled icon.
  static String dataUriFilled(
    SeiIconsFilled icon, {
    String color = 'currentColor',
    bool base64Encode = false,
  }) {
    return icon.data.toDataUri(
      color: color,
      base64Encode: base64Encode,
    );
  }

  /// Searches icons matching [query] (case-insensitive substring).
  ///
  /// If [style] is null, searches across both outline and filled styles.
  static List<SeiIconData> search(String query, {SeiStyle? style}) {
    final q = query.trim().toLowerCase().replaceAll('_', '-');
    if (q.isEmpty) return all(style: style);

    final results = <SeiIconData>[];
    if (style == null || style == SeiStyle.outline) {
      results.addAll(SeiOutlineData.all.where((icon) => icon.name.contains(q)));
    }
    if (style == null || style == SeiStyle.filled) {
      results.addAll(SeiFilledData.all.where((icon) => icon.name.contains(q)));
    }
    return List.unmodifiable(results);
  }

  /// Returns all available icons for [style], or all icons if [style] is null.
  static List<SeiIconData> all({SeiStyle? style}) {
    if (style == SeiStyle.outline) return SeiOutlineData.all;
    if (style == SeiStyle.filled) return SeiFilledData.all;
    return List.unmodifiable([...SeiOutlineData.all, ...SeiFilledData.all]);
  }

  /// Total count of available outline icons.
  static int get outlineCount => SeiOutlineData.all.length;

  /// Total count of available filled icons.
  static int get filledCount => SeiFilledData.all.length;
}

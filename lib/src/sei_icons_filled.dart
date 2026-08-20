// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from sxnnyside-eloquent-icons/icons/filled

import "sei_icon_data.dart";
import "data/filled_icons_data.dart";

/// The subset of icons in Sxnnyside Eloquent Icons (SEI) that have a filled style.
enum SeiIconsFilled {
  badge('badge'),
  check('check'),
  crown('crown'),
  error('error'),
  flame('flame'),
  folder('folder'),
  globe('globe'),
  heart('heart'),
  help('help'),
  home('home'),
  info('info'),
  lock('lock'),
  message('message'),
  more('more'),
  notification('notification'),
  shield('shield'),
  sound('sound'),
  star('star'),
  success('success'),
  user('user'),
  verified('verified'),
  warning('warning'),
  wifi('wifi'),
  ;

  const SeiIconsFilled(this.name);

  /// The canonical kebab-case name of the icon (e.g. `heart`).
  final String name;

  /// Returns the detailed [SeiIconData] for this filled icon.
  SeiIconData get data => SeiFilledData.lookup(this);

  /// Returns the raw inner SVG elements/paths (without `<svg>` wrapper).
  String get innerSvg => data.innerSvg;

  /// Returns the complete filled SVG string.
  String toSvg({
    double size = 24.0,
    double? width,
    double? height,
    String color = 'currentColor',
    String? className,
    Map<String, String>? attributes,
  }) {
    return data.toSvg(
      size: size,
      width: width,
      height: height,
      color: color,
      className: className,
      attributes: attributes,
    );
  }

  /// Returns an inline Data URI suitable for CSS or HTML `<img>` `src`.
  String toDataUri({
    String color = "currentColor",
    bool base64Encode = false,
  }) {
    return data.toDataUri(
      color: color,
      base64Encode: base64Encode,
    );
  }
}

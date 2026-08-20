/// The visual style of a Sxnnyside Eloquent Icon (SEI).
enum SeiStyle {
  /// Outline (stroked) style. Every icon has an outline representation.
  outline,

  /// Filled (solid) style. A subset of icons has a filled representation.
  filled;

  /// Returns true if this is an outline style.
  bool get isOutline => this == SeiStyle.outline;

  /// Returns true if this is a filled style.
  bool get isFilled => this == SeiStyle.filled;
}

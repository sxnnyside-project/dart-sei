# dart_sei

A pure Dart package for [Sxnnyside Eloquent Icons (SEI)](https://github.com/sxnnyside-project/sxnnyside-eloquent-icons).

Provides standalone SVG markup, vector paths, data URIs, and search helpers for Jaspr, Rad, server-side Dart (Shelf, Serverpod, Dart Frog), CLI tools, and web applications — with zero dependency on Flutter.

## Features

- **No Flutter dependency** — pure Dart, works on VM, Web/WASM, JS, and native.
- **142 outline icons, 23 filled** — the full SEI set on a 24×24 grid.
- **In-memory SVG generation** — no asset bundling or file I/O at runtime.
- **Data URIs** for CSS `background-image` or `<img>` tags.
- **Lookup and search** icons by name or substring at runtime.
- **Strongly typed** via `SeiIcons` and `SeiIconsFilled` — requesting a filled icon that doesn't exist is a compile-time error, not a runtime one.

## Installation

```yaml
dependencies:
  dart_sei: ^1.0.0
```

Or:

```bash
dart pub add dart_sei
```

## Usage

### SVG markup

```dart
import 'package:dart_sei/dart_sei.dart';

final homeSvg = SeiIcons.home.toSvg();

final customSvg = SeiIcons.heart.toSvg(
  size: 32.0,
  color: '#ff2d55',
  strokeWidth: 1.5,
  className: 'icon-heart',
  attributes: {'aria-hidden': 'true', 'id': 'btn-icon'},
);

// Filled icons are a separate, smaller set — only icons with filled artwork exist here.
final starFilledSvg = SeiIconsFilled.star.toSvg(size: 24.0, color: '#ffd700');
```

### Jaspr / web components

```dart
import 'package:dart_sei/dart_sei.dart';
import 'package:jaspr/jaspr.dart';

Component iconButton() {
  return button([
    raw(SeiIcons.search.toSvg(size: 18, color: 'var(--text-color)')),
    text('Search'),
  ]);
}
```

### Data URIs

```dart
final dataUri = SeiIcons.download.toDataUri(color: '#8b3ff0');
// data:image/svg+xml;utf8,%3Csvg...

final base64Uri = SeiIcons.download.toDataUri(base64Encode: true);
// data:image/svg+xml;base64,...
```

### Lookup and search

```dart
final icon = Sei.byName('arrow-right');
if (icon != null) {
  print(icon.toSvg(size: 20));
}

final results = Sei.search('chart');
for (final item in results) {
  print('${item.name} (${item.style.name})');
}
```

## Outline vs. filled

`SeiIcons` covers all 142 icons in the outline style. `SeiIconsFilled` covers the 23 icons that also have a handcrafted filled variant, for active/selected states.

## License

MIT License © 2026 Sxnnyside Project

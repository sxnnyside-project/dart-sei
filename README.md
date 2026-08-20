# dart_sei

A pure Dart package for **[Sxnnyside Eloquent Icons (SEI)](https://github.com/sxnnyside-project/sxnnyside-eloquent-icons)**.

Provides standalone SVG markup, vector paths, data URIs, and search helpers for **Jaspr**, **Rad**, server-side Dart (**Shelf**, **Serverpod**, **Dart Frog**), CLI tools, and web applications — **with zero dependencies on Flutter**.

---

## ✨ Features

- 🚀 **Zero Flutter Dependency**: 100% pure Dart compatible with VM, Web / WASM, JS, and Native.
- 🎨 **142 Outline Icons & 23 Filled Icons**: Full pixel-perfect 24x24 grid icons from SEI.
- ⚡ **Instant In-Memory SVG Generation**: No asset bundling or file I/O needed at runtime.
- 🌐 **Web & Jaspr Friendly**: Generates `<svg>` markup, CSS Data URIs, and raw paths.
- 🔍 **Dynamic Lookup & Search**: Find icons by name or substring at runtime.
- 📦 **Strongly Typed**: Full enum safety with `SeiIcons` and `SeiIconsFilled`.

---

## 📦 Installation

Add `dart_sei` to your `pubspec.yaml`:

```yaml
dependencies:
  dart_sei: ^1.0.0
```

Or run:

```bash
dart pub add dart_sei
```

---

## 🚀 Quick Start

### 1. Generate Full `<svg>` Markup

```dart
import 'package:dart_sei/dart_sei.dart';

// Basic SVG with currentColor
final homeSvg = SeiIcons.home.toSvg();

// Customized with size, color, stroke width, class, and attributes
final customSvg = SeiIcons.heart.toSvg(
  size: 32.0,
  color: '#ff2d55',
  strokeWidth: 1.5,
  className: 'icon-heart',
  attributes: {'aria-hidden': 'true', 'id': 'btn-icon'},
);

// Filled icon (only available for icons with filled assets)
final starFilledSvg = SeiIconsFilled.star.toSvg(
  size: 24.0,
  color: '#ffd700',
);
```

### 2. Use in Jaspr / Web Components

```dart
import 'package:dart_sei/dart_sei.dart';
import 'package:jaspr/jaspr.dart';

// Render via raw HTML
Component iconButton() {
  return button([
    raw(SeiIcons.search.toSvg(size: 18, color: 'var(--text-color)')),
    text('Search'),
  ]);
}
```

### 3. Generate Data URIs (for CSS `background-image` or `<img>` tags)

```dart
final dataUri = SeiIcons.download.toDataUri(color: '#8b3ff0');
// => data:image/svg+xml;utf8,%3Csvg%20xmlns=%22...

final base64Uri = SeiIcons.download.toDataUri(base64Encode: true);
// => data:image/svg+xml;base64,...
```

### 4. Dynamic Lookup & Search

```dart
// Lookup by name
final icon = Sei.byName('arrow-right');
if (icon != null) {
  print(icon.toSvg(size: 20));
}

// Search icons by term
final results = Sei.search('chart');
for (final item in results) {
  print('${item.name} (${item.style.name})');
}
```

---

## 🎨 Outline vs Filled

- **Outline (`SeiIcons`)**: All 142 icons support the clean outline style.
- **Filled (`SeiIconsFilled`)**: 23 core icons have handcrafted solid filled representations for active/selected states.

---

## 📄 License

MIT License © 2026 Sxnnyside Project

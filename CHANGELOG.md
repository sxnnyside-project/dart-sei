# Changelog

All notable changes to **dart_sei** are documented here.

This project follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.0.0] — 2026-08-19

Initial release of `dart_sei`.

### Added

- 100% pure Dart implementation with zero Flutter dependency.
- Support for 142 outline icons (`SeiIcons`) and 23 filled icons (`SeiIconsFilled`).
- In-memory SVG generator with customizable `size`, `color`, `strokeWidth`, `className`, and `attributes`.
- Data URI generator (`utf8` and `base64`) for HTML and CSS.
- Dynamic lookup (`Sei.byName`) and search (`Sei.search`).
- Built-in generator script (`tool/generate_icons.dart`) to synchronize with `sxnnyside-eloquent-icons`.

---

[Unreleased]: https://github.com/sxnnyside-project/dart-sei/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/sxnnyside-project/dart-sei/releases/tag/v1.0.0

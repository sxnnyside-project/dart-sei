# dart_sei

Pure Dart widgets-free library for [Sxnnyside Eloquent Icons (SEI)](https://github.com/sxnnyside-project/sxnnyside-eloquent-icons).

Sibling package to `flutter_sei`, but with **zero Flutter dependency** — for
Jaspr, Rad, server-side Dart (Shelf, Dart Frog, Serverpod), CLI tools, and
any non-Flutter Dart consumer.

## Topology

**Monolithic.** One publishable unit: the `dart_sei` package. `example/`
is a single demo script, not a second workspace member.

## Stack Profile

Dart — see the DXQE Dart Stack Profile. Concretely:

- Formatter/linter: `dart format` + `dart analyze` with `package:lints/recommended.yaml`
  plus `strict-casts`, `strict-inference`, `strict-raw-types` enabled in
  `analysis_options.yaml`.
- Dart has no separate type-checker from its linter — `dart analyze` does
  both. The Justfile's `typecheck` and `lint` recipes intentionally run the
  same command; that's Dart's tooling reality, not a shortcut.
- Testing: `dart test`.
- Task runner: `Justfile` at repo root — `just check` runs the full quality
  gate (format check, lint, typecheck, test, publish dry-run).

## Architecture

```
dart-sei/
├── lib/
│   ├── dart_sei.dart          # public exports only
│   └── src/
│       ├── sei.dart               # Sei facade — byName, search, svgByName, etc.
│       ├── sei_icon_data.dart     # SeiIconData model — toSvg/toDataUri rendering
│       ├── sei_icons.dart         # GENERATED — SeiIcons enum, every outline icon
│       ├── sei_icons_filled.dart  # GENERATED — SeiIconsFilled enum
│       └── data/
│           ├── outline_icons_data.dart  # GENERATED — inlined SVG content
│           └── filled_icons_data.dart   # GENERATED — inlined SVG content
├── tool/generate_icons.dart   # regenerates everything under lib/src/{,data/}
├── example/example.dart       # demo script, `dart run example/example.dart`
└── test/
```

## Why SVG is inlined as const string data, not bundled as asset files

Unlike `flutter_sei`, this package has no Flutter asset-bundling system to
lean on, and a pure-Dart library can't ship loose files a consumer's runtime
would know how to locate reliably across Web/WASM/VM/server targets anyway.
`tool/generate_icons.dart` reads the real SVG files from
`sxnnyside-eloquent-icons/icons/` and inlines their content as `const`
strings at build time — icons render from memory with zero file I/O, which
is also what makes this package usable in contexts with no filesystem
access at all (browser/WASM).

## Regenerating icon data

When the SEI icon collection changes:

```bash
dart run tool/generate_icons.dart
dart format .   # the generator does not format its own output
just check
```

This regenerates `lib/src/sei_icons.dart`, `lib/src/sei_icons_filled.dart`,
and both files under `lib/src/data/` from
`../sxnnyside-eloquent-icons/icons/{outline,filled}/`. Do not hand-edit any
file marked `GENERATED CODE`.

## Public API rules

- Same split as `flutter_sei`: `SeiIcons` (every icon, outline) vs.
  `SeiIconsFilled` (only icons with filled artwork) — kept because it makes
  requesting a nonexistent filled icon a compile-time error, not a
  runtime one.
- `Sei` (the facade class) holds only stateless static helpers —
  `byName`, `search`, `svgByName`, `dataUri`, `all`, counts. No instance
  state, no singleton pattern.
- Keep the public surface minimal: `lib/dart_sei.dart` exports only what a
  consumer needs. `Sei*Data` lookup tables in `lib/src/data/` stay internal.

## Deliberate DXQE exceptions

- **`pubspec.lock` is not committed**, matching `flutter_sei` and
  [Dart's own guidance for libraries](https://dart.dev/guides/libraries/private-files#pubspeclock):
  tested against a declared version *range*, not one resolution.
- **Three `dev_dependencies` are pinned above what `test`'s own declared
  floor allows** (`test`, plus its own transitive floor required bumping):
  older `test`-compatible versions of `pub_semver`, `file`, `watcher`, and
  `frontend_server_client` use Dart SDK APIs since removed or changed
  (sealed `FileSystemEvent`, `File.createSync`'s `exclusive` param, a
  since-renamed frontend-server snapshot). Without these floors,
  `dart pub downgrade` resolves a dependency graph that cannot actually
  run `dart test` against the current Dart SDK — verified by reproducing
  the failure and confirming each pin fixes it.

## Release process

Same as `flutter_sei`: `.github/workflows/release.yml` triggers on a
`vX.Y.Z` tag, runs the check gate, publishes to pub.dev via OIDC trusted
publishing (no stored secret), then creates a GitHub Release from the
matching `CHANGELOG.md` section.

**Before the first tag-triggered release**, this package's first version
must be published manually (`dart pub publish`) — pub.dev only allows
configuring trusted publishing for a package with at least one published
version. Once that's done, enable it on pub.dev's package Admin tab →
Automated publishing → repository `sxnnyside-project/dart-sei`, tag
pattern `v{{version}}`.

## Review criteria

- `just check` must pass before merge.
- New/changed public API needs a CHANGELOG.md entry and dartdoc.
- Icon additions/removals must go through `tool/generate_icons.dart`, never
  hand-edited generated files.

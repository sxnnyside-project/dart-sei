# Contributing to dart_sei

Thank you for your interest in contributing to **dart_sei**, the pure-Dart
(Flutter-free) layer for Sxnnyside Eloquent Icons (SEI).

This document explains how to contribute without friction.

---

## Before You Start

Please read the following documents first:

* `README.md`
* `CLAUDE.md` — architecture, topology, and API rules
* `CODE_OF_CONDUCT.md`

If your idea conflicts with any of these, it is unlikely to be accepted.

---

## Scope

This repository provides SEI icons as pure Dart — inlined SVG data, no
Flutter dependency. It does not design or maintain the icons themselves,
and it does not implement Flutter widgets (see `flutter_sei` for that).

* **Want a new icon design or concept?** Open that request on the
  [SEI icons repository](https://github.com/sxnnyside-project/sxnnyside-eloquent-icons/issues)
  instead — it's out of scope here.
* **Want a new icon already in SEI exposed through this package?** In
  scope — see "Icon Sync" below.
* **Want a Dart API change** (new helper, a fix, better ergonomics for
  Jaspr/server-side/CLI use)? In scope.

---

## What You Can Contribute

### Icon Sync

If an icon exists in [SEI](https://github.com/sxnnyside-project/sxnnyside-eloquent-icons)
but not yet in this package:

```bash
dart run tool/generate_icons.dart
dart format .
just check
```

See `CLAUDE.md` for the full procedure. Never hand-edit a file marked
`GENERATED CODE`.

### Code Contributions

You may contribute:

* Bug fixes.
* API ergonomics improvements that don't break existing usage without
  justification (see `CLAUDE.md`'s public API rules).
* Documentation improvements.
* Test coverage for existing behavior.
* Integration examples for specific frameworks (Jaspr, Shelf, Dart Frog,
  Serverpod) — small, focused, in `example/` or linked from `README.md`.

Each change should:

* Pass `just check` (format, lint, typecheck, test, publish dry-run).
* Include a `CHANGELOG.md` entry.
* Include dartdoc for any new or changed public API.

---

## What Is Not Accepted

* New icon *designs* — submit those to the SEI icons repository.
* A Flutter dependency of any kind — that's what `flutter_sei` is for.
* Unreviewed AI-generated code that doesn't meet the project's quality bar
  (see `CODE_OF_CONDUCT.md`).
* Breaking API changes without a documented rationale in the PR description
  and a corresponding `CHANGELOG.md` entry.
* Large, unsolicited refactors that aren't discussed in an issue first.

---

## Contribution Process

1. Open an issue describing your idea or request.
2. Wait for confirmation or discussion.
3. Submit a focused pull request.
4. Be open to feedback and iteration.

Maintainers may request changes or close pull requests that do not align
with the project.

---

## Commit Style

This project uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). Every commit message follows:

```
<type>: <description>

[optional body]
[optional footer]
```

| Type       | Use for                                   |
|------------|---------------------------------------------|
| `feat`     | New API surface or a newly synced icon    |
| `fix`      | Bug fixes                                 |
| `docs`     | Documentation only                        |
| `style`    | Formatting, whitespace — no logic changes |
| `refactor` | Code restructure without behavior change  |
| `test`     | Adding or updating tests                  |
| `chore`    | Build process, tooling, dependencies      |
| `perf`     | Performance improvements                  |

Examples:

```
feat: add Sei.svgByNameOrNull
fix: escape ampersands in custom SVG attributes
chore: pin frontend_server_client for downgrade compatibility
```

---

## Questions

If something in the codebase is unclear, open an issue with the `question`
label before assuming it's a bug.

---

*dart_sei is part of the [Sxnnyside Project](https://sxnnysideproject.com).*

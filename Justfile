# dart_sei — Task Runner Abstraction Layer (DXQE Part 3)
#
# Dart has no separate type-checker from its linter — `dart analyze` does
# both in one pass — so `typecheck` and `lint` intentionally run the same
# underlying command here. That's Dart's tooling reality, not a shortcut.

install:
    dart pub get

dev:
    dart run example/example.dart

build:
    mkdir -p build
    dart compile exe example/example.dart -o build/example

test:
    dart test

typecheck:
    dart analyze

lint:
    dart analyze

format:
    dart format .

format-check:
    dart format --output=none --set-exit-if-changed .

check: format-check lint typecheck test
    dart pub publish --dry-run

clean:
    rm -rf .dart_tool build

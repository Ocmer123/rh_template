# 0004 Python standard library for repository tooling

Status: Accepted
Date: 2026-11-21

## Context

The docs index and release helpers must run in CI and on every developer's machine without the Flutter toolchain, and must be easy to read.

## Decision

Write repository tooling as small Python scripts in `tool/` that use only the standard library and support Python 3.7+: `docs_index.py` and `release.py`. Shell is used only for the thin wrappers (`setup.sh`, `coverage_check.sh`).

## Alternatives considered

- **Dart scripts:** they need the Flutter SDK in every job that uses them.
- **Node tooling (semantic-release, changesets):** an extra runtime and a large dependency tree for a few simple tasks.

## Consequences

Contributors need Python 3.7 or newer. The app itself stays pure Dart.

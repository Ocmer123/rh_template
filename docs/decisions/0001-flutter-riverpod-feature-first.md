# 0001 Flutter, Riverpod and a feature-first layered layout

Status: Accepted
Date: 2026-11-21

## Context

New apps should start with a structure that scales past a few screens, keeps logic testable without Flutter, and works the same way in every project.

## Decision

Use Flutter (stable) with Material 3, and `flutter_riverpod` without code generation for dependency injection and state. Organise the code by feature, with a `domain / data / application / ui` layer per feature, and dependencies pointing inward to `domain`.

## Alternatives considered

- **Layer-first folders** (`lib/models`, `lib/screens`, ...): simple at first, but features become scattered and coupled.
- **Bloc:** solid, but it needs more boilerplate per feature. Riverpod's overrides make tests simpler.
- **Riverpod with codegen:** less boilerplate, but it adds `build_runner` to every project. It can be added per project later.

## Consequences

Domain logic is pure Dart and unit-testable. Every feature has the same shape, which helps both people and Claude. The small counter feature shows the pattern and should be deleted once real features exist.

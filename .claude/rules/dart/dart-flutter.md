---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---

# Dart and Flutter

- Follow `analysis_options.yaml`. `flutter analyze --fatal-infos` must report nothing. Do not add `// ignore:` without a comment that explains why.
- Use package imports only (`package:rh_template/...`) inside `lib/`.
- Use `const` wherever possible. Prefer immutable classes with `final` fields and `copyWith`.
- Extract a widget once a `build` method passes about 60 lines. Use private widget classes, not helper methods that return widgets.
- Keep business logic out of widgets and `build` methods.
- Riverpod: `ref.watch` in `build`, `ref.read` in callbacks, never `ref.read` in `build`. Dispose controllers, streams and subscriptions.
- Async: no fire-and-forget futures. Use `await`, or `unawaited(...)` with a comment that says why. Check `context.mounted` after an `await` before you use `context`.
- Pattern matching: use exhaustive `switch` expressions on sealed classes and enums.
- Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/app_localizations*.dart`) are never edited by hand and never committed.
- Strings: add each key to `lib/l10n/app_en.arb` with an `@key` description, then use it through `AppLocalizations.of(context)`.
- Accessibility: give every interactive widget a tooltip or semantics label, make touch targets at least 48 px (`Tokens.minTapTarget`), make layouts work at 200 % text scale, and respect `MediaQuery.disableAnimations`.

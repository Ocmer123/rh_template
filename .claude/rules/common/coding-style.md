# Coding style

- **Immutability first.** Domain types are immutable (`final` fields, `const` constructors, `copyWith`). Collections exposed from domain objects are unmodifiable.
- **Small units.** Functions under about 40 lines. Files under about 400 lines, 800 is the hard cap. Split long `build` methods into private widgets.
- **One concept per file.** The file name is the main type in `snake_case`.
- **No magic values.** Colours, spacing, radii and durations come from `lib/core/theme/tokens.dart`. Tunable numbers (prices, limits, timings) live in config or JSON assets, not in code.
- **No user-visible strings in code.** They go in `lib/l10n/app_en.arb`, even while only English ships.
- **Explicit errors.** Never swallow exceptions. The data layer returns typed results or throws typed exceptions, and the UI shows a designed error state.
- **Naming.** `UpperCamelCase` types, `lowerCamelCase` members, `_private` helpers. Booleans read as questions (`isDone`, `hasCache`).
- **Comments explain why, not what.** Public APIs in `domain/` get `///` doc comments.
- Delete dead code; do not comment it out. No `TODO` without an issue number.
- Prefer clarity over cleverness. Three similar lines are better than a premature abstraction.

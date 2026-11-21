---
name: new-feature
description: Scaffold a new feature folder (domain, data, application, ui) with matching tests, following the counter reference feature. Use when adding a feature to lib/features/.
---

# New feature scaffold

Copy the shape of `lib/features/counter/`, which is the reference implementation.

```text
lib/features/<feature>/
  domain/        <entity>.dart, <feature>_repository.dart (interface)   - pure Dart
  data/          <impl>_<feature>_repository.dart, DTOs, parsers        - IO lives here
  application/   <feature>_providers.dart (Provider + Notifier)         - wiring
  ui/            <feature>_screen.dart, private widgets                 - rendering only
test/features/<feature>/
  domain/ data/ application/ ui/                                        - mirrors lib/
```

Steps:

1. Domain first, test first (`/tdd`): entities, value objects and the repository interface.
2. Data: implement the interface. Test it against fixtures or an in-memory backend.
3. Application: a `Provider` for the repository and a `Notifier`/`AsyncNotifier` for state. Test it with `ProviderContainer` overrides.
4. UI: a `ConsumerWidget` that switches on the state. Add widget tests for the loading, data, empty and error states.
5. Add strings to `lib/l10n/app_en.arb`, run `flutter gen-l10n`, and add tokens to `tokens.dart` if you need new values.
6. Update `docs/architecture/overview.md` (the feature list) and add a CHANGELOG line.

When the template's counter feature is no longer useful as an example, delete `lib/features/counter/` and `test/features/counter/` in a `chore` PR.

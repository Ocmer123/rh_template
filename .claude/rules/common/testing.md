# Testing

- **TDD for logic.** Write the failing test first (RED), the minimal code (GREEN), then refactor. This is mandatory for everything in `domain/` and for parsers, repositories and state notifiers.
- **Coverage gate.** `lib/features/*/domain` and `lib/features/*/data` keep at least 80 % line coverage (`tool/coverage_check.sh`, enforced in CI). UI gets widget tests for its key states (loading, data, empty, error) and its main interactions.
- **Layout mirrors `lib/`.** `lib/features/auth/domain/session.dart` is tested in `test/features/auth/domain/session_test.dart`. Shared helpers live in `test/support/`.
- **Deterministic.** Never call `DateTime.now()` or create an unseeded `Random` in domain code. Inject a `Clock` (`lib/core/utils/clock.dart`, with `test/support/fake_clock.dart` in tests) and a seedable `Random`. Never `sleep` or wait on real time.
- **No network in tests.** Parsers run against saved fixtures in `test/fixtures/`, and HTTP clients are faked.
- **Widget tests** use `tester.pumpApp(...)` from `test/support/pump_app.dart`, which adds the theme, localisation and a `ProviderScope` with overrides.
- **Names describe behaviour:** `decrement never goes below zero`, not `test decrement`.
- **A bug fix starts with a test that reproduces the bug.**
- Golden tests are optional. If you add them, keep them under `test/goldens/` and tag them `golden`.
- Before saying a task is done, run `flutter analyze --fatal-infos` and `flutter test`, then report the real output. Never claim that tests pass without having run them.

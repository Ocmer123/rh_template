---
name: tdd-workflow
description: Red-green-refactor workflow for Dart domain logic, parsers, repositories and Riverpod notifiers, with examples of fakes, clocks and provider overrides. Use when implementing logic or fixing a bug.
---

# TDD workflow

## 1. RED: describe the behaviour

Put the test in the path that mirrors `lib/`. Name it after the behaviour.

```dart
test('decrement never goes below zero', () {
  expect(Counter.zero.decrement(), Counter.zero);
});
```

Run `flutter test test/features/<feature>/` and confirm that it fails **for the reason you expect**: a missing method or a wrong value, not a typo.

## 2. GREEN: the minimal code

Write only enough code to pass. Run the tests again.

## 3. REFACTOR

Remove duplication and improve names while the tests stay green.

## Building blocks

- **Time:** `FakeClock(DateTime.utc(2026, 1, 1))` from `test/support/fake_clock.dart`, then `clock.advance(...)`.
- **Randomness:** `Random(42)`. Assert on the outcome of a seed, not on implementation details.
- **Repositories:** use the in-memory implementation, or a small fake that implements the domain interface.
- **Notifiers:**

  ```dart
  final container = ProviderContainer(
    overrides: [counterRepositoryProvider.overrideWithValue(fake)],
  );
  addTearDown(container.dispose);
  await container.read(counterControllerProvider.future);
  ```

- **Widgets:** `await tester.pumpApp(const MyScreen(), overrides: [...])`, then find widgets by key, tooltip or text.
- **Fixtures:** keep saved responses in `test/fixtures/` and read them with `File('test/fixtures/x.json')`.

## Edge cases to cover

Empty, zero, one, many, boundaries (first and last day, midnight, DST), invalid input, errors from dependencies, and repeated calls (idempotency).

Reference: `test/features/counter/` covers every layer.

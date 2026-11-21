# Patterns

- **Feature-first, layered.** `lib/features/<feature>/{domain,data,application,ui}`. Dependencies point `ui -> application -> domain <- data`. `domain` imports neither Flutter, `data` nor `ui`. Features talk to each other only through `domain` types and `application` providers.
- **Repository pattern.** The interface is declared in `domain/` (`abstract interface class CounterRepository`) and implemented in `data/`. Providers return the interface, so tests can override it with a fake.
- **Riverpod without codegen.** `Provider` for dependencies, `Notifier`/`AsyncNotifier` for state. In tests, swap implementations with `overrideWithValue`. Use `ref.watch` in `build` and `ref.read` in callbacks.
- **Sealed results over nulls.** Model async or failure states as sealed classes or `AsyncValue`, and switch on them exhaustively. Never use a `default:` that hides new cases.
- **Injected time and randomness.** Every time-dependent class takes a `Clock`, and every random one takes a `Random`.
- **Dumb widgets.** Widgets render state and emit callbacks; logic lives in notifiers or in the domain. See `lib/features/counter/` for the reference implementation.
- **Config over code.** Anything a designer or product owner might tune lives in a JSON asset or `tokens.dart`, validated on load.
- **Environment switches** go through `AppEnv.current`, never through ad-hoc `bool` flags.

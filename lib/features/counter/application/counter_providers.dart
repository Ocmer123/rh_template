import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rh_template/features/counter/data/in_memory_counter_repository.dart';
import 'package:rh_template/features/counter/domain/counter.dart';
import 'package:rh_template/features/counter/domain/counter_repository.dart';

/// The repository behind the counter. Override in tests.
final counterRepositoryProvider = Provider<CounterRepository>(
  (ref) => InMemoryCounterRepository(),
);

/// Loads the counter and applies user actions, saving after each change.
final counterControllerProvider =
    AsyncNotifierProvider<CounterController, Counter>(CounterController.new);

class CounterController extends AsyncNotifier<Counter> {
  @override
  Future<Counter> build() => ref.watch(counterRepositoryProvider).load();

  Future<void> increment() => _update((c) => c.increment());

  Future<void> decrement() => _update((c) => c.decrement());

  Future<void> reset() => _update((_) => Counter.zero);

  Future<void> _update(Counter Function(Counter current) change) async {
    final current = state.value;
    if (current == null) return;
    final next = change(current);
    state = AsyncData(next);
    await ref.read(counterRepositoryProvider).save(next);
  }
}

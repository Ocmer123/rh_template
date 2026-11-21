import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rh_template/features/counter/application/counter_providers.dart';
import 'package:rh_template/features/counter/data/in_memory_counter_repository.dart';
import 'package:rh_template/features/counter/domain/counter.dart';

void main() {
  late InMemoryCounterRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = InMemoryCounterRepository(const Counter(1));
    container = ProviderContainer(
      overrides: [counterRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  Future<Counter> loaded() => container.read(counterControllerProvider.future);

  CounterController controller() =>
      container.read(counterControllerProvider.notifier);

  test('loads the stored counter', () async {
    expect(await loaded(), const Counter(1));
  });

  test('increment updates state and saves', () async {
    await loaded();

    await controller().increment();

    expect(container.read(counterControllerProvider).value, const Counter(2));
    expect(await repository.load(), const Counter(2));
  });

  test('decrement stops at zero', () async {
    await loaded();

    await controller().decrement();
    await controller().decrement();

    expect(container.read(counterControllerProvider).value, Counter.zero);
  });

  test('reset goes back to zero and saves', () async {
    await loaded();

    await controller().reset();

    expect(await repository.load(), Counter.zero);
  });
}

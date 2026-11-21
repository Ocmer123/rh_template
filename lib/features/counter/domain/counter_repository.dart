import 'package:rh_template/features/counter/domain/counter.dart';

/// Persists the [Counter]. Declared in `domain/`, implemented in `data/`, so
/// providers expose the interface and tests can swap in a fake.
abstract interface class CounterRepository {
  Future<Counter> load();

  Future<void> save(Counter counter);
}

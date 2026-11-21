import 'package:rh_template/features/counter/domain/counter.dart';
import 'package:rh_template/features/counter/domain/counter_repository.dart';

/// Keeps the counter in memory. Replace with a `shared_preferences` or Drift
/// implementation when the value must survive a restart.
class InMemoryCounterRepository implements CounterRepository {
  InMemoryCounterRepository([Counter initial = Counter.zero])
    : _stored = initial;

  Counter _stored;

  @override
  Future<Counter> load() async => _stored;

  @override
  Future<void> save(Counter counter) async => _stored = counter;
}

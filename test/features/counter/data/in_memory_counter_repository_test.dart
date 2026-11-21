import 'package:flutter_test/flutter_test.dart';
import 'package:rh_template/features/counter/data/in_memory_counter_repository.dart';
import 'package:rh_template/features/counter/domain/counter.dart';

void main() {
  group('InMemoryCounterRepository', () {
    test('starts at zero by default', () async {
      expect(await InMemoryCounterRepository().load(), Counter.zero);
    });

    test('returns what was saved', () async {
      final repository = InMemoryCounterRepository();

      await repository.save(const Counter(4));

      expect(await repository.load(), const Counter(4));
    });

    test('can start from a given value', () async {
      final repository = InMemoryCounterRepository(const Counter(9));

      expect(await repository.load(), const Counter(9));
    });
  });
}

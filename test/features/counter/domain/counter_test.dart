import 'package:flutter_test/flutter_test.dart';
import 'package:rh_template/features/counter/domain/counter.dart';

void main() {
  group('Counter', () {
    test('increment returns a new counter one higher', () {
      const start = Counter(2);

      final next = start.increment();

      expect(next, const Counter(3));
      expect(start, const Counter(2), reason: 'counters are immutable');
    });

    test('decrement returns a counter one lower', () {
      expect(const Counter(3).decrement(), const Counter(2));
    });

    test('decrement never goes below zero', () {
      expect(Counter.zero.decrement(), Counter.zero);
    });

    test('equal values are equal and share a hash code', () {
      expect(const Counter(5), const Counter(5));
      expect(const Counter(5).hashCode, const Counter(5).hashCode);
      expect(const Counter(5), isNot(const Counter(6)));
    });

    test('toString shows the value', () {
      expect(const Counter(7).toString(), 'Counter(7)');
    });
  });
}

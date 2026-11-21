/// An immutable, never-negative count.
///
/// Example domain type: pure Dart, no Flutter imports, value equality,
/// and operations that return a new instance instead of mutating.
final class Counter {
  const Counter(this.value)
    : assert(value >= 0, 'Counter value cannot be negative');

  static const Counter zero = Counter(0);

  final int value;

  /// Returns a counter one higher.
  Counter increment() => Counter(value + 1);

  /// Returns a counter one lower, or this counter when it is already zero.
  Counter decrement() => value == 0 ? this : Counter(value - 1);

  @override
  bool operator ==(Object other) => other is Counter && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Counter($value)';
}

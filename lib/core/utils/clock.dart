/// Source of the current time. Domain code takes a [Clock] instead of calling
/// `DateTime.now()`, so tests can control time (see `test/support/fake_clock.dart`).
abstract interface class Clock {
  DateTime now();
}

/// The real wall clock.
class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}

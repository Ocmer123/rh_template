import 'package:rh_template/core/utils/clock.dart';

/// A clock that only moves when the test tells it to.
class FakeClock implements Clock {
  FakeClock(this._now);

  DateTime _now;

  @override
  DateTime now() => _now;

  void advance(Duration by) => _now = _now.add(by);
}

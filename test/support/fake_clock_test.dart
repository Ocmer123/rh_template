import 'package:flutter_test/flutter_test.dart';

import 'fake_clock.dart';

void main() {
  test('FakeClock only moves when advanced', () {
    final clock = FakeClock(DateTime.utc(2026, 1, 1, 9));

    expect(clock.now(), DateTime.utc(2026, 1, 1, 9));

    clock.advance(const Duration(minutes: 30));

    expect(clock.now(), DateTime.utc(2026, 1, 1, 9, 30));
  });
}

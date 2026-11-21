import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rh_template/features/counter/application/counter_providers.dart';
import 'package:rh_template/features/counter/data/in_memory_counter_repository.dart';
import 'package:rh_template/features/counter/domain/counter.dart';
import 'package:rh_template/features/counter/ui/counter_screen.dart';

import '../../../support/pump_app.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester, Counter initial) async {
    await tester.pumpApp(
      const CounterScreen(),
      overrides: [
        counterRepositoryProvider.overrideWithValue(
          InMemoryCounterRepository(initial),
        ),
      ],
    );
    await tester.pumpAndSettle();
  }

  String shownValue(WidgetTester tester) =>
      tester.widget<Text>(find.byKey(const Key('counter-value'))).data!;

  testWidgets('shows the stored value', (tester) async {
    await pumpScreen(tester, const Counter(3));

    expect(shownValue(tester), '3');
  });

  testWidgets('the + button increments', (tester) async {
    await pumpScreen(tester, Counter.zero);

    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();

    expect(shownValue(tester), '1');
  });

  testWidgets('the - button decrements and reset clears', (tester) async {
    await pumpScreen(tester, const Counter(5));

    await tester.tap(find.byTooltip('Decrement'));
    await tester.pump();
    expect(shownValue(tester), '4');

    await tester.tap(find.byTooltip('Reset'));
    await tester.pump();
    expect(shownValue(tester), '0');
  });
}

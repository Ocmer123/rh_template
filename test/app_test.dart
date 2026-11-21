import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rh_template/app.dart';
import 'package:rh_template/core/config/app_env.dart';

void main() {
  testWidgets('dev builds show a DEV banner', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.byType(Banner), findsOneWidget);
    expect(find.text('RH Template'), findsOneWidget);
  });

  testWidgets('prod builds show no banner', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App(env: AppEnv.prod)));
    await tester.pumpAndSettle();

    expect(find.byType(Banner), findsNothing);
  });
}

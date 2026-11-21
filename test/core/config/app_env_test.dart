import 'package:flutter_test/flutter_test.dart';
import 'package:rh_template/core/config/app_env.dart';

void main() {
  group('AppEnv.parse', () {
    test('prod only when explicitly prod', () {
      expect(AppEnv.parse('prod'), AppEnv.prod);
      expect(AppEnv.parse('prod').isProd, isTrue);
    });

    test('anything else falls back to dev', () {
      for (final raw in [null, '', 'dev', 'PROD', 'production', 'staging']) {
        expect(AppEnv.parse(raw), AppEnv.dev, reason: 'raw value: $raw');
      }
    });
  });

  test('tests run as dev unless APP_ENV=prod is defined', () {
    expect(AppEnv.current, AppEnv.dev);
  });
}

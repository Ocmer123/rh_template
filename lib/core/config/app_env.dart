/// Which environment this build targets. Set at build time:
///
///     flutter run --dart-define=APP_ENV=dev
///     flutter build appbundle --release --dart-define=APP_ENV=prod
///
/// The dev pipeline builds `dev`, the release pipeline (main) builds `prod`.
/// Anything not explicitly `prod` is treated as `dev`, so a misconfigured
/// build can never pretend to be production.
enum AppEnv {
  dev,
  prod;

  /// The environment of the running build.
  static const AppEnv current = String.fromEnvironment('APP_ENV') == 'prod'
      ? AppEnv.prod
      : AppEnv.dev;

  /// Parses a raw value the same way [current] does.
  static AppEnv parse(String? raw) => raw == 'prod' ? AppEnv.prod : AppEnv.dev;

  bool get isProd => this == AppEnv.prod;
}

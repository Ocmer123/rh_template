import 'package:material_ui/material_ui.dart';
import 'package:rh_template/core/theme/tokens.dart';

/// Material 3 themes built from [Tokens].
abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Tokens.seed,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Tokens.radiusMd)),
        ),
      ),
    );
  }
}

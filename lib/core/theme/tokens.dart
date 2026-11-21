import 'package:flutter/material.dart';

/// Design tokens. Widgets read colours, spacing, radii and durations from here,
/// never from literals, so the look can change in one place.
abstract final class Tokens {
  static const Color seed = Color(0xFF3D6FB6);

  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;

  static const double radiusMd = 12;

  /// Minimum touch target (Material and WCAG guidance).
  static const double minTapTarget = 48;

  static const Duration animShort = Duration(milliseconds: 150);
}

import 'package:flutter/material.dart';

/// Border radius tokens.
///
/// Usage:
/// ```dart
/// BorderRadius.circular(AppRadii.md);
/// ```

abstract class AppRadii {
  AppRadii._();

  /// 4px — small rounding
  static const double sm = 4;

  /// 8px — medium rounding (default)
  static const double md = 8;

  /// 12px — large rounding
  static const double lg = 12;

  /// 16px — extra large rounding
  static const double xl = 16;

  /// 999px — pill/capsule shape
  static const double pill = 999;

  // -- BorderRadius presets --

  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius borderRadiusPill = BorderRadius.all(Radius.circular(pill));
}

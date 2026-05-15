import 'package:flutter/material.dart';

/// 4px grid spacing tokens and EdgeInsets presets.
///
/// Usage:
/// ```dart
/// SizedBox(height: AppSpacing.md);
/// Padding(padding: AppSpacing.paddingAllMd);
/// ```

abstract class AppSpacing {
  AppSpacing._();

  // -- Base values (4px grid) --

  /// 4px — extra extra small
  static const double xxs = 4;

  /// 8px — extra small
  static const double xs = 8;

  /// 12px — small
  static const double sm = 12;

  /// 16px — medium (default)
  static const double md = 16;

  /// 24px — large
  static const double lg = 24;

  /// 32px — extra large
  static const double xl = 32;

  /// 48px — extra extra large
  static const double xxl = 48;

  // -- EdgeInsets presets --

  static const EdgeInsets paddingAllXxs = EdgeInsets.all(xxs);
  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingAllXxl = EdgeInsets.all(xxl);

  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets paddingVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
}

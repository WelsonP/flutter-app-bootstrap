import 'package:flutter/material.dart';

/// Named color aliases and Material 3 ColorScheme definitions.
///
/// Usage:
/// ```dart
/// final color = AppColors.of(context).primary;
/// Container(color: context.colorScheme.primary);
/// ```

abstract class AppColors {
  AppColors._();

  /// Seed color for the color scheme generation.
  static const Color seed = Color(0xFF4A90D9);

  // -- Semantic color aliases --

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  /// Light ColorScheme generated from the seed color.
  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
  );

  /// Dark ColorScheme generated from the seed color.
  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
  );
}

/// Extension for easy access to the current ColorScheme from BuildContext.
extension AppColorsExtension on BuildContext {
  /// The current ColorScheme from the theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

import 'package:flutter/material.dart';

/// Consistent icon wrapper for the design system.
///
/// Wraps a Material Icon with standardized sizing and color handling.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.medium,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final AppIconSize size;
  final Color? color;
  final String? semanticLabel;

  double get _sizeValue => switch (size) {
    AppIconSize.small => 16,
    AppIconSize.medium => 24,
    AppIconSize.large => 32,
    AppIconSize.xlarge => 48,
  };

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _sizeValue,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}

enum AppIconSize { small, medium, large, xlarge }

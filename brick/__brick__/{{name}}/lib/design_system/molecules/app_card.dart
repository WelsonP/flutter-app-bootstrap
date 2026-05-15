import 'package:flutter/material.dart';

import '../tokens/spacing.dart';
import '../tokens/radii.dart';
import '../tokens/shadows.dart';

/// Design system card component.
///
/// Supports optional header, footer, and elevation presets.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.elevation = AppCardElevation.subtle,
    this.padding,
    this.margin,
    this.onTap,
    this.showBorder = true,
  });

  final Widget child;
  final Widget? header;
  final Widget? footer;
  final AppCardElevation elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: _elevationValue,
      shadowColor: Theme.of(context).shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.borderRadiusMd,
        side: showBorder
            ? BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(128),
        )
            : BorderSide.none,
      ),
      margin: margin ?? EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) header!,
          Padding(
            padding: padding ?? AppSpacing.paddingAllMd,
            child: child,
          ),
          if (footer != null) footer!,
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppRadii.borderRadiusMd,
        child: card,
      );
    }

    return card;
  }

  double get _elevationValue => switch (elevation) {
    AppCardElevation.flat => 0,
    AppCardElevation.subtle => 1,
    AppCardElevation.medium => 3,
    AppCardElevation.prominent => 8,
  };
}

enum AppCardElevation { flat, subtle, medium, prominent }

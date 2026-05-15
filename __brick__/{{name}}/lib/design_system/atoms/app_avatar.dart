import 'package:flutter/material.dart';

/// Design system avatar component.
///
/// Supports image, initials, and multiple sizes.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = AppAvatarSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  final String? imageUrl;
  final String? initials;
  final AppAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  double get _diameter => switch (size) {
    AppAvatarSize.small => 32,
    AppAvatarSize.medium => 48,
    AppAvatarSize.large => 72,
    AppAvatarSize.xlarge => 96,
  };

  double get _fontSize => switch (size) {
    AppAvatarSize.small => 14,
    AppAvatarSize.medium => 20,
    AppAvatarSize.large => 32,
    AppAvatarSize.xlarge => 40,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    final avatar = CircleAvatar(
      radius: _diameter / 2,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null && initials != null
          ? Text(
        initials!,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.w600,
        ),
      )
          : null,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: avatar,
      );
    }

    return avatar;
  }
}

enum AppAvatarSize { small, medium, large, xlarge }

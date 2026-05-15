import 'package:flutter/material.dart';

import '../../../design_system/atoms/app_icon.dart';
import '../../../design_system/tokens/spacing.dart';

/// Quick action chips displayed in a Wrap layout.
class QuickActionChip extends StatelessWidget {
  const QuickActionChip({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      onPressed: onTap,
      avatar: AppIcon(icon, size: AppIconSize.small),
      label: Text(label),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

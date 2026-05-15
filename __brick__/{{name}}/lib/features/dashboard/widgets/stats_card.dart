import 'package:flutter/material.dart';

import '../../../design_system/tokens/spacing.dart';
// ignore_for_file: prefer_const_constructors

import '../../../design_system/tokens/radii.dart';
import '../../../design_system/atoms/app_icon.dart';

/// Stats card widget for the dashboard home screen.
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = color ?? theme.colorScheme.primaryContainer;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.borderRadiusMd,
      ),
      child: Padding(
        padding: AppSpacing.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cardColor.withAlpha(128),
                borderRadius: AppRadii.borderRadiusSm,
              ),
              child: AppIcon(icon, color: cardColor),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../tokens/spacing.dart';
import '../tokens/radii.dart';

/// Design system chip component.
///
/// Supports selectable, dismissible, and icon variants.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.leadingIcon,
    this.backgroundColor,
    this.selectedColor,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onDeleted;
  final Widget? leadingIcon;
  final Color? backgroundColor;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (onDeleted != null) {
      return InputChip(
        label: Text(label),
        selected: selected,
        onSelected: (value) => onSelected?.call(value),
        onDeleted: onDeleted,
        avatar: leadingIcon,
        backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
        selectedColor: selectedColor ?? theme.colorScheme.secondaryContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.borderRadiusPill,
        ),
      );
    }

    if (onSelected != null) {
      return FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (value) => onSelected!.call(value),
        avatar: leadingIcon,
        backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
        selectedColor: selectedColor ?? theme.colorScheme.secondaryContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.borderRadiusPill,
        ),
      );
    }

    // Static chip
    return Chip(
      label: Text(label),
      avatar: leadingIcon,
      backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.borderRadiusPill,
      ),
    );
  }
}

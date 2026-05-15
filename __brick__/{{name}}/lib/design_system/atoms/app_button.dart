// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:flutter/material.dart';

import '../tokens/spacing.dart';
import '../tokens/radii.dart';

/// Design system button with variants, sizes, states, and icon support.
///
/// Variants: primary (filled), secondary (tonal), outline, ghost
/// Sizes: small, medium, large
/// States: default, disabled, loading
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool expand;

  // Convenience constructors
  factory AppButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
  }) =>
      AppButton(
        key: key,
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.primary,
        isLoading: isLoading,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        expand: expand,
      );

  factory AppButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
  }) =>
      AppButton(
        key: key,
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.secondary,
        isLoading: isLoading,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        expand: expand,
      );

  factory AppButton.outline({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
  }) =>
      AppButton(
        key: key,
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.outline,
        isLoading: isLoading,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        expand: expand,
      );

  factory AppButton.ghost({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
  }) =>
      AppButton(
        key: key,
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.ghost,
        isLoading: isLoading,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        expand: expand,
      );

  @override
  Widget build(BuildContext context) {
    final button = switch (variant) {
      AppButtonVariant.primary => _buildFilled(context),
      AppButtonVariant.secondary => _buildFilledTonal(context),
      AppButtonVariant.outline => _buildOutlined(context),
      AppButtonVariant.ghost => _buildText(context),
    };

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildFilled(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: _buttonStyle(context),
      child: _buildChild(context),
    );
  }

  Widget _buildFilledTonal(BuildContext context) {
    return FilledButton.tonal(
      onPressed: isLoading ? null : onPressed,
      style: _buttonStyle(context),
      child: _buildChild(context),
    );
  }

  Widget _buildOutlined(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: _buttonStyle(context),
      child: _buildChild(context),
    );
  }

  Widget _buildText(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: _buttonStyle(context),
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: variant == AppButtonVariant.primary
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
      );
    }

    final children = <Widget>[];
    if (leadingIcon != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(right: AppSpacing.xs),
        child: leadingIcon,
      ));
    }
    children.add(Text(label));
    if (trailingIcon != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(left: AppSpacing.xs),
        child: trailingIcon,
      ));
    }

    if (children.length == 1) return children.first;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final basePadding = switch (size) {
      AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    };

    return ButtonStyle(
      padding: WidgetStateProperty.all(basePadding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: AppRadii.borderRadiusMd,
        ),
      ),
    );
  }

  double get _iconSize => switch (size) {
    AppButtonSize.small => 16,
    AppButtonSize.medium => 20,
    AppButtonSize.large => 24,
  };
}

enum AppButtonVariant { primary, secondary, outline, ghost }

enum AppButtonSize { small, medium, large }

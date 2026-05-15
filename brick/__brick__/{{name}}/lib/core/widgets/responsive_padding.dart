import 'package:flutter/material.dart';

/// Responsive padding helper that adapts to screen width.
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.tablet = const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    this.desktop = const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
    this.breakpoint = 600,
    this.wideBreakpoint = 1200,
  });

  final Widget child;
  final EdgeInsets mobile;
  final EdgeInsets tablet;
  final EdgeInsets desktop;
  final double breakpoint;
  final double wideBreakpoint;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = width >= wideBreakpoint
        ? desktop
        : width >= breakpoint
            ? tablet
            : mobile;
    return Padding(padding: padding, child: child);
  }
}

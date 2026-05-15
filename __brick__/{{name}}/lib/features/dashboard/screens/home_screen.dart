import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/responsive_padding.dart';
import '../../../design_system/tokens/colors.dart';
import '../../../design_system/tokens/spacing.dart';
import '../../../design_system/molecules/app_card.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/activity_feed.dart';
import '../widgets/quick_action_chip.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final stats = ref.watch(dashboardStatsProvider);
    final activities = ref.watch(recentActivityProvider);
    final quickActions = ref.watch(quickActionsProvider);

    final greeting = useMemoized(() => _getGreeting(), []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingAllMd,
          child: ResponsivePadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting card
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        "Here's your daily overview",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Stats row
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 600;
                    return Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        SizedBox(
                          width: isWide ? null : double.infinity,
                          child: StatsCard(
                            label: 'Total Tasks',
                            value: stats.totalTasks.toString(),
                            icon: Icons.task_alt,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(
                          width: isWide ? null : double.infinity,
                          child: StatsCard(
                            label: 'Completed',
                            value: stats.completedTasks.toString(),
                            icon: Icons.check_circle_outline,
                            color: AppColors.success,
                          ),
                        ),
                        SizedBox(
                          width: isWide ? null : double.infinity,
                          child: StatsCard(
                            label: 'Day Streak',
                            value: '${stats.currentStreak}',
                            icon: Icons.local_fire_department,
                            color: AppColors.warning,
                          ),
                        ),
                      ].map((child) {
                        if (isWide) {
                          return SizedBox(
                            width: (constraints.maxWidth - AppSpacing.sm * 2) / 3,
                            child: child,
                          );
                        }
                        return SizedBox(width: double.infinity, child: child);
                      }).toList(),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // Recent Activity
                Text(
                  'Recent Activity',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppCard(
                  child: ActivityFeed(items: activities),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Quick Actions
                Text(
                  'Quick Actions',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: quickActions.map((action) {
                    return QuickActionChip(
                      label: action.label,
                      icon: _iconForName(action.icon),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${action.label} tapped')),
                        );
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  IconData _iconForName(String name) {
    return switch (name) {
      'add_task' => Icons.add_task,
      'calendar_month' => Icons.calendar_month,
      'analytics' => Icons.analytics,
      'share' => Icons.share,
      _ => Icons.circle,
    };
  }
}

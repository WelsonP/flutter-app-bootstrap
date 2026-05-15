import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock data for the dashboard feature.
/// Replace with real data sources when implementing your app.

class DashboardStats {
  const DashboardStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.currentStreak,
  });

  final int totalTasks;
  final int completedTasks;
  final int currentStreak;
}

class ActivityItem {
  const ActivityItem({
    required this.title,
    required this.timestamp,
    this.subtitle,
  });

  final String title;
  final DateTime timestamp;
  final String? subtitle;
}

class QuickAction {
  const QuickAction({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final String icon;
}

/// Provider for dashboard statistics.
final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  return const DashboardStats(
    totalTasks: 24,
    completedTasks: 18,
    currentStreak: 7,
  );
});

/// Provider for recent activity feed.
final recentActivityProvider = Provider<List<ActivityItem>>((ref) {
  final now = DateTime.now();
  return [
    ActivityItem(
      title: 'Completed "Design system review"',
      timestamp: now.subtract(const Duration(minutes: 15)),
      subtitle: 'Task',
    ),
    ActivityItem(
      title: 'Updated profile picture',
      timestamp: now.subtract(const Duration(hours: 2)),
      subtitle: 'Account',
    ),
    ActivityItem(
      title: 'Completed "API integration"',
      timestamp: now.subtract(const Duration(hours: 5)),
      subtitle: 'Task',
    ),
    ActivityItem(
      title: 'Started new project',
      timestamp: now.subtract(const Duration(days: 1)),
      subtitle: 'Project',
    ),
    ActivityItem(
      title: 'Reached 7-day streak!',
      timestamp: now.subtract(const Duration(days: 1, hours: 12)),
      subtitle: 'Achievement',
    ),
  ];
});

/// Provider for quick actions.
final quickActionsProvider = Provider<List<QuickAction>>((ref) {
  return const [
    QuickAction(id: '1', label: 'New Task', icon: 'add_task'),
    QuickAction(id: '2', label: 'Schedule', icon: 'calendar_month'),
    QuickAction(id: '3', label: 'Analytics', icon: 'analytics'),
    QuickAction(id: '4', label: 'Share', icon: 'share'),
  ];
});

import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/features/dashboard/providers/dashboard_provider.dart';

void main() {
  group('DashboardStats', () {
    test('should create with correct values', () {
      const stats = DashboardStats(
        totalTasks: 10,
        completedTasks: 5,
        currentStreak: 3,
      );

      expect(stats.totalTasks, 10);
      expect(stats.completedTasks, 5);
      expect(stats.currentStreak, 3);
    });
  });

  group('ActivityItem', () {
    test('should create with correct values', () {
      final now = DateTime.now();
      final item = ActivityItem(
        title: 'Test activity',
        timestamp: now,
        subtitle: 'Test',
      );

      expect(item.title, 'Test activity');
      expect(item.timestamp, now);
      expect(item.subtitle, 'Test');
    });
  });

  group('QuickAction', () {
    test('should create with correct values', () {
      const action = QuickAction(
        id: '1',
        label: 'Test',
        icon: 'test',
      );

      expect(action.id, '1');
      expect(action.label, 'Test');
      expect(action.icon, 'test');
    });
  });

  group('Providers', () {
    test('dashboardStatsProvider should be defined', () {
      expect(dashboardStatsProvider, isNotNull);
    });

    test('recentActivityProvider should be defined', () {
      expect(recentActivityProvider, isNotNull);
    });

    test('quickActionsProvider should be defined', () {
      expect(quickActionsProvider, isNotNull);
    });
  });
}

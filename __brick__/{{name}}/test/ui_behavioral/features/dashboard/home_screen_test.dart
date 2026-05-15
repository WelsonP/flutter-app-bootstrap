import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:{{name}}/features/dashboard/screens/home_screen.dart';

Widget wrapWithProviders(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: child,
    ),
  );
}

void main() {
  group('HomeScreen', () {
    testWidgets('renders greeting and stats', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Recent Activity'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
    });

    testWidgets('shows stats cards', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Total Tasks'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('Day Streak'), findsOneWidget);
    });

    testWidgets('shows quick action chips', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
    });
  });
}

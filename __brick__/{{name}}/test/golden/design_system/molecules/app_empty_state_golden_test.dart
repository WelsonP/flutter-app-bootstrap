import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/molecules/app_empty_state.dart';
import '../../../golden_test_helper.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(body: child),
    );
  }

  group('AppEmptyState golden tests', () {
    testWidgets('basic empty state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppEmptyState(
          icon: Icons.inbox,
          title: 'No items',
          subtitle: 'Add your first item',
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppEmptyState),
        'goldens/app_empty_state_basic.png',
      );
    });

    testWidgets('with action button', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppEmptyState(
          icon: Icons.inbox,
          title: 'No items',
          subtitle: 'Start by adding one',
          actionLabel: 'Add Item',
          onAction: () {},
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppEmptyState),
        'goldens/app_empty_state_action.png',
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/molecules/app_error_state.dart';
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

  group('AppErrorState golden tests', () {
    testWidgets('basic error state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppErrorState(
          message: 'Failed to load data',
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppErrorState),
        'goldens/app_error_state_basic.png',
      );
    });

    testWidgets('with retry', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppErrorState(
          message: 'Network error occurred',
          onRetry: () {},
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppErrorState),
        'goldens/app_error_state_retry.png',
      );
    });
  });
}

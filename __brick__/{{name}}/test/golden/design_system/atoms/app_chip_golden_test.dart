import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/atoms/app_chip.dart';
import '../../../golden_test_helper.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Wrap(spacing: 8, children: [child]),
        ),
      ),
    );
  }

  group('AppChip golden tests', () {
    testWidgets('static chip', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppChip(label: 'Flutter'),
      ));
      await tester.expectGoldenFile(
        find.byType(AppChip),
        'goldens/app_chip_static.png',
      );
    });

    testWidgets('selected chip', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppChip(label: 'Flutter', selected: true, onSelected: (_) {}),
      ));
      await tester.expectGoldenFile(
        find.byType(AppChip),
        'goldens/app_chip_selected.png',
      );
    });
  });
}

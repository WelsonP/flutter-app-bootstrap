import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/molecules/app_card.dart';
import '../../../golden_test_helper.dart';

void main() {
  Widget wrapWithTheme(Widget child, {Brightness brightness = Brightness.light}) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(body: Padding(padding: const EdgeInsets.all(16), child: child)),
    );
  }

  group('AppCard golden tests', () {
    testWidgets('with content light', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppCard(
          header: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.withAlpha(25),
            child: const Text('Header'),
          ),
          footer: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.withAlpha(15),
            child: const Text('Footer'),
          ),
          child: const Text('Card content goes here'),
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppCard),
        'goldens/app_card_light.png',
      );
    });

    testWidgets('with content dark', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppCard(
          child: Text('Dark mode card'),
        ),
        brightness: Brightness.dark,
      ));
      await tester.expectGoldenFile(
        find.byType(AppCard),
        'goldens/app_card_dark.png',
      );
    });
  });
}

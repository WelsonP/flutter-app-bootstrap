import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/design_system/atoms/app_button.dart';

void main() {
  group('AppButton golden tests', () {
    // Helper to wrap in MaterialApp with Theme
    Widget wrapWithTheme(Widget child, {Brightness brightness = Brightness.light}) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: brightness,
          ),
          useMaterial3: true,
        ),
        home: Scaffold(body: Center(child: child)),
      );
    }

    testWidgets('primary variant light', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.primary(onPressed: () {}, label: 'Primary Button'),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_primary_light.png'),
      );
    });

    testWidgets('primary variant dark', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.primary(onPressed: () {}, label: 'Primary Button'),
        brightness: Brightness.dark,
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_primary_dark.png'),
      );
    });

    testWidgets('secondary variant', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.secondary(onPressed: () {}, label: 'Secondary Button'),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_secondary.png'),
      );
    });

    testWidgets('outline variant', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.outline(onPressed: () {}, label: 'Outline Button'),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_outline.png'),
      );
    });

    testWidgets('ghost variant', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.ghost(onPressed: () {}, label: 'Ghost Button'),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_ghost.png'),
      );
    });

    testWidgets('disabled state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppButton.primary(onPressed: null, label: 'Disabled'),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_disabled.png'),
      );
    });

    testWidgets('loading state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppButton.primary(
          onPressed: null,
          label: 'Loading',
          isLoading: true,
        ),
      ));
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('goldens/app_button_loading.png'),
      );
    });
  });
}

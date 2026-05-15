import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/atoms/app_text_field.dart';
import '../../../golden_test_helper.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(body: Padding(padding: const EdgeInsets.all(16), child: child)),
    );
  }

  group('AppTextField golden tests', () {
    testWidgets('outlined variant', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppTextField(label: 'Email', hint: 'Enter email'),
      ));
      await tester.expectGoldenFile(
        find.byType(AppTextField),
        'goldens/app_text_field_outlined.png',
      );
    });

    testWidgets('filled variant', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppTextField(
          label: 'Name',
          variant: AppTextFieldVariant.filled,
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppTextField),
        'goldens/app_text_field_filled.png',
      );
    });

    testWidgets('with error', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppTextField(
          label: 'Email',
          errorText: 'Invalid email address',
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppTextField),
        'goldens/app_text_field_error.png',
      );
    });

    testWidgets('with icons', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppTextField(
          label: 'Search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.clear),
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppTextField),
        'goldens/app_text_field_icons.png',
      );
    });
  });
}

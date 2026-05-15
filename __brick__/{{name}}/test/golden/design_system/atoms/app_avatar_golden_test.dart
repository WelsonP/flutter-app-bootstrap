import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/atoms/app_avatar.dart';
import '../../../golden_test_helper.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('AppAvatar golden tests', () {
    testWidgets('with initials', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppAvatar(initials: 'JD', size: AppAvatarSize.large),
      ));
      await tester.expectGoldenFile(
        find.byType(AppAvatar),
        'goldens/app_avatar_initials.png',
      );
    });

    testWidgets('small size', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppAvatar(initials: 'A', size: AppAvatarSize.small),
      ));
      await tester.expectGoldenFile(
        find.byType(AppAvatar),
        'goldens/app_avatar_small.png',
      );
    });
  });
}

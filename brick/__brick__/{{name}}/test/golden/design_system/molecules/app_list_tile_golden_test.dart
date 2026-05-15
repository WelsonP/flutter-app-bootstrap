import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/design_system/molecules/app_list_tile.dart';

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

  group('AppListTile golden tests', () {
    testWidgets('with all elements', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppListTile(
          leading: const CircleAvatar(child: Text('A')),
          title: const Text('Title'),
          subtitle: const Text('Subtitle'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ));
      await expectLater(
        find.byType(AppListTile),
        matchesGoldenFile('goldens/app_list_tile_full.png'),
      );
    });

    testWidgets('title only', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppListTile(title: Text('Simple')),
      ));
      await expectLater(
        find.byType(AppListTile),
        matchesGoldenFile('goldens/app_list_tile_simple.png'),
      );
    });
  });
}

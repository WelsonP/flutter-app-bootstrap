import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:{{name}}/design_system/molecules/app_list_tile.dart';
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

  group('AppListTile golden tests', () {
    testWidgets('with all elements', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppListTile(
          leading: CircleAvatar(child: Text('A')),
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          trailing: Icon(Icons.chevron_right),
        ),
      ));
      await tester.expectGoldenFile(
        find.byType(AppListTile),
        'goldens/app_list_tile_full.png',
      );
    });

    testWidgets('title only', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const AppListTile(title: Text('Simple')),
      ));
      await tester.expectGoldenFile(
        find.byType(AppListTile),
        'goldens/app_list_tile_simple.png',
      );
    });
  });
}

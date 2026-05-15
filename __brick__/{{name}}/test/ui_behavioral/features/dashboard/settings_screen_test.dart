import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:{{name}}/features/dashboard/screens/settings_screen.dart';
import 'package:{{name}}/core/storage/shared_prefs_provider.dart';

Future<ProviderScope> wrapWithProviders(Widget child) async {
  // Set up mock SharedPreferences so themeModeProvider doesn't crash
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
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
  group('SettingsScreen', () {
    testWidgets('renders settings sections', (tester) async {
      await tester.pumpWidget(await wrapWithProviders(const SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('shows theme mode options', (tester) async {
      await tester.pumpWidget(await wrapWithProviders(const SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Auto'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('has sign out button', (tester) async {
      await tester.pumpWidget(await wrapWithProviders(const SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('shows version info', (tester) async {
      await tester.pumpWidget(await wrapWithProviders(const SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Version'), findsOneWidget);
      expect(find.text('1.0.0'), findsOneWidget);
    });
  });
}

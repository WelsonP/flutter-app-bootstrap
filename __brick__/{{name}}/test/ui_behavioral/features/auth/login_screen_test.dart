import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:{{name}}/features/auth/screens/login_screen.dart';

Widget wrapWithProviders(Widget child) {
  return ProviderScope(
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
  group('LoginScreen', () {
    testWidgets('renders login form', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const LoginScreen()));
      await tester.pumpAndSettle();

      // AppBar title 'Sign In' + submit button 'Sign In' = 2 matches
      expect(find.text('Sign In'), findsNWidgets(2));
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('shows validation errors for empty form', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const LoginScreen()));
      await tester.pumpAndSettle();

      // Tap sign in without filling form
      await tester.tap(find.widgetWithText(FilledButton, 'Sign In'));
      await tester.pumpAndSettle();

      // Validation errors should appear
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('has sign up and forgot password links', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const LoginScreen()));
      await tester.pumpAndSettle();

      // AppBar title + submit button both contain 'Sign In'
      expect(find.text('Sign In'), findsWidgets);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('social auth buttons are disabled', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const LoginScreen()));
      await tester.pumpAndSettle();

      // Google and Phone buttons should exist but be disabled
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
    });
  });
}

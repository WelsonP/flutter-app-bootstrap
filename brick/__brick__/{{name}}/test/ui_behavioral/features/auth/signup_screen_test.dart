import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../lib/features/auth/screens/signup_screen.dart';

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
  group('SignupScreen', () {
    testWidgets('renders signup form', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const SignupScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Create Account'), findsWidgets);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('shows validation errors', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const SignupScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('has sign in link', (tester) async {
      await tester.pumpWidget(wrapWithProviders(const SignupScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
    });
  });
}

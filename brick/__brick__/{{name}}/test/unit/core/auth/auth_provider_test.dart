import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/auth/auth_provider.dart';

void main() {
  group('AuthState', () {
    test('should have three states', () {
      expect(AuthState.values.length, 3);
      expect(AuthState.values, contains(AuthState.authenticated));
      expect(AuthState.values, contains(AuthState.unauthenticated));
      expect(AuthState.values, contains(AuthState.loading));
    });
  });

  group('AuthNotifier provider', () {
    test('authStateProvider should be defined', () {
      expect(authStateProvider, isNotNull);
    });

    test('authNotifierProvider should be defined', () {
      expect(authNotifierProvider, isNotNull);
    });
  });
}

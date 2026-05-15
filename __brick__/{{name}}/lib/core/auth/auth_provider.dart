import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Authentication state enum.
enum AuthState {
  authenticated,
  unauthenticated,
  loading,
}

/// The authentication state provider — reactive, listens to Supabase auth changes.
final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange.map((event) {
    final session = event.session;
    return session != null ? AuthState.authenticated : AuthState.unauthenticated;
  });
});

/// Authentication notifier for actions like signIn, signUp, signOut, resetPassword.
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    // Check initial session
    final session = Supabase.instance.client.auth.currentSession;
    return session != null ? AuthState.authenticated : AuthState.unauthenticated;
  }

  /// Sign in with email and password.
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return AuthState.authenticated;
    });
  }

  /// Sign up with email and password.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      // After sign up, user needs to verify email — stay unauthenticated until verified
      return AuthState.unauthenticated;
    });
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.auth.signOut();
      return AuthState.unauthenticated;
    });
  }

  /// Send password reset email.
  Future<void> resetPassword({required String email}) async {
    await Supabase.instance.client.auth.resetPasswordForEmail(email);
  }
}

/// Helper to extract the current user.
final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

/// Helper to get the current user's email.
final currentUserEmailProvider = Provider<String?>((ref) {
  return Supabase.instance.client.auth.currentUser?.email;
});

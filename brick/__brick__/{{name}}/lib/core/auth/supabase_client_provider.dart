import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provider for the SupabaseClient instance.
/// Reads environment variables configured via --dart-define.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider that validates Supabase environment variables are set.
final supabaseConfigValidProvider = Provider<bool>((ref) {
  final url = const String.fromEnvironment('SUPABASE_URL');
  final anonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');
  return url.isNotEmpty && anonKey.isNotEmpty;
});

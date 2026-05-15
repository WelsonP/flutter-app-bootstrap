import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/auth/auth_provider.dart';
import 'core/auth/supabase_client_provider.dart';
import 'core/logging/app_logger.dart';
import 'core/network/dio_client.dart';
import 'core/storage/shared_prefs_provider.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  AppLogger.init();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Supabase
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  runApp(
    ProviderScope(
      overrides: [
        // Singleton overrides
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: [AppLogger.providerObserver],
      child: const App(),
    ),
  );
}

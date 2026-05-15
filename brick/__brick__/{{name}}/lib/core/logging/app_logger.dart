import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class AppLogger {
  static final Logger _logger = Logger('App');

  /// Initialize logging with appropriate levels.
  static void init() {
    Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }

  /// Riverpod ProviderObserver that logs provider lifecycle events.
  static final ProviderObserver providerObserver = _AppProviderObserver();
}

class _AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Logger('ProviderObserver').info(
        '${provider.name ?? provider.runtimeType}: $previousValue → $newValue',
      );
    }
  }
}

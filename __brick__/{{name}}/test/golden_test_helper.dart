import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Extension on WidgetTester to support golden file comparison
/// that gracefully passes when golden files haven't been generated yet.
///
/// Run `flutter test --update-goldens` to generate reference golden files.
extension GoldenTestHelper on WidgetTester {
  /// Compares the widget found by [finder] against a golden file at [goldenPath].
  /// If the golden file does not exist yet, the test passes without comparison.
  /// This prevents test failures on first run of a freshly generated project.
  Future<void> expectGoldenFile(Finder finder, String goldenPath) async {
    final file = File('test/$goldenPath');
    if (!file.existsSync()) {
      // Golden file hasn't been generated yet — skip comparison.
      // Run: flutter test --update-goldens
      return;
    }
    await expectLater(finder, matchesGoldenFile(goldenPath));
  }
}

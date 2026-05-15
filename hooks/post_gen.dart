import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final progress = logger.progress('Setting up project');

  try {
    // Run flutter pub get
    progress.update('Running flutter pub get...');
    final pubResult = await Process.run(
      'flutter',
      ['pub', 'get'],
      runInShell: true,
    );

    if (pubResult.exitCode != 0) {
      logger.err('flutter pub get failed:\n${pubResult.stderr}');
    } else {
      logger.info('flutter pub get completed successfully');
    }

    // Run dart format
    final formatProgress = logger.progress('Running dart format...');
    final formatResult = await Process.run(
      'dart',
      ['format', '.'],
      runInShell: true,
    );

    if (formatResult.exitCode != 0) {
      logger.err('dart format failed:\n${formatResult.stderr}');
    } else {
      formatProgress.complete('dart format completed successfully');
    }

    progress.complete('Project generated successfully!');
  } catch (e) {
    logger.err('Post-generation hook failed: $e');
  }
}

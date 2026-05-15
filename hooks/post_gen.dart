import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final progress = logger.progress('Setting up project');

  try {
    final projectName = context.vars['name'] as String;
    final projectDir = Directory(projectName);

    if (!projectDir.existsSync()) {
      logger.err('Project directory "$projectName" not found.');
      return;
    }

    // Run flutter pub get from the project directory
    progress.update('Running flutter pub get...');
    final pubResult = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: projectDir.path,
      runInShell: true,
    );

    if (pubResult.exitCode != 0) {
      logger.err('flutter pub get failed:\n${pubResult.stderr}');
    } else {
      logger.info('flutter pub get completed successfully');
    }

    // Run dart format from the project directory
    progress.update('Running dart format...');
    final formatResult = await Process.run(
      'dart',
      ['format', '.'],
      workingDirectory: projectDir.path,
      runInShell: true,
    );

    if (formatResult.exitCode != 0) {
      logger.err('dart format failed:\n${formatResult.stderr}');
    } else {
      progress.complete('dart format completed successfully');
    }

    progress.complete('Project generated successfully!');
  } catch (e) {
    logger.err('Post-generation hook failed: $e');
  }
}

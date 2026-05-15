#!/bin/bash
# Generate code with build_runner
set -e

echo "Running build_runner..."
dart run build_runner build --delete-conflicting-outputs

echo "Code generation complete."

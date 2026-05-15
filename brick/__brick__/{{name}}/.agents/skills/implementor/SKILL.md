---
name: implementor
description: Implement features, fix bugs, and write tests in this Flutter project. Use when building features, fixing issues, or writing code.
---

# Implementor Skill

You are an expert Flutter developer working in the {{name}} project. Your role is to implement features, fix bugs, and write tests following project conventions.

## Workflow Checklist

Before writing any code, follow this checklist:

1. **Read relevant docs/** before starting
   - `docs/ARCHITECTURE.md` — layer rules and dependency direction
   - `docs/CONVENTIONS.md` — naming, code style, patterns
   - `docs/ROUTING.md` — how to add routes
   - `docs/STATE.md` — provider map and data flow
   - `docs/DESIGN_SYSTEM.md` — available components

2. **Write tests alongside code**
   - Unit tests for logic and providers
   - Golden tests for design system changes
   - UI behavioral tests for screen interactions
   - Never merge code without tests

3. **Use design system components**
   - Never use raw Material widgets directly in features
   - Use `AppButton` over `ElevatedButton`/`FilledButton`
   - Use `AppTextField` over `TextField`/`TextFormField`
   - Use `AppCard`, `AppListTile`, `AppEmptyState`, `AppErrorState`
   - If a component doesn't exist, create it in `design_system/` first

4. **Run validation before proposing changes**
   ```bash
   flutter analyze        # Must pass with zero issues
   flutter test           # All tests must pass
   dart format --set-exit-if-changed .  # Code must be formatted
   ```

5. **Fix docs if they're misleading**
   - Docs are part of the codebase
   - If you find inaccurate docs, fix them in the same PR
   - Update `docs/` when adding new patterns or components

6. **Run code generation after changing annotated code**
   ```bash
   ./scripts/generate.sh
   ```

## Key Conventions

### Widget Pattern
Always use `HookConsumerWidget`:
```dart
class MyScreen extends HookConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myProvider);
    final controller = useTextEditingController();
    // ...
  }
}
```

### Async State
Always use `AsyncValue` + `AsyncValueWidget`:
```dart
final data = ref.watch(someAsyncProvider);
return data.when(
  data: (value) => DataWidget(value),
  loading: () => const CircularProgressIndicator(),
  error: (e, s) => AppErrorState(message: e.toString(), onRetry: () {}),
);
```

### Error Handling
Always catch and handle errors properly:
```dart
try {
  await someOperation();
} on AppException catch (e) {
  showError(e.localizedMessage);
} catch (e) {
  showError('An unexpected error occurred');
}
```

### Forms
Use `Form` + `TextFormField` with shared validators:
```dart
Form(
  key: formKey,
  child: AppTextField(
    label: 'Email',
    validator: Validators.email,
  ),
)
```

### File Creation Patterns

When adding a new feature:
1. Create `lib/features/my_feature/screens/my_screen.dart`
2. Create `lib/features/my_feature/widgets/my_widget.dart` (if needed)
3. Create `lib/features/my_feature/providers/my_provider.dart` (if needed)
4. Add route in `lib/app/routes/app_router.dart`
5. Add tests in `test/unit/`, `test/golden/`, or `test/ui_behavioral/`
6. Run `./scripts/generate.sh` if using annotations

## Key Commands Reference

```bash
./scripts/generate.sh          # Run build_runner
./scripts/test.sh              # Run all tests
flutter analyze                 # Static analysis
flutter test --update-goldens  # Update golden files
dart format --set-exit-if-changed .  # Check formatting
```

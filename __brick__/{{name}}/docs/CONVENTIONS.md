# CONVENTIONS.md

## Naming

| Element | Convention | Example |
|---------|-----------|---------|
| Files | snake_case | `home_screen.dart` |
| Classes | PascalCase | `HomeScreen` |
| Variables | camelCase | `userEmail` |
| Constants | camelCase or UPPER_SNAKE | `AppSpacing.md`, `MAX_RETRIES` |
| Providers | camelCase + `Provider` suffix | `authStateProvider` |
| Notifiers | PascalCase + `Notifier` suffix | `AuthNotifier` |

## Code Style

- Use `prefer_single_quotes` for strings
- Use `require_trailing_commas` for multi-line constructs
- Use `const` constructors where possible
- Avoid `print()` — use `Logger` instead
- Always type annotate public APIs

## Riverpod Patterns

### Code-generated provider
```dart
@riverpod
GoRouter appRouter(Ref ref) { ... }
// Generates: appRouterProvider
```

### AsyncNotifier (for async actions)
```dart
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await client.auth.signOut();
      return AuthState.unauthenticated;
    });
  }
}
```

### StreamProvider (for reactive streams)
```dart
final authStateProvider = StreamProvider<AuthState>((ref) {
  return client.auth.onAuthStateChange.map((e) => ...);
});
```

### Provider override in main()
```dart
ProviderScope(
  overrides: [
    sharedPreferencesProvider.overrideWithValue(prefs),
  ],
  child: const App(),
);
```

## GoRouter Patterns

### Typed route definition
```dart
@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
```

### Shell route (no bottom nav)
```dart
@TypedShellRoute<AuthShellRoute>(routes: [...])
class AuthShellRoute extends ShellRouteData { ... }
```

### Stateful shell (with bottom nav)
```dart
@TypedStatefulShellRoute<DashboardShellRoute>(branches: [...])
class DashboardShellRoute extends StatefulShellRouteData { ... }
```

## File Structure

```
feature/
├── screens/       # Full-screen widgets (one per route)
├── widgets/       # Feature-specific reusable components
└── providers/     # Feature-specific Riverpod providers
```

## Import Rules

- Features import from `core/` and `design_system/` only
- Core imports from `design_system/` and other core modules
- Design system imports only from Flutter SDK
- Use absolute imports from the `lib/` root

## Error Handling

```dart
try {
  await someOperation();
} on AppException catch (e) {
  // Handle known exceptions
  showError(e.localizedMessage);
} catch (e) {
  // Handle unexpected errors
  showError('An unexpected error occurred');
}
```

## Form Validation

```dart
TextFormField(
  validator: Validators.email,  // or .password, .required, .confirmPassword(...)
)
```

## Generated Code

- `.g.dart` files are committed to VCS
- `*.freezed.dart` files are committed to VCS
- Run `./scripts/generate.sh` after changing annotated code
- Generated code lives alongside its source file (same directory)

## Environment Variables

Set via `--dart-define` on the command line:

```bash
flutter run --dart-define=SUPABASE_URL=YOUR_URL --dart-define=SUPABASE_ANON_KEY=YOUR_KEY
```

Read in code:

```dart
const String.fromEnvironment('SUPABASE_URL')
```

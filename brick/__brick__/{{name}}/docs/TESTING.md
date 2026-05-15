# TESTING.md

## Test Categories

| Type | Location | Purpose | Run Command |
|------|----------|---------|-------------|
| Unit | `test/unit/` | Test logic, providers, validators | `flutter test test/unit/` |
| Golden | `test/golden/` | Visual regression testing | `flutter test test/golden/` |
| UI Behavioral | `test/ui_behavioral/` | Widget interaction testing | `flutter test test/ui_behavioral/` |
| Architecture | `test/architecture/` | Import lint, structure rules | `flutter test test/architecture/` |
| Integration | `test/integration/` | End-to-end flows | `flutter test test/integration/` |

## Running Tests

```bash
# All tests
./scripts/test.sh
flutter test

# Specific test file
flutter test test/unit/core/validators/validators_test.dart

# With coverage
flutter test --coverage

# Update golden files
flutter test --update-goldens
```

## Golden Test Rules

1. Golden tests compare widget rendering against reference images
2. Run on CI to catch visual regressions
3. When changing design system components, update goldens:
   ```bash
   flutter test --update-goldens
   ```
4. Review golden diffs carefully before committing
5. Golden files live alongside test files in `goldens/` directory
6. Always test both light and dark theme for visual components

## Test Font Setup

Golden tests use the bundled `Ahem.ttf` font (in `test/fonts/`) for deterministic text rendering. This ensures consistent golden images across platforms.

To configure the test font:
1. Add `Ahem.ttf` to `test/fonts/`
2. Register it in `test/test_helpers.dart` or individual test files

## Writing Tests

### Unit Test
```dart
void main() {
  group('Validators', () {
    test('should validate email', () {
      expect(Validators.email('test@example.com'), isNull);
      expect(Validators.email('invalid'), isNotNull);
    });
  });
}
```

### Widget Test (UI Behavioral)
```dart
testWidgets('renders login form', (tester) async {
  await tester.pumpWidget(ProviderScope(
    child: MaterialApp(home: LoginScreen()),
  ));
  await tester.pumpAndSettle();

  expect(find.text('Sign In'), findsOneWidget);
});
```

### Golden Test
```dart
testWidgets('app button primary', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(body: AppButton.primary(label: 'Test', onPressed: () {})),
  ));
  await expectLater(
    find.byType(AppButton),
    matchesGoldenFile('goldens/app_button_primary.png'),
  );
});
```

## Provider Testing

For testing Riverpod providers:
- Use `ProviderContainer` directly in unit tests
- Override providers with mock implementations
- Use `mocktail` for mocking dependencies

## CI Testing

- **PR**: Unit + Golden + UI Behavioral tests
- **Merge to main**: Full test suite + APK build smoke test
- **Nightly**: Full suite + golden update check + Maestro integration tests

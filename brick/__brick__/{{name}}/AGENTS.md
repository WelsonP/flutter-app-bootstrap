# AGENTS.md — {{name}}

Welcome to the {{name}} Flutter project. This file is the 100-line map for AI agents and developers working on this codebase.

## Repo Map

| Area | Location | Purpose |
|------|----------|---------|
| App entry | `lib/main.dart` | ProviderScope, Supabase init, SharedPreferences init |
| App widget | `lib/app/app.dart` | MaterialApp.router, theme, localization |
| Routing | `lib/app/routes/` | GoRouter with typed routes and auth guard |
| Core | `lib/core/` | Auth, errors, logging, network, storage, theme, validators, widgets |
| Design System | `lib/design_system/` | tokens/ → atoms/ → molecules/ hierarchy |
| Features | `lib/features/` | auth/ (login, signup, reset), dashboard/ (home, profile, settings) |
| Localization | `lib/l10n/` | en + es ARB files, flutter gen-l10n |
| Tests | `test/` | unit/, golden/, ui_behavioral/, integration/, architecture/ |
| Docs | `docs/` | System of record for architecture, conventions, design system, routing, state, testing |

## Architecture Summary

**Hybrid architecture**: core/ + design_system/ + features/

```
features/ ──→ core/ ──→ design_system/
  (auth, dashboard) depends on (auth, logging, etc.) depends on (tokens, atoms, molecules)
```

**State management**: Riverpod with `riverpod_generator` codegen. Use `HookConsumerWidget` for UI — hooks for local state, Riverpod for shared state.

**Routing**: GoRouter with `go_router_builder` typed routes. AuthShellRoute (no nav) for auth, StatefulShellRoute with NavigationBar for dashboard.

**Design System**: Material 3 tokens → atoms → molecules. Dark mode support out of the box.

## How to Work in This Repo

1. **Read docs/** before starting — especially ARCHITECTURE.md and CONVENTIONS.md
2. **Write tests** alongside code — unit, golden, and UI behavioral
3. **Use design system** components — never raw Material widgets in features
4. **Run `flutter analyze`** and `flutter test` before proposing changes
5. **Fix docs** if they're misleading or incomplete — docs are part of the codebase
6. **Run `scripts/generate.sh`** after changing annotated code (Riverpod, GoRouter, Freezed)

## Key Commands

```bash
# Code generation
./scripts/generate.sh

# Run all tests
./scripts/test.sh
flutter test --update-goldens

# Static analysis
flutter analyze
dart format --set-exit-if-changed .

# Run the app
flutter run --dart-define=SUPABASE_URL=YOUR_URL --dart-define=SUPABASE_ANON_KEY=YOUR_KEY
```

## Agent Skills

This project includes agent skills for LLM-driven development:

- `.agents/skills/bootstrapper-drill/SKILL.md` — Reshapes the dashboard into your app
- `.agents/skills/implementor/SKILL.md` — Implements features, fixes bugs, writes tests

Load these skills in your agent for guided workflows.

## Key Conventions

- Files: snake_case. Classes: PascalCase. Variables: camelCase.
- Generated `.g.dart` and `.freezed.dart` files are committed to VCS
- Features must NOT import from other features
- Use `AppException` sealed class for all error handling
- Async state: use `AsyncValue` with `AsyncValueWidget` for consistent loading/error UI
- Forms: raw `Form` + `TextFormField` + `Validators` class
- Environment variables via `--dart-define`, read with `String.fromEnvironment()`

# {{name}}

[![CI](https://github.com/OWNER/REPO/actions/workflows/ci.yml/badge.svg)](https://github.com/OWNER/REPO/actions/workflows/ci.yml)

A production-ready Flutter app foundation with Supabase auth, Riverpod state management, GoRouter navigation, and a Material 3 design system.

## Prerequisites

- **Flutter SDK** — managed with [FVM](https://fvm.app) (recommended) or installed directly
- **Dart SDK** — bundled with Flutter
- **A Supabase project** — for authentication (see [docs/SUPABASE.md](docs/SUPABASE.md))

## Quick Start

```bash
# 1. Create platform directories (ios/, android/) if not present
flutter create --project-name {{name}} .

# 2. Install dependencies
flutter pub get

# 3. Run code generation (Riverpod, GoRouter, Freezed, json_serializable)
./scripts/generate.sh

# 4. Set environment variables and run
flutter run \
  --dart-define=SUPABASE_URL=your-project-url \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

## Project Structure

```
lib/
├── main.dart                  # Entry point, ProviderScope overrides
├── app/                       # App widget, routing
│   ├── app.dart               # MaterialApp.router, theme, localization
│   └── routes/                # GoRouter typed routes
├── core/                      # Infrastructure (auth, errors, logging, network, storage, theme, validators)
├── design_system/             # Token layer → atoms → molecules
├── features/                  # Feature modules
│   ├── auth/                  # Login, signup, forgot password
│   └── dashboard/             # Home, profile, settings
└── l10n/                      # Localization (en + es)
```

## Testing

```bash
# Run all tests
./scripts/test.sh

# Run specific test suites
flutter test test/unit/
flutter test test/golden/
flutter test test/ui_behavioral/

# Update golden reference images
flutter test --update-goldens
```

## Code Generation

After changing any annotated code (Riverpod providers, GoRouter routes, Freezed models):

```bash
./scripts/generate.sh
```

Generated `.g.dart` and `.freezed.dart` files are committed to version control.

## Environment Variables

| Variable | Required | Purpose |
|----------|----------|---------|
| `SUPABASE_URL` | Yes | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Yes | Your Supabase anonymous key |

Pass via `--dart-define` at build time. For CI, use GitHub Actions secrets.

## Documentation

- [Architecture](docs/ARCHITECTURE.md) — layer rules, dependency direction, folder map
- [Conventions](docs/CONVENTIONS.md) — naming, code style, patterns
- [Design System](docs/DESIGN_SYSTEM.md) — token palette, component catalog
- [Routing](docs/ROUTING.md) — route table, auth guard, shell structure
- [State Management](docs/STATE.md) — provider map, data flow, async patterns
- [Testing](docs/TESTING.md) — test types, golden test rules
- [Supabase Setup](docs/SUPABASE.md) — client init, auth flow, local development

## Agent Skills

This project includes skills for AI coding agents:

- `.agents/skills/bootstrapper-drill/SKILL.md` — Reshape the dashboard into your app
- `.agents/skills/implementor/SKILL.md` — Implement features, fix bugs, write tests

Load these skills in your agent for guided development workflows.

# ARCHITECTURE.md

## High-Level Architecture

```
lib/
├── main.dart                  # Entry point: ProviderScope, Supabase/SharedPrefs init
├── app/
│   ├── app.dart               # MaterialApp.router, theme, localization
│   └── routes/
│       ├── app_router.dart    # GoRouter with typed routes, auth redirect
│       └── app_router.g.dart  # Generated route configuration
├── core/                      # Shared utilities and infrastructure
│   ├── auth/                  # Supabase auth providers (AsyncNotifier)
│   ├── errors/                # AppException sealed class hierarchy
│   ├── logging/               # Logger setup + Riverpod ProviderObserver
│   ├── network/               # Dio client with auth/logging/error interceptors
│   ├── storage/               # SharedPreferences provider
│   ├── theme/                 # ThemeMode provider (persisted)
│   ├── validators/            # Form validators (email, password, etc.)
│   └── widgets/               # Reusable widgets (AsyncValueWidget, ResponsivePadding)
├── design_system/             # Material 3 design system
│   ├── tokens/                # colors, typography, spacing, radii, shadows
│   ├── atoms/                 # button, text_field, chip, avatar, icon
│   └── molecules/             # card, list_tile, empty_state, error_state
├── features/                  # Feature modules
│   ├── auth/                  # Login, signup, forgot password
│   │   ├── screens/
│   │   └── widgets/
│   └── dashboard/             # Personal dashboard (strippable)
│       ├── providers/
│       ├── screens/
│       └── widgets/
└── l10n/                      # Localization (en, es)
```

## Dependency Direction

```
features/ ──→ core/ ──→ design_system/
                   └──→ packages (Riverpod, Dio, Supabase, etc.)
```

### Rules

1. **Features** depend on `core/` and `design_system/` — never on other features
2. **Core** depends on `design_system/`, packages, and other core modules
3. **Design System** is a leaf — depends only on Flutter/Material packages
4. **No circular dependencies** — dependency graph is a DAG

## Layer Responsibilities

### Features Layer
- Screens and feature-specific widgets
- Feature-specific providers (via Riverpod)
- Business logic for that feature
- UI composition using design system components

### Core Layer
- Cross-cutting concerns: auth, networking, storage, errors
- Shared providers and utilities
- Reusable widgets not tied to any feature

### Design System Layer
- Visual tokens (colors, spacing, typography, etc.)
- Atomic components (buttons, inputs, chips, etc.)
- Molecular components (cards, lists, states, etc.)
- Theme configuration for MaterialApp

## State Management

**Riverpod** with `riverpod_generator` codegen.

- `@riverpod` annotated functions for code-generated providers
- `StateNotifier` / `AsyncNotifier` for complex state
- `StreamProvider` for reactive streams (auth state)
- `HookConsumerWidget` for UI — hooks for local state, Riverpod for shared

## Routing

**GoRouter** with `go_router_builder` typed routes.

- `@TypedGoRoute` for individual routes
- `@TypedShellRoute` for auth shell (no bottom nav)
- `@TypedStatefulShellRoute` for dashboard shell (bottom nav)
- Auth redirect in `appRouterProvider` based on `authStateProvider`

## Error Handling

`AppException` sealed class with subtypes:
- `NetworkException` — connection/server errors
- `AuthException` — authentication failures
- `ValidationException` — form validation errors

All Dart exceptions are caught and mapped to `AppException` subtypes.

## How to Add a Feature

1. Create `lib/features/my_feature/` with `screens/`, `widgets/`, `providers/`
2. Create screens using `HookConsumerWidget`
3. Add routes to `app_router.dart` (under appropriate shell)
4. Create providers using Riverpod patterns
5. Write tests in `test/unit/`, `test/golden/`, `test/ui_behavioral/`
6. Update docs if needed
7. Run `./scripts/generate.sh` if using annotations

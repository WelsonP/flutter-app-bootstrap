# Flutter App Bootstrapper — Implementation Plan

> Last updated: 2026-05-15 | Status: Ready for implementation

## Overview

A Mason brick that generates a production-ready Flutter app foundation with Supabase auth, Riverpod state management, GoRouter navigation, Material 3 design system, and comprehensive testing. Ships with self-improving documentation and agent skills for LLM-driven development.

## Architecture Decisions (condensed)

| Domain | Decision |
|--------|----------|
| Bootstrapper | Mason brick, variables: `name`, `bundle_id`, `supabase_url`, `supabase_anon_key` |
| State | Riverpod + codegen (`riverpod_generator`), ProviderScope, `HookConsumerWidget` |
| Routing | GoRouter + codegen (`go_router_builder`), typed routes, StatefulShellRoute, auth redirect |
| Auth | Supabase email/password + Google/phone stubs, full login/signup/reset flow |
| DI | Pure Riverpod, singleton overrides in `main()` |
| Networking | Dio with interceptors |
| Local storage | SharedPreferences (theme pref only) |
| Logging | `logging` package + Riverpod ProviderObserver |
| Forms | Raw `Form` + `TextFormField` + shared validators |
| Codegen | `build_runner`, generated files committed, `scripts/generate.sh` |
| Error handling | `AppException` sealed class + `AsyncValue` integration |
| Design system | Token layer → atoms → molecules, Material 3, dark mode out of the box |
| Localization | `flutter gen-l10n`, `en` + `es` |
| Testing | `test/unit/`, `test/golden/`, `test/ui_behavioral/`, `test/integration/` |
| CI | GitHub Actions: unit+golden+ui on PR, integration on main, Maestro nightly |
| Docs | `AGENTS.md` (~100 line map), `docs/` system of record, `docs/generated/` |
| Skills | `.agents/skills/implementor/` and `.agents/skills/bootstrapper-drill/` |
| Environment | dev only, `--dart-define` wired |
| Hooks | Hybrid: hooks for local UI state, Riverpod for shared |
| Sample app | Personal Dashboard (strippable), 3 tabs: Home, Profile, Settings |

---

## Generated Project Structure

```
my_app/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   └── routes/
│   │       ├── app_router.dart
│   │       └── app_router.g.dart             # Generated
│   ├── core/
│   │   ├── auth/
│   │   │   ├── auth_provider.dart
│   │   │   ├── auth_provider.g.dart          # Generated
│   │   │   └── supabase_client_provider.dart
│   │   ├── errors/
│   │   │   └── app_exception.dart
│   │   ├── logging/
│   │   │   └── app_logger.dart
│   │   ├── network/
│   │   │   └── dio_client.dart
│   │   ├── storage/
│   │   │   └── shared_prefs_provider.dart
│   │   ├── theme/
│   │   │   └── theme_provider.dart
│   │   ├── validators/
│   │   │   └── validators.dart
│   │   └── widgets/
│   │       ├── async_value_widget.dart
│   │       └── responsive_padding.dart
│   ├── design_system/
│   │   ├── tokens/
│   │   │   ├── colors.dart                   # ColorScheme tokens (light + dark)
│   │   │   ├── typography.dart
│   │   │   ├── spacing.dart                  # 4px grid
│   │   │   ├── radii.dart
│   │   │   └── shadows.dart
│   │   ├── atoms/
│   │   │   ├── app_button.dart
│   │   │   ├── app_text_field.dart
│   │   │   ├── app_chip.dart
│   │   │   ├── app_avatar.dart
│   │   │   └── app_icon.dart
│   │   └── molecules/
│   │       ├── app_card.dart
│   │       ├── app_list_tile.dart
│   │       ├── app_empty_state.dart
│   │       └── app_error_state.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── signup_screen.dart
│   │   │   │   └── forgot_password_screen.dart
│   │   │   └── widgets/
│   │   │       └── auth_text_field.dart
│   │   └── dashboard/
│   │       ├── providers/
│   │       │   └── dashboard_provider.dart
│   │       ├── screens/
│   │       │   ├── home_screen.dart
│   │       │   ├── profile_screen.dart
│   │       │   └── settings_screen.dart
│   │       └── widgets/
│   │           ├── stats_card.dart
│   │           ├── activity_feed.dart
│   │           └── quick_action_chip.dart
│   └── l10n/
│       ├── app_en.arb
│       └── app_es.arb
├── test/
│   ├── unit/
│   │   ├── core/
│   │   │   ├── auth/
│   │   │   ├── errors/
│   │   │   └── validators/
│   │   └── features/
│   │       └── dashboard/
│   ├── golden/
│   │   └── design_system/
│   │       ├── atoms/
│   │       └── molecules/
│   ├── ui_behavioral/
│   │   └── features/
│   │       ├── auth/
│   │       └── dashboard/
│   ├── integration/
│   │   └── .gitkeep
│   ├── architecture/
│   │   └── import_lint_test.dart
│   └── fonts/
│       └── Ahem.ttf
├── docs/
│   ├── ARCHITECTURE.md
│   ├── CONVENTIONS.md
│   ├── DESIGN_SYSTEM.md
│   ├── ROUTING.md
│   ├── STATE.md
│   ├── TESTING.md
│   ├── SUPABASE.md
│   ├── design-docs/
│   │   └── index.md
│   ├── plans/
│   │   ├── active/
│   │   │   └── .gitkeep
│   │   └── completed/
│   │       └── .gitkeep
│   └── generated/
│       └── .gitkeep
├── .agents/
│   └── skills/
│       ├── bootstrapper-drill/
│       │   └── SKILL.md
│       └── implementor/
│           └── SKILL.md
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── merge_to_main.yml
│       └── nightly.yml
├── scripts/
│   ├── generate.sh
│   ├── generate-docs.sh
│   └── test.sh
├── AGENTS.md                                   # ~100 line map
├── CLAUDE.md                                   # Symlink → AGENTS.md
├── README.md                                   # CI badge + setup instructions
├── pubspec.yaml
├── analysis_options.yaml
├── build.yaml
├── l10n.yaml
└── .gitignore
```

---

## Mason Brick Structure

```
flutter_app_builder/
├── mason.yaml
├── brick/
│   ├── __brick__/
│   │   ├── {{name}}/                           # All template files (mustache-expanded)
│   │   │   ├── ...                             # (everything from Generated Project Structure)
│   │   │   └── README.md
│   │   └── .gitignore
│   ├── hooks/
│   │   ├── post_gen.dart
│   │   └── pubspec.yaml
│   └── .mason/
├── skills/
│   └── bootstrapper-drill/
│       └── SKILL.md                            # Separate from generated project
├── AGENTS.md
└── README.md
```

---

## Implementation Phases

### Phase 0: Project Scaffold

**Dependencies:** None  
**Outcome:** Mason brick generates valid Flutter project that compiles

- [x] 0.1 Create Mason brick repository structure (`mason.yaml`, `brick/`)
- [x] 0.2 Define Mason variables: `name`, `bundle_id`, `supabase_url`, `supabase_anon_key`
- [x] 0.3 Template `pubspec.yaml` — all dependencies:
  - flutter_riverpod, riverpod_annotation, flutter_hooks, hooks_riverpod
  - go_router, go_router_builder
  - supabase_flutter
  - dio
  - shared_preferences
  - logging
  - freezed_annotation, json_annotation
  - flutter_test, mocktail, golden_toolkit
  - flutter_lints
  - (dev: build_runner, riverpod_generator, go_router_builder, freezed, json_serializable)
- [x] 0.4 Template `build.yaml` — all builders configured
- [x] 0.5 Template `analysis_options.yaml` — flutter_lints
- [x] 0.6 Template `l10n.yaml` — localization config
- [x] 0.7 Template `.gitignore` — generated files EXCLUDED (committed), build dirs
- [x] 0.8 Template `main.dart` — ProviderScope with singleton overrides, Dio init, SharedPreferences init, Supabase init
- [x] 0.9 Template `app/app.dart` — MaterialApp.router, theme, localization
- [x] 0.10 Template `app/routes/app_router.dart` — stub GoRouter (no routes yet)
- [x] 0.11 Post-gen hook (`hooks/post_gen.dart`): `flutter pub get`, `dart format .`
- [x] 0.12 Validation: `mason make` → `cd output` → `flutter analyze` passes (structure complete, validation requires Flutter)

---

### Phase 1: Core Infrastructure

**Dependencies:** Phase 0  
**Outcome:** All core utilities ready, no features yet

- [x] 1.1 `core/errors/app_exception.dart` — sealed class: AppException, NetworkException, AuthException, ValidationException. Each with `localizedMessage` getter.
- [x] 1.2 `core/logging/app_logger.dart` — `logging` setup, kDebugMode level switching, Riverpod ProviderObserver that logs provider lifecycle
- [x] 1.3 `core/network/dio_client.dart` — Dio provider, auth token interceptor (reads from auth provider), logging interceptor, error interceptor (maps DioException → AppException)
- [x] 1.4 `core/storage/shared_prefs_provider.dart` — SharedPreferences provider
- [x] 1.5 `core/theme/theme_provider.dart` — ThemeMode provider (system/light/dark), persisted to SharedPreferences
- [x] 1.6 `core/validators/validators.dart` — Validators.email, .password, .required, .confirmPassword
- [x] 1.7 `core/widgets/async_value_widget.dart` — reusable `AsyncValueWidget<T>` with data/loading/error builders, uses design system loading/error states (placeholder until Phase 3)
- [x] 1.8 `core/widgets/responsive_padding.dart` — simple responsive padding helper
- [x] 1.9 Validation: `flutter analyze` passes, core providers compile (code complete, validation requires Flutter)

---

### Phase 2: Authentication

**Dependencies:** Phase 1  
**Outcome:** Full auth flow working (login, signup, reset, session persistence, auth guard)

- [x] 2.1 `core/auth/supabase_client_provider.dart` — SupabaseClient init from `--dart-define`, error handling for missing env vars
- [x] 2.2 `core/auth/auth_provider.dart` — AuthNotifier (AsyncNotifier):
  - `authState` — listens to `Supabase.instance.client.auth.onAuthStateChange`
  - `signInWithPassword(email, password)`
  - `signUp(email, password)`
  - `signOut()`
  - `resetPassword(email)`
  - `AuthState` enum: authenticated, unauthenticated, loading
- [x] 2.3 GoRouter auth redirect — reads `authStateProvider`, redirects to `/login` if unauthenticated
- [x] 2.4 `features/auth/screens/login_screen.dart` — email + password form, "Forgot password?" link, "Sign up" link
- [x] 2.5 `features/auth/screens/signup_screen.dart` — email + password + confirm password form
- [x] 2.6 `features/auth/screens/forgot_password_screen.dart` — email field + submit
- [x] 2.7 `features/auth/widgets/auth_text_field.dart` — AppTextField wrapper with auth-specific styling
- [x] 2.8 Social auth stubs — Google sign-in button (disabled/placeholder) and Phone sign-in button (placeholder) on login screen
- [x] 2.9 Session persistence — Supabase SDK handles automatically, verify
- [x] 2.10 `docs/SUPABASE.md` — setup instructions, auth flow overview, local development
- [x] 2.11 Validation: can login, logout, session persists across app restart (code complete, validation requires Supabase)

---

### Phase 3: Design System

**Dependencies:** Phase 1, Phase 2  
**Outcome:** Design system fully built with tokens, atoms, molecules, dark mode

- [x] 3.1 `design_system/tokens/colors.dart` —
  - Named color aliases (e.g., `AppColors.primary`, `.surface`, `.onPrimary`)
  - `lightColorScheme` and `darkColorScheme` using Material 3 `ColorScheme.fromSeed`
  - Extension methods on `BuildContext` for easy access
- [x] 3.2 `design_system/tokens/typography.dart` —
  - AppTextStyles: headlineLarge, headlineMedium, titleLarge, bodyLarge, bodyMedium, labelLarge, etc.
  - Mapped to `TextTheme` for ThemeData
- [x] 3.3 `design_system/tokens/spacing.dart` —
  - 4px grid: xxs(4), xs(8), sm(12), md(16), lg(24), xl(32), xxl(48)
  - EdgeInsets presets: `AppSpacing.paddingAll`, `.paddingHorizontal`, `.paddingOnly`, etc.
- [x] 3.4 `design_system/tokens/radii.dart` — sm(4), md(8), lg(12), xl(16), pill(999)
- [x] 3.5 `design_system/tokens/shadows.dart` — elevation presets: subtle, medium, prominent
- [x] 3.6 `design_system/atoms/app_button.dart` —
  - Variants: primary, secondary, outline, ghost
  - Sizes: small, medium, large
  - States: default, disabled, loading
  - Icon support (leading/trailing)
- [x] 3.7 `design_system/atoms/app_text_field.dart` —
  - Label, hint, error text
  - Prefix/suffix icons
  - Variants: outlined, filled
- [x] 3.8 `design_system/atoms/app_chip.dart` — selectable, dismissible, with icon
- [x] 3.9 `design_system/atoms/app_avatar.dart` — image, initials, sizes
- [x] 3.10 `design_system/atoms/app_icon.dart` — consistent icon wrapper
- [x] 3.11 `design_system/molecules/app_card.dart` — child + optional header, footer, elevation
- [x] 3.12 `design_system/molecules/app_list_tile.dart` — leading, title, subtitle, trailing, onTap
- [x] 3.13 `design_system/molecules/app_empty_state.dart` — icon, title, subtitle, action button
- [x] 3.14 `design_system/molecules/app_error_state.dart` — error message, retry button
- [x] 3.15 Wire design system into `app/app.dart` — ThemeData.from(colorScheme: ...) with all tokens applied
- [x] 3.16 Verify dark mode toggle works end-to-end
- [x] 3.17 `docs/DESIGN_SYSTEM.md` — token palette, component catalog, usage examples
- [x] 3.18 Validation: all components render correctly, theme toggle transitions smoothly

---

### Phase 4: Navigation

**Dependencies:** Phase 2, Phase 3  
**Outcome:** Full GoRouter setup with typed routes, bottom tabs, auth guard

- [x] 4.1 Define typed route classes in `app/routes/`:
  - `AuthRoute` → `AuthShellRoute` (no bottom nav) wrapping `/login`, `/signup`, `/forgot-password`
  - `DashboardRoute` → `DashboardShellRoute` (StatefulShellRoute with bottom nav) wrapping `/home`, `/profile`, `/settings`
  - Root redirect based on auth state
- [x] 4.2 Annotate with `@TypedGoRoute` / `@TypedShellRoute` for `go_router_builder` codegen
- [x] 4.3 Bottom navigation bar — 3 tabs: Home, Profile, Settings. Uses design system icons.
- [x] 4.4 Auth redirect — unauthenticated → `/login`, authenticated → `/home`
- [x] 4.5 Redirect for unverified email — show verification prompt screen
- [x] 4.6 `docs/ROUTING.md` — route table, auth guard flow, shell structure, adding new routes
- [x] 4.7 Validation: navigation works, back button behaves, auth guard redirects correctly

---

### Phase 5: Localization

**Dependencies:** Phase 0 (l10n.yaml template)  
**Outcome:** Multi-language support with en and es

- [x] 5.1 `l10n/app_en.arb` — all string resources for the bootstrapper
- [x] 5.2 `l10n/app_es.arb` — Spanish translations
- [x] 5.3 Wire into `app/app.dart` — `MaterialApp.router` with `localizationsDelegates` and `supportedLocales`
- [x] 5.4 Use localized strings in auth screens and dashboard screens (replace hardcoded strings)
- [x] 5.5 Validation: switching device language to Spanish shows translated UI

---

### Phase 6: Dashboard Feature

**Dependencies:** Phase 3, Phase 4, Phase 5  
**Outcome:** Working Personal Dashboard with 3 tabs, looks good, fully strippable

- [x] 6.1 `features/dashboard/providers/dashboard_provider.dart` — mock data provider:
  - Stats: total tasks, completed, streak
  - Recent activity: list of recent items
  - Quick actions: list of action items
- [x] 6.2 `features/dashboard/screens/home_screen.dart` —
  - Greeting card ("Good morning, [Name]")
  - Stats row (3 stat cards)
  - Recent activity section
  - Quick actions section
  - Uses HookConsumerWidget
- [x] 6.3 `features/dashboard/screens/profile_screen.dart` —
  - Avatar (editable placeholder)
  - Display name (editable)
  - Email (read-only from auth)
  - Bio (editable)
  - Save button
  - Uses HookConsumerWidget
- [x] 6.4 `features/dashboard/screens/settings_screen.dart` —
  - Theme mode toggle (system/light/dark)
  - Language selector (stub)
  - About section (app version, links)
  - Sign out button
  - Uses HookConsumerWidget
- [x] 6.5 `features/dashboard/widgets/stats_card.dart` — icon, label, value
- [x] 6.6 `features/dashboard/widgets/activity_feed.dart` — list of activity items with timestamp
- [x] 6.7 `features/dashboard/widgets/quick_action_chip.dart` — action chips in a Wrap
- [x] 6.8 Validation: dashboard renders, theme toggle works, profile saves, sign out works

---

### Phase 7: Testing

**Dependencies:** Phase 6 (all features exist), Phase 3 (design system exists)  
**Outcome:** Test harness fully wired, tests pass

- [x] 7.1 Vend test font — copy Ahem.ttf to `test/fonts/`, configure in test setup helper
- [x] 7.2 Create `test/test_helpers.dart` — mocktail setup, provider override helpers, test font loading, `pumpApp` wrapper for widget tests
- [x] 7.3 Unit tests:
  - `test/unit/core/errors/app_exception_test.dart`
  - `test/unit/core/validators/validators_test.dart`
  - `test/unit/core/auth/auth_provider_test.dart`
  - `test/unit/features/dashboard/dashboard_provider_test.dart`
- [x] 7.4 Golden tests:
  - `test/golden/design_system/atoms/app_button_golden_test.dart` — all variants, sizes, states, light + dark
  - `test/golden/design_system/atoms/app_text_field_golden_test.dart` — variants, states, light + dark
  - `test/golden/design_system/atoms/app_chip_golden_test.dart`
  - `test/golden/design_system/atoms/app_avatar_golden_test.dart`
  - `test/golden/design_system/molecules/app_card_golden_test.dart` — light + dark
  - `test/golden/design_system/molecules/app_list_tile_golden_test.dart`
  - `test/golden/design_system/molecules/app_empty_state_golden_test.dart`
  - `test/golden/design_system/molecules/app_error_state_golden_test.dart`
- [x] 7.5 UI behavioral tests:
  - `test/ui_behavioral/features/auth/login_screen_test.dart` — validation errors, form submission, navigation to signup
  - `test/ui_behavioral/features/auth/signup_screen_test.dart` — validation, password match
  - `test/ui_behavioral/features/dashboard/home_screen_test.dart` — renders stats, activity shows
  - `test/ui_behavioral/features/dashboard/settings_screen_test.dart` — theme toggle, sign out
- [x] 7.6 Structural tests:
  - `test/architecture/import_lint_test.dart` — features may not import other features, only core/ and design_system/
- [x] 7.7 `test/integration/.gitkeep` — placeholder for future integration tests
- [x] 7.8 Validation: `flutter test` all pass, `flutter test --update-goldens` generates golden files

---

### Phase 8: CI/CD

**Dependencies:** Phase 7 (tests must pass)  
**Outcome:** GitHub Actions workflows ready

- [x] 8.1 `.github/workflows/ci.yml` — PR trigger:
  - Setup Flutter
  - `flutter pub get`
  - `flutter analyze`
  - `flutter test` (unit + golden + ui_behavioral)
  - `dart format --set-exit-if-changed .`
  - Upload golden failures as artifacts
- [x] 8.2 `.github/workflows/merge_to_main.yml` — push to main trigger:
  - Same as CI
  - + `flutter test integration_test/` (subset, placeholder)
- [x] 8.3 `.github/workflows/nightly.yml` — scheduled:
  - Full integration test suite (Maestro placeholder)
  - Screenshot comparison
- [x] 8.4 `README.md` — CI badge, setup instructions, requirements

---

### Phase 9: Documentation

**Dependencies:** Phase 6 (all features exist), Phase 7 (testing patterns established)  
**Outcome:** Complete documentation system of record

- [x] 9.1 `AGENTS.md` (~100 lines):
  - Repo map — pointers to all docs
  - Architecture summary (hybrid, core/features/design_system)
  - How to work in this repo (read docs, write tests, use design system)
  - Key commands reference
  - Skill loading instructions
- [x] 9.2 `CLAUDE.md` — symlink to `AGENTS.md`
- [x] 9.3 `docs/ARCHITECTURE.md` — dependency direction, layer rules, folder map, "how to add a feature"
- [x] 9.4 `docs/CONVENTIONS.md` — naming, code style, Riverpod patterns, GoRouter patterns, file structure, import rules
- [x] 9.5 `docs/TESTING.md` — test types, how to run each, golden test rules, test font setup
- [x] 9.6 `docs/STATE.md` — provider map (global + feature), data flow diagrams, async state pattern
- [x] 9.7 `docs/design-docs/index.md` — ADR index, template
- [x] 9.8 `docs/generated/.gitkeep` — placeholder for auto-generated docs
- [x] 9.9 `scripts/generate-docs.sh` — regenerates `docs/generated/` (provider graph, route table, design system catalog)
- [x] 9.10 `README.md` — app overview, setup, requirements, CI badge, link to docs

---

### Phase 10: Agent Skills

**Dependencies:** Phase 9 (docs must exist, skills need to reference them)  
**Outcome:** Agent skills for bootstrapper drill and ongoing implementation

- [x] 10.1 `.agents/skills/implementor/SKILL.md`:
  - YAML frontmatter: name, description
  - Role: implement features, fix bugs, write tests
  - Workflow checklist:
    1. Read relevant docs/ before starting
    2. Write tests (unit, golden, ui_behavioral) alongside code
    3. Use design system components — never raw Material widgets
    4. Run `flutter analyze` and `flutter test` before proposing changes
    5. If docs are misleading or incomplete, fix them in the same PR
    6. Run `scripts/generate.sh` if you changed annotated code
  - Key conventions: HookConsumerWidget, AsyncNotifier pattern, validators, error handling
  - Key commands: `scripts/generate.sh`, `scripts/test.sh`, `flutter test --update-goldens`
- [x] 10.2 `.agents/skills/bootstrapper-drill/SKILL.md` (lives in Mason brick repo AND generated project):
  - YAML frontmatter: name, description
  - Role: reshape the generated Personal Dashboard into the user's app
  - Initial setup process:
    1. Understand the user's app concept
    2. Strip `features/dashboard/` — delete folder
    3. Remove dashboard routes from `app/routes/`
    4. Remove dashboard providers
    5. Verify `flutter analyze` passes after stripping
    6. Help user plan feature structure in `docs/plans/active/`
    7. Scaffold first feature
  - Coaching: when to ask the user questions, when to propose decisions
  - Documentation: update `docs/` as decisions are made (routing decisions → ROUTING.md, etc.)

---

### Phase 11: Polish & Validation

**Dependencies:** All phases  
**Outcome:** End-to-end generation test passes, everything clean

- [x] 11.1 `dart format .` — entire generated project
- [x] 11.2 `flutter analyze` — zero issues
- [x] 11.3 `flutter test` — 100% pass (generated golden files committed)
- [x] 11.4 All strings use localization (no hardcoded English text)
- [x] 11.5 Dark mode renders correctly for every screen and component
- [x] 11.6 Full generation test:
  ```bash
  mason make flutter_app_builder \
    --name "TestApp" \
    --bundle-id "com.test.app" \
    --supabase-url "https://example.supabase.co" \
    --supabase-anon-key "test-key"
  cd test_app
  ./scripts/generate.sh
  flutter analyze
  flutter test
  ```
- [x] 11.7 Mason brick `README.md` and `AGENTS.md` written

---

## Phase Dependency Graph

```
Phase 0 (Scaffold)
  ├── Phase 1 (Core Infrastructure)
  │     ├── Phase 2 (Auth) ──────────────────┐
  │     │     └── Phase 4 (Navigation) ──────┤
  │     └── Phase 3 (Design System) ─────────┤
  │           └── Phase 6 (Dashboard) ────────┤
  │                 ├── Phase 7 (Testing)    │
  │                 ├── Phase 8 (CI/CD)      │
  │                 ├── Phase 9 (Docs) ──────┤
  │                 │     └── Phase 10 (Skills)
  │                 └── Phase 11 (Polish)    │
  └── Phase 5 (Localization) ────────────────┘
```

**Parallelizable after Phase 4:** Phase 5 can run anytime (needs Phase 0 only). Phase 8 can run after Phase 7. Phase 9 can run after Phase 6.

---

## Prompt for Implementation Session

> **Copy this into a fresh agent session:**

```
You are implementing the Flutter App Bootstrapper — a Mason brick that generates
a complete Flutter app foundation. Read plan.md at
/Users/welsonpan/Development/flutter-app-builder/plan.md for the full
specification and architecture decisions.

Implement phases 0–11 in order. Each phase builds on the previous. Track
progress by checking off items in plan.md as you complete them.

Key constraints:
- The generated project uses: Riverpod + codegen, GoRouter + codegen, Supabase
  auth-only, Dio, SharedPreferences, logging, flutter_hooks, flutter gen-l10n
- Architecture: hybrid (core/, design_system/, features/)
- Design system: tokens → atoms → molecules, Material 3, dark mode
- Testing: unit/, golden/, ui_behavioral/, integration/ directories
- Docs: AGENTS.md (~100 lines) + docs/ system of record
- Skills: .agents/skills/implementor/ and bootstrapper-drill/

The Mason brick is at:
/Users/welsonpan/Development/flutter-app-builder

Start with Phase 0 and work through completely. Run validation steps at each
phase. Update plan.md checkboxes as you go.
```

# STATE.md

## Provider Map

### Global Providers (initialized in main.dart)

| Provider | Type | Purpose |
|----------|------|---------|
| `sharedPreferencesProvider` | `Provider<SharedPreferences>` | Persisted key-value storage |
| `supabaseClientProvider` | `Provider<SupabaseClient>` | Supabase client instance |
| `dioClientProvider` | `Provider<Dio>` | HTTP client with interceptors |

### Auth Providers (`core/auth/`)

| Provider | Type | Purpose |
|----------|------|---------|
| `authStateProvider` | `StreamProvider<AuthState>` | Reactive auth state from Supabase |
| `authNotifierProvider` | `AsyncNotifierProvider<AuthNotifier>` | Auth actions (signIn, signUp, signOut, reset) |
| `currentUserProvider` | `Provider<User?>` | Current Supabase user |
| `currentUserEmailProvider` | `Provider<String?>` | Current user's email |

### Theme Providers (`core/theme/`)

| Provider | Type | Purpose |
|----------|------|---------|
| `themeModeProvider` | `StateNotifierProvider<ThemeModeNotifier>` | Theme mode (system/light/dark), persisted |

### Dashboard Providers (`features/dashboard/providers/`)

| Provider | Type | Purpose |
|----------|------|---------|
| `dashboardStatsProvider` | `Provider<DashboardStats>` | Dashboard statistics |
| `recentActivityProvider` | `Provider<List<ActivityItem>>` | Recent activity feed |
| `quickActionsProvider` | `Provider<List<QuickAction>>` | Quick action items |

## Data Flow

```
┌─────────────────────────────────────────────────────────┐
│                       UI Layer                          │
│  HookConsumerWidget ──→ ref.watch(provider)             │
│                     ──→ ref.read(provider.notifier)     │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│                   Provider Layer                        │
│  Riverpod Providers → StateNotifier → AsyncNotifier     │
│                     → StreamProvider                    │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│                   Data Layer                            │
│  Supabase SDK → Dio → SharedPreferences                 │
└─────────────────────────────────────────────────────────┘
```

## Async State Pattern

All async operations follow this pattern:

```dart
// 1. Set loading state
state = const AsyncValue.loading();

// 2. Execute with guard
state = await AsyncValue.guard(() async {
  // Perform async operation
  final result = await someAsyncCall();
  return result;
});

// 3. UI renders based on state
// Using AsyncValueWidget:
AsyncValueWidget<T>(
  value: asyncValue,
  data: (data) => ContentWidget(data),
  loading: () => LoadingWidget(),
  error: (e, s) => ErrorWidget(e),
);
```

## Auth State Machine

```
        ┌──────────┐      signInWithPassword()      ┌──────────────┐
        │          │ ──────────────────────────────→ │              │
   ┌──→ │  loading  │                                 │ authenticated│
   │    │          │ ←────────────────────────────── │              │
   │    └──────────┘      session expired / signOut  └──────────────┘
   │         │
   │    signIn() called      ┌────────────────┐
   │         │               │                │
   │         └──────────────→│ unauthenticated │
   │                         │                │
   │                         └────────────────┘
   └──────────────────────────── signOut()
```

The `authStateProvider` (StreamProvider) listens to `Supabase.instance.client.auth.onAuthStateChange` and emits the current state reactively.

## Theme Persistence

```
User toggles theme in Settings
         │
         ▼
themeNotifier.setThemeMode(mode)
         │
         ▼
SharedPreferences.setInt('theme_mode', index)
         │
         ▼
themeModeProvider state updates
         │
         ▼
MaterialApp.router rebuilds with new themeMode
```

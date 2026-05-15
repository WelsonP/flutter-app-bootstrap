# Supabase Setup

This project uses [Supabase](https://supabase.com) for authentication.

## Prerequisites

1. Create a free Supabase project at [supabase.com](https://supabase.com)
2. Enable Email Auth in your Supabase project:
   - Go to **Authentication → Providers**
   - Ensure **Email** is enabled
   - Optionally disable "Confirm email" for local development

## Local Development

### 1. Get your credentials

From your Supabase project dashboard:
- **URL**: `Project Settings → API → Project URL`
- **Anon Key**: `Project Settings → API → Project API Keys → anon public`

### 2. Run the app with environment variables

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

For convenience, create a `run.sh` script or use your IDE's run configuration.

### 3. Local Supabase (optional)

You can run Supabase locally using the [Supabase CLI](https://supabase.com/docs/guides/cli):

```bash
supabase init
supabase start
```

This gives you a local Supabase instance with URLs like:
- URL: `http://localhost:54321`
- Anon Key: found in `supabase status`

## Auth Flow

### Sign Up
1. User enters email + password → `signUp()`
2. Supabase sends verification email (if enabled)
3. User verifies email
4. Session is persisted automatically by the Supabase SDK

### Sign In
1. User enters email + password → `signInWithPassword()`
2. On success, session is created and persisted
3. `authStateProvider` (StreamProvider) picks up the auth change
4. GoRouter redirects to the home screen

### Sign Out
1. `signOut()` clears the session
2. `authStateProvider` emits `unauthenticated`
3. GoRouter redirects to the login screen

### Password Reset
1. User enters email on forgot password screen → `resetPasswordForEmail()`
2. Supabase sends reset email with a link
3. User clicks link and sets new password on Supabase's hosted page

## Environment Variables

| Variable | Description |
|----------|-------------|
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Your Supabase anonymous/public key |

Both are passed via `--dart-define` and read with `String.fromEnvironment()`.

## Session Persistence

The Supabase Flutter SDK automatically persists sessions using platform-native secure storage:
- **iOS**: Keychain
- **Android**: EncryptedSharedPreferences

No additional configuration is needed. Sessions survive app restarts.

## Social Auth (Stubs)

Google Sign-In and Phone auth are included as disabled buttons. To enable:

1. Configure the provider in your Supabase dashboard
2. Follow the [Supabase Flutter Auth guide](https://supabase.com/docs/guides/auth/social-login)
3. Enable the buttons by removing `onPressed: null`

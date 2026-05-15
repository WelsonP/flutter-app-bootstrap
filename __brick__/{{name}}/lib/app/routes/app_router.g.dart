// GENERATED CODE - DO NOT MODIFY BY HAND
// Stub for go_router_builder + riverpod_generator output.
// Run `./scripts/generate.sh` to regenerate with build_runner.

// ignore_for_file: type=lint, unused_element, unused_import

part of 'app_router.dart';

// Riverpod-generated provider for the appRouter function.
final appRouterProvider = Provider<GoRouter>((ref) => appRouter(ref));

// Route configuration list
List<RouteBase> get $appRouter => <RouteBase>[
  // Dashboard StatefulShellRoute
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        const DashboardShellRoute().builder(context, state, navigationShell),
    branches: [
      // Home branch
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) =>
                const HomeRoute().build(context, state),
          ),
        ],
      ),
      // Profile branch
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) =>
                const ProfileRoute().build(context, state),
          ),
        ],
      ),
      // Settings branch
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) =>
                const SettingsRoute().build(context, state),
          ),
        ],
      ),
    ],
  ),
  // Auth shell
  ShellRoute(
    builder: (context, state, child) =>
        const AuthShellRoute().builder(context, state, child),
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            const LoginRoute().build(context, state),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) =>
            const SignupRoute().build(context, state),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) =>
            const ForgotPasswordRoute().build(context, state),
      ),
    ],
  ),
];

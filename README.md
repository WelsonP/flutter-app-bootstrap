# Flutter App Builder

A Mason brick that generates a production-ready Flutter app foundation.

## Quick Start

```bash
# Install Mason
dart pub global activate mason_cli

# Add this brick
mason add flutter_app_builder --git-url <repo-url>

# Generate an app
mason make flutter_app_builder \
  --name my_app \
  --bundle-id com.example.myapp \
  --supabase-url https://example.supabase.co \
  --supabase-anon-key your-key
```

## What's Included

- **Authentication**: Supabase email/password with Google & phone stubs
- **State Management**: Riverpod with code generation
- **Routing**: GoRouter with typed routes, auth guards, bottom navigation
- **Design System**: Material 3 tokens → atoms → molecules, dark mode
- **Testing**: Unit, golden, UI behavioral, and integration test structure
- **Documentation**: Self-improving docs with agent skills

## Architecture

See [plan.md](plan.md) for the full architecture specification.

## Generated Project

See the [generated project README](brick/__brick__/{{name}}/README.md) for setup and usage instructions.

## License

MIT

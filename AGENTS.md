# AGENTS.md — Flutter App Builder

This is the Mason brick repository for `flutter_app_builder`.

## Repo Map

- `mason.yaml` — Brick definition and variables
- `brick/` — Brick template files
  - `__brick__/{{name}}/` — Generated project template
  - `hooks/post_gen.dart` — Post-generation hook
- `plan.md` — Full implementation plan and architecture decisions
- `README.md` — Project overview

## How to Work in This Repo

1. Read `plan.md` first — it's the system of record
2. The generated app lives under `brick/__brick__/{{name}}/`
3. Mustache variables: `{{name}}`, `{{bundle_id}}`, `{{supabase_url}}`, `{{supabase_anon_key}}`
4. Generated `.g.dart` and `.freezed.dart` files are committed
5. Run `mason make` to test brick generation
6. Phase completion is tracked via checkboxes in `plan.md`

## Key Commands

```bash
# Test brick generation
mason make ./ --name test_app --bundle-id com.test.app

# Validate generated project
cd test_app && flutter analyze
```

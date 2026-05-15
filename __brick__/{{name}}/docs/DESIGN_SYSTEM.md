# Design System

The design system is built on a token → atom → molecule hierarchy, using Material 3 with full dark mode support.

## Architecture

```
tokens/         → Raw design values (colors, spacing, typography, etc.)
atoms/          → Basic UI components (buttons, text fields, chips, etc.)
molecules/      → Compound components (cards, list tiles, states, etc.)
```

## Token Palette

### Colors (`tokens/colors.dart`)

Material 3 ColorSchemes generated from a single seed color. Available in light and dark variants.

```dart
// Access via BuildContext extension
final primary = context.colorScheme.primary;

// Or directly
final scheme = AppColors.lightColorScheme;
final darkScheme = AppColors.darkColorScheme;
```

Semantic colors: `success`, `warning`, `error`, `info`

### Typography (`tokens/typography.dart`)

Full Material 3 TextTheme with custom styles. Use via `Theme.of(context).textTheme` or directly:

```dart
Text('Hello', style: AppTextStyles.headlineLarge);
Text('Body', style: AppTextStyles.bodyMedium);
```

### Spacing (`tokens/spacing.dart`)

4px grid system with EdgeInsets presets.

| Token | Value | Use |
|-------|-------|-----|
| `xxs` | 4px | Tightest spacing |
| `xs` | 8px | Icon padding, tight |
| `sm` | 12px | Small gaps |
| `md` | 16px | Default spacing |
| `lg` | 24px | Section spacing |
| `xl` | 32px | Large gaps |
| `xxl` | 48px | Major section breaks |

```dart
SizedBox(height: AppSpacing.md);
Padding(padding: AppSpacing.paddingAllMd);
```

### Radii (`tokens/radii.dart`)

| Token | Value | Use |
|-------|-------|-----|
| `sm` | 4px | Subtle rounding |
| `md` | 8px | Cards, buttons |
| `lg` | 12px | Modal sheets |
| `xl` | 16px | Large containers |
| `pill` | 999px | Chips, avatars |

```dart
BorderRadius.circular(AppRadii.md);
```

### Shadows (`tokens/shadows.dart`)

```dart
BoxDecoration(boxShadow: AppShadows.subtle);
BoxDecoration(boxShadow: AppShadows.medium);
BoxDecoration(boxShadow: AppShadows.prominent);
```

## Component Catalog

### Atoms

#### AppButton
```dart
// Primary filled button
AppButton.primary(
  onPressed: () {},
  label: 'Submit',
  size: AppButtonSize.medium,
  isLoading: false,
  leadingIcon: Icon(Icons.add),
)

// Variants: primary, secondary, outline, ghost
// Sizes: small, medium, large
// States: default, disabled, loading
```

#### AppTextField
```dart
AppTextField(
  label: 'Email',
  hint: 'Enter your email',
  variant: AppTextFieldVariant.outlined,
  prefixIcon: Icon(Icons.email),
  validator: Validators.email,
)
// Variants: outlined, filled
```

#### AppChip
```dart
AppChip(
  label: 'Flutter',
  selected: true,
  onSelected: (v) {},
  leadingIcon: Icon(Icons.check),
)
```

#### AppAvatar
```dart
AppAvatar(
  imageUrl: 'https://...',
  initials: 'JD',
  size: AppAvatarSize.medium,
)
// Sizes: small(32), medium(48), large(72), xlarge(96)
```

#### AppIcon
```dart
AppIcon(Icons.star, size: AppIconSize.large, color: Colors.amber)
```

### Molecules

#### AppCard
```dart
AppCard(
  header: Text('Section Title'),
  child: Text('Card content'),
  footer: Text('Footer'),
  elevation: AppCardElevation.subtle,
  onTap: () {},
)
```

#### AppListTile
```dart
AppListTile(
  leading: AppAvatar(initials: 'JD'),
  title: Text('John Doe'),
  subtitle: Text('john@example.com'),
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)
```

#### AppEmptyState
```dart
AppEmptyState(
  icon: Icons.inbox_outlined,
  title: 'Nothing here',
  subtitle: 'Add your first item to get started',
  actionLabel: 'Add Item',
  onAction: () {},
)
```

#### AppErrorState
```dart
AppErrorState(
  message: 'Failed to load data',
  onRetry: () {},
)
```

## Dark Mode

Dark mode is enabled by default and controlled via `themeModeProvider`. The user can toggle between System, Light, and Dark in Settings.

All components use `Theme.of(context).colorScheme` — no hardcoded colors. This ensures automatic dark mode support.

```dart
// Provider state is persisted to SharedPreferences
final themeMode = ref.watch(themeModeProvider);
```

## Adding New Components

1. Create the component in `atoms/` or `molecules/`
2. Use design tokens for spacing, colors, radii, shadows
3. Always use `Theme.of(context).colorScheme` for colors
4. Add golden tests in `test/golden/design_system/`
5. Document the component in this file

## Usage Rules

- **Never** use raw Material widgets directly in features
- **Always** use design system components (AppButton over ElevatedButton, AppTextField over TextField, etc.)
- If a needed component doesn't exist, create it in the design system first

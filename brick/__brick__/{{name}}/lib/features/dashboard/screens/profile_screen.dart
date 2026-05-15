import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/widgets/responsive_padding.dart';
import '../../../design_system/atoms/app_button.dart';
import '../../../design_system/atoms/app_text_field.dart';
import '../../../design_system/atoms/app_avatar.dart';
import '../../../design_system/molecules/app_card.dart';
import '../../../design_system/tokens/spacing.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    final nameController = useTextEditingController(text: 'User');
    final bioController = useTextEditingController();
    final isEditing = useState(false);
    final isSaved = useState(false);

    Future<void> handleSave() async {
      // In a real app, this would save to Supabase
      isSaved.value = true;
      await Future.delayed(const Duration(seconds: 1));
      isSaved.value = false;
      isEditing.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        actions: [
          if (isEditing.value)
            TextButton(
              onPressed: isSaved.value ? null : handleSave,
              child: isSaved.value
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Text('Save'),
            )
          else
            TextButton(
              onPressed: () => isEditing.value = true,
              child: const Text('Edit'),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingAllMd,
          child: ResponsivePadding(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),

                // Avatar
                Center(
                  child: AppAvatar(
                    initials: _getInitials(user?.email ?? 'User'),
                    size: AppAvatarSize.xlarge,
                    onTap: () {
                      // Placeholder for image picker
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (isEditing.value)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Placeholder for image upload
                      },
                      child: const Text('Change Photo'),
                    ),
                  ),

                const SizedBox(height: AppSpacing.xl),

                // Profile form
                AppCard(
                  elevation: AppCardElevation.subtle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: 'Display Name',
                        hint: 'Enter your name',
                        controller: nameController,
                        readOnly: !isEditing.value,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Email',
                        controller: TextEditingController(
                          text: user?.email ?? 'No email',
                        ),
                        readOnly: true,
                        suffixIcon: const Icon(Icons.lock, size: 16),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Bio',
                        hint: 'Tell us about yourself',
                        controller: bioController,
                        readOnly: !isEditing.value,
                        maxLines: 3,
                        prefixIcon: const Icon(Icons.edit_note),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getInitials(String text) {
    final parts = text.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return text.isNotEmpty ? text[0].toUpperCase() : '?';
  }
}

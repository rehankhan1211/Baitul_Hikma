import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app/di.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/constants/app_icons.dart';
import '../../../data/services/local_storage_service.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _storage = di<LocalStorageService>();

  void _openEditProfileDialog(BuildContext context, AuthState authState) {
    final nameCtrl = TextEditingController(text: authState.userName);
    final emailCtrl = TextEditingController(text: authState.userEmail);
    final formKey = GlobalKey<FormState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: AppTextStyles.displaySmall(
                        color: isDark ? AppColors.gold : AppColors.emerald,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Update your reader details. Changes are persisted immediately across your library sanctuary.',
                  style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.sage : AppColors.inkFaint,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().length < 2) {
                      return 'Please enter a name with at least 2 characters.';
                    }
                    return null;
                  },
                ),
                if (!authState.isGuest) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) {
                      if (v != null &&
                          v.trim().isNotEmpty &&
                          (!v.contains('@') || !v.contains('.'))) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emerald,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            final success = await context
                                .read<AuthCubit>()
                                .updateProfile(
                                  name: nameCtrl.text,
                                  email:
                                      authState.isGuest ? null : emailCtrl.text,
                                );
                            if (ctx.mounted) {
                              Navigator.of(ctx).pop();
                            }
                            if (success && context.mounted) {
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated successfully'),
                                  backgroundColor: AppColors.emerald,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmSignOut(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
            title: Text(
              'Sign Out',
              style: AppTextStyles.displaySmall(
                color: isDark ? AppColors.gold : AppColors.emerald,
              ),
            ),
            content: Text(
              'Are you sure you want to end your current session? You can sign back in anytime to access your reading sanctuary.',
              style: AppTextStyles.bodyMedium(
                color: isDark ? AppColors.sage : AppColors.inkLight,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await context.read<AuthCubit>().logout();
                  if (context.mounted) {
                    context.go(AppRoutes.login);
                  }
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final history = _storage.readingHistory;
    final bookmarks = _storage.bookmarks;
    final streak = _storage.readingStreak;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final displayName =
            authState.userName.trim().isNotEmpty
                ? authState.userName
                : (authState.isGuest ? 'Guest Seeker' : 'Seeker of Wisdom');
        final initial =
            displayName.isNotEmpty ? displayName[0].toUpperCase() : 'S';
        final hasEmail =
            !authState.isGuest && authState.userEmail.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
          appBar: AppBar(
            backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
            title: Text(
              context.l10n.profile,
              style: AppTextStyles.displaySmall(
                color: isDark ? AppColors.gold : AppColors.emerald,
              ).copyWith(fontSize: 20),
            ),
            actions: [
              AppTopActions(isDark: isDark),
              IconButton(
                tooltip: 'Edit Profile',
                icon: Icon(
                  Icons.edit_outlined,
                  color: isDark ? AppColors.gold : AppColors.emerald,
                ),
                onPressed: () => _openEditProfileDialog(context, authState),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── USER PROFILE HEADER ──
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.ivory,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkDivider : AppColors.ivoryDark,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.3 : 0.05,
                        ),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.emerald, AppColors.emeraldLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: AppColors.gold, width: 2.2),
                        ),
                        child: Center(
                          child: Text(
                            initial,
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: AppTextStyles.displaySmall(
                                color: isDark ? AppColors.ivory : AppColors.ink,
                              ).copyWith(fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            if (hasEmail)
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_outlined,
                                    size: 14,
                                    color: AppColors.gold,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      authState.userEmail,
                                      style: AppTextStyles.bodySmall(
                                        color:
                                            isDark
                                                ? AppColors.sage
                                                : AppColors.inkFaint,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  authState.isGuest
                                      ? 'Guest Reader'
                                      : 'Library Member',
                                  style: AppTextStyles.labelMedium(
                                    color: AppColors.goldDark,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── READING STATISTICS ──
                Text(
                  'READING PROGRESS',
                  style: AppTextStyles.sectionLabel(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        imageAsset: AppIcons.streak,
                        value: '$streak',
                        label: 'Day Streak',
                        accentColor: const Color(0xFFE28743),
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.bookmarks_rounded,
                        value: '${bookmarks.length}',
                        label: 'Saved',
                        accentColor: AppColors.gold,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.auto_stories_rounded,
                        value: '${history.length}',
                        label: 'Read Items',
                        accentColor: AppColors.emerald,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── CONTINUE READING / RECENT ACTIVITY ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RECENT ACTIVITY',
                      style: AppTextStyles.sectionLabel(
                        color: isDark ? AppColors.gold : AppColors.emerald,
                      ),
                    ),
                    if (history.isNotEmpty)
                      Text(
                        '${history.length} items',
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (history.isEmpty)
                  _EmptyStateCard(
                    icon: Icons.menu_book_rounded,
                    title: 'No reading activity yet',
                    message:
                        'Your reading sanctuary is ready. Open any Surah, Hadith, or historical chapter to track your learning journey here.',
                    buttonLabel: 'Explore Library',
                    onAction: () => context.go('/explore'),
                    isDark: isDark,
                  )
                else
                  Column(
                    children:
                        history.take(4).map((entry) {
                          final title = entry['title'] ?? 'Reading Chapter';
                          final type = entry['type'] ?? 'library';
                          final id = entry['id'] ?? '';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color:
                                  isDark ? AppColors.darkCard : AppColors.ivory,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color:
                                    isDark
                                        ? AppColors.darkDivider
                                        : AppColors.ivoryDark,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              leading: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppColors.emerald.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  type == 'history'
                                      ? Icons.history_edu_rounded
                                      : Icons.menu_book_rounded,
                                  size: 20,
                                  color:
                                      isDark
                                          ? AppColors.gold
                                          : AppColors.emerald,
                                ),
                              ),
                              title: Text(
                                title,
                                style: AppTextStyles.bodyMedium(
                                  color:
                                      isDark ? AppColors.ivory : AppColors.ink,
                                ).copyWith(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                type.toUpperCase(),
                                style: AppTextStyles.labelMedium(
                                  color:
                                      isDark
                                          ? AppColors.sage
                                          : AppColors.inkFaint,
                                ).copyWith(fontSize: 10),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 13,
                                color:
                                    isDark
                                        ? AppColors.sage
                                        : AppColors.inkFaint,
                              ),
                              onTap: () {
                                if (type == 'history' && id.isNotEmpty) {
                                  context.push('/history/$id');
                                } else {
                                  context.go('/library');
                                }
                              },
                            ),
                          );
                        }).toList(),
                  ),
                const SizedBox(height: 28),



                // ── ACCOUNT PREFERENCES & SIGNOUT ──
                Text(
                  'ACCOUNT CONTROLS',
                  style: AppTextStyles.sectionLabel(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.ivory,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkDivider : AppColors.ivoryDark,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.square_arrow_right,
                      color: AppColors.error,
                    ),
                    title: Text(
                      authState.isLoggedIn ? 'Sign Out' : 'Sign In',
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.error,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      if (authState.isLoggedIn) {
                        _confirmSignOut(context);
                      } else {
                        context.go(AppRoutes.login);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData? icon;
  final String? imageAsset;
  final String value;
  final String label;
  final Color accentColor;
  final bool isDark;

  const _StatCard({
    this.icon,
    this.imageAsset,
    required this.value,
    required this.label,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageAsset != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                imageAsset!,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
            )
          else if (icon != null)
            Icon(icon, color: accentColor, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTextStyles.displaySmall(
              color: isDark ? AppColors.ivory : AppColors.ink,
            ).copyWith(fontSize: 22, height: 1.1),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelMedium(
              color: isDark ? AppColors.sage : AppColors.inkFaint,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onAction;
  final bool isDark;

  const _EmptyStateCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onAction,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 38,
            color: isDark ? AppColors.sage : AppColors.inkFaint,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodyLarge(
              color: isDark ? AppColors.ivory : AppColors.ink,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(
              color: isDark ? AppColors.sage : AppColors.inkFaint,
            ).copyWith(height: 1.5),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: isDark ? AppColors.gold : AppColors.emerald,
              side: BorderSide(
                color: isDark ? AppColors.gold : AppColors.emerald,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: onAction,
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}

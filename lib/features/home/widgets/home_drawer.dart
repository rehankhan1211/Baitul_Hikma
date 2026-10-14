import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/baitul_hikma_logo.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      child: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final displayName =
                authState.userName.trim().isNotEmpty
                    ? authState.userName
                    : (authState.isGuest ? 'Guest Seeker' : 'Seeker of Wisdom');
            final initial =
                displayName.isNotEmpty ? displayName[0].toUpperCase() : 'S';
            final hasEmail =
                !authState.isGuest && authState.userEmail.trim().isNotEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── HEADER: AVATAR & NAME ──
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push(AppRoutes.profile);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.ivory,
                      border: Border(
                        bottom: BorderSide(
                          color:
                              isDark
                                  ? AppColors.darkDivider
                                  : AppColors.ivoryDark,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.emerald,
                                AppColors.emeraldLight,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(color: AppColors.gold, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Name and Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: AppTextStyles.bodyLarge(
                                  color:
                                      isDark ? AppColors.ivory : AppColors.ink,
                                ).copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                hasEmail
                                    ? authState.userEmail
                                    : (authState.isGuest
                                        ? 'Guest Access'
                                        : 'Tap to view profile'),
                                style: AppTextStyles.bodySmall(
                                  color:
                                      isDark
                                          ? AppColors.sage
                                          : AppColors.inkFaint,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 13,
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── NAVIGATION LIST ──
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    children: [
                      // ── COLLECTIONS SECTION ──
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 8, top: 4),
                        child: Text(
                          'COLLECTIONS',
                          style: AppTextStyles.sectionLabel(
                            color: isDark ? AppColors.gold : AppColors.emerald,
                          ),
                        ),
                      ),
                      _DrawerTile(
                        icon: Icons.menu_book_rounded,
                        label: 'The Noble Quran',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(AppRoutes.quran);
                        },
                      ),
                      _DrawerTile(
                        icon: Icons.library_books_rounded,
                        label: 'Hadith Collections',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(AppRoutes.hadith);
                        },
                      ),
                      _DrawerTile(
                        icon: Icons.history_edu_rounded,
                        label: 'Historical Chronicles',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(AppRoutes.explore);
                        },
                      ),
                      _DrawerTile(
                        icon: Icons.bookmarks_outlined,
                        label: 'Saved Bookmarks',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(AppRoutes.library);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color:
                              isDark
                                  ? AppColors.darkDivider
                                  : AppColors.ivoryDark,
                        ),
                      ),

                      // ── PROFILE SECTION ──
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 8),
                        child: Text(
                          'PROFILE',
                          style: AppTextStyles.sectionLabel(
                            color: isDark ? AppColors.gold : AppColors.emerald,
                          ),
                        ),
                      ),
                      _DrawerTile(
                        icon: Icons.person_outline_rounded,
                        label: 'My Profile',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.profile);
                        },
                      ),
                      _DrawerTile(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.settings);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color:
                              isDark
                                  ? AppColors.darkDivider
                                  : AppColors.ivoryDark,
                        ),
                      ),

                      // ── ABOUT SECTION ──
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 8),
                        child: Text(
                          'ABOUT',
                          style: AppTextStyles.sectionLabel(
                            color: isDark ? AppColors.gold : AppColors.emerald,
                          ),
                        ),
                      ),
                      _DrawerTile(
                        icon: Icons.info_outline_rounded,
                        label: 'About Baitul Hikma',
                        isDark: isDark,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.about);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color:
                              isDark
                                  ? AppColors.darkDivider
                                  : AppColors.ivoryDark,
                        ),
                      ),

                      _DrawerTile(
                        icon: CupertinoIcons.square_arrow_right,
                        label: authState.isLoggedIn ? 'Sign Out' : 'Sign In',
                        iconColor: AppColors.error,
                        textColor: AppColors.error,
                        isDark: isDark,
                        onTap: () async {
                          Navigator.of(context).pop();
                          if (authState.isLoggedIn) {
                            await context.read<AuthCubit>().logout();
                          }
                          if (context.mounted) {
                            context.go(AppRoutes.login);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // ── DRAWER FOOTER ──
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color:
                            isDark
                                ? AppColors.darkDivider
                                : AppColors.ivoryDark,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const BaitulHikmaLogo(
                        width: 38,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.appName,
                              style: AppTextStyles.labelLarge(
                                color: isDark ? AppColors.ivory : AppColors.ink,
                              ),
                            ),
                            Text(
                              AppConstants.appSubtitle,
                              style: AppTextStyles.bodySmall(
                                color:
                                    isDark
                                        ? AppColors.sage
                                        : AppColors.inkFaint,
                              ).copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;
  final Color? iconColor;
  final Color? textColor;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(
        icon,
        size: 20,
        color: iconColor ?? (isDark ? AppColors.gold : AppColors.emerald),
      ),
      title: Text(
        label,
        style: AppTextStyles.bodyMedium(
          color: textColor ?? (isDark ? AppColors.ivory : AppColors.ink),
        ).copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

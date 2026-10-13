import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/settings_cubit.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/baitul_hikma_logo.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/app_language.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required VoidCallback onConfirm,
    bool isDestructive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              title,
              style: AppTextStyles.displaySmall(
                color:
                    isDestructive
                        ? AppColors.error
                        : (isDark ? AppColors.gold : AppColors.emerald),
              ).copyWith(fontSize: 20),
            ),
            content: Text(
              message,
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
                  backgroundColor:
                      isDestructive ? AppColors.error : AppColors.emerald,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onConfirm();
                },
                child: Text(confirmLabel),
              ),
            ],
          ),
    );
  }

  void _selectReminderTime(BuildContext context, String currentTime) async {
    final timeOfDay = TimeOfDay(hour: 7, minute: 0);
    final picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
      builder: (ctx, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                isDark
                    ? const ColorScheme.dark(
                      primary: AppColors.gold,
                      surface: AppColors.darkCard,
                    )
                    : const ColorScheme.light(
                      primary: AppColors.emerald,
                      surface: AppColors.ivory,
                    ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (picked != null && context.mounted) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      final formatted = '$hour:$minute $period';
      context.read<SettingsCubit>().setReminderTime(formatted);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Daily reminder scheduled for $formatted'),
          backgroundColor: AppColors.emerald,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
          appBar: AppBar(
            backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
            title: Text(
              context.l10n.settings,
              style: AppTextStyles.displaySmall(
                color: isDark ? AppColors.gold : AppColors.emerald,
              ).copyWith(fontSize: 20),
            ),
            actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // ── ACCOUNT SUMMARY ──
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  final name =
                      authState.userName.isNotEmpty
                          ? authState.userName
                          : 'Seeker of Knowledge';
                  final email =
                      authState.userEmail.isNotEmpty
                          ? authState.userEmail
                          : (authState.isGuest
                              ? 'Guest Access'
                              : 'Not signed in');

                  return _SettingsSection(
                    title: 'ACCOUNT',
                    isDark: isDark,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.emerald,
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'S',
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(
                          name,
                          style: AppTextStyles.labelLarge(
                            color: isDark ? AppColors.ivory : AppColors.ink,
                          ).copyWith(fontSize: 15),
                        ),
                        subtitle: Text(
                          email,
                          style: AppTextStyles.bodySmall(
                            color: isDark ? AppColors.sage : AppColors.inkFaint,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                        onTap: () => context.push(AppRoutes.profile),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // ── APPEARANCE ──
              _SettingsSection(
                title: 'APPEARANCE',
                isDark: isDark,
                children: [_ThemeTile(settings: settings, isDark: isDark)],
              ),
              const SizedBox(height: 20),

              // ── LANGUAGE ──
              _SettingsSection(
                title: context.l10n.language.toUpperCase(),
                isDark: isDark,
                children: [_LanguageTile(settings: settings, isDark: isDark)],
              ),
              const SizedBox(height: 20),

              // ── READING PREFERENCES ──
              _SettingsSection(
                title: 'READING PREFERENCES',
                isDark: isDark,
                children: [
                  _FontSizeTile(
                    label: 'Translation / Body Font Size',
                    value: settings.bodyFontSize,
                    min: AppConstants.minFontSize,
                    max: AppConstants.maxFontSize,
                    isDark: isDark,
                    onChanged:
                        (v) => context.read<SettingsCubit>().setBodyFontSize(v),
                  ),
                  _FontSizeTile(
                    label: 'Arabic Script Font Size',
                    value: settings.arabicFontSize,
                    min: AppConstants.arabicMinFontSize,
                    max: AppConstants.arabicMaxFontSize,
                    isDark: isDark,
                    onChanged:
                        (v) =>
                            context.read<SettingsCubit>().setArabicFontSize(v),
                  ),
                  _LineSpacingTile(
                    spacing: settings.lineSpacing,
                    isDark: isDark,
                    onChanged:
                        (v) => context.read<SettingsCubit>().setLineSpacing(v),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── AUDIO & RECITATION ──
              _SettingsSection(
                title: 'AUDIO & RECITATION',
                isDark: isDark,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.audiotrack_rounded,
                              size: 18,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Recitation Streaming Quality',
                              style: AppTextStyles.bodyMedium(
                                color: isDark ? AppColors.ivory : AppColors.ink,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Standard (128 kbps) • Optimized for crystal clarity and low network consumption.',
                          style: AppTextStyles.bodySmall(
                            color: isDark ? AppColors.sage : AppColors.inkFaint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── NOTIFICATIONS ──
              _SettingsSection(
                title: 'NOTIFICATIONS & REMINDERS',
                isDark: isDark,
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      'Daily Wisdom Reminder',
                      style: AppTextStyles.bodyLarge(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Receive daily verse and contemplative reflection reminders.',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    value: settings.dailyReminder,
                    activeColor: AppColors.gold,
                    activeTrackColor: AppColors.emerald,
                    onChanged: (val) {
                      context.read<SettingsCubit>().setDailyReminder(val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val
                                ? 'Daily reminders enabled'
                                : 'Daily reminders disabled',
                          ),
                          backgroundColor: AppColors.emerald,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  if (settings.dailyReminder)
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      title: Text(
                        'Reminder Time',
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.ivory : AppColors.ink,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          settings.reminderTime,
                          style: AppTextStyles.labelLarge(
                            color: isDark ? AppColors.gold : AppColors.emerald,
                          ),
                        ),
                      ),
                      onTap:
                          () => _selectReminderTime(
                            context,
                            settings.reminderTime,
                          ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // ── STORAGE & OFFLINE ──
              _SettingsSection(
                title: 'STORAGE & CACHE',
                isDark: isDark,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    leading: const Icon(Icons.storage_rounded),
                    title: Text(
                      'Library Cache & Bitmaps',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    subtitle: Text(
                      'Free memory used by cached manuscripts and book emblems.',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    trailing: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        _showConfirmDialog(
                          context: context,
                          title: 'Clear Cache',
                          message:
                              'This will clear temporary in-memory image and typography caches. Your reading progress and saved bookmarks will remain completely intact.',
                          confirmLabel: 'Clear Cache',
                          onConfirm: () {
                            PaintingBinding.instance.imageCache.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cache cleared successfully'),
                                backgroundColor: AppColors.emerald,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── PRIVACY & RESET ──
              _SettingsSection(
                title: 'PRIVACY & DATA CONTROLS',
                isDark: isDark,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.delete_sweep_outlined),
                    title: Text(
                      'Clear Reading History',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    subtitle: Text(
                      'Remove records of recently opened chapters and verses.',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    onTap: () {
                      _showConfirmDialog(
                        context: context,
                        isDestructive: true,
                        title: 'Clear Reading History',
                        message:
                            'Are you sure you want to delete your reading history? This action cannot be undone.',
                        confirmLabel: 'Clear History',
                        onConfirm: () async {
                          await context
                              .read<SettingsCubit>()
                              .clearReadingHistory();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reading history cleared'),
                                backgroundColor: AppColors.emerald,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.refresh_rounded),
                    title: Text(
                      'Reset All Preferences',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    subtitle: Text(
                      'Restore font sizes, theme, and reminder timings to defaults.',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    onTap: () {
                      _showConfirmDialog(
                        context: context,
                        isDestructive: true,
                        title: 'Reset Preferences',
                        message:
                            'This will reset your theme, font sizes, line height, and reminder settings back to their original defaults.',
                        confirmLabel: 'Reset',
                        onConfirm: () async {
                          await context
                              .read<SettingsCubit>()
                              .resetPreferences();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All settings reset to defaults'),
                                backgroundColor: AppColors.emerald,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── ABOUT NAVIGATION ──
              _SettingsSection(
                title: 'ABOUT BAITUL HIKMA',
                isDark: isDark,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text(
                      'About the Digital Sanctuary',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Heritage, mission, source attribution, and credits.',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                    onTap: () => context.push(AppRoutes.about),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── BRAND FOOTER ──
              Center(
                child: Column(
                  children: [
                    BaitulHikmaLogo(width: 160, height: 80, isDark: isDark),
                    const SizedBox(height: 6),
                    Text(
                      '${AppConstants.appName} — ${AppConstants.appSubtitle}',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Version 1.0.0+1',
                      style: AppTextStyles.labelMedium(
                        color: isDark ? AppColors.sageDark : AppColors.inkFaint,
                      ).copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final bool isDark;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionLabel(color: AppColors.gold)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.ivory,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
            ),
          ),
          child: Column(
            children:
                children
                    .asMap()
                    .entries
                    .map(
                      (e) => Column(
                        children: [
                          e.value,
                          if (e.key < children.length - 1)
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color:
                                  isDark
                                      ? AppColors.darkDivider
                                      : AppColors.ivoryDark,
                            ),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final SettingsState settings;
  final bool isDark;

  const _ThemeTile({required this.settings, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Palette',
            style: AppTextStyles.bodyLarge(
              color: isDark ? AppColors.ivory : AppColors.ink,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ThemeOption(
                label: 'Light',
                icon: Icons.light_mode_rounded,
                isSelected: settings.themeMode == ThemeMode.light,
                isDark: isDark,
                onTap:
                    () =>
                        context.read<SettingsCubit>().setTheme(ThemeMode.light),
              ),
              const SizedBox(width: 8),
              _ThemeOption(
                label: 'Dark',
                icon: Icons.dark_mode_rounded,
                isSelected: settings.themeMode == ThemeMode.dark,
                isDark: isDark,
                onTap:
                    () =>
                        context.read<SettingsCubit>().setTheme(ThemeMode.dark),
              ),
              const SizedBox(width: 8),
              _ThemeOption(
                label: 'System',
                icon: Icons.settings_system_daydream_rounded,
                isSelected: settings.themeMode == ThemeMode.system,
                isDark: isDark,
                onTap:
                    () => context.read<SettingsCubit>().setTheme(
                      ThemeMode.system,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? (isDark ? AppColors.gold : AppColors.emerald)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isSelected
                      ? (isDark ? AppColors.gold : AppColors.emerald)
                      : (isDark ? AppColors.darkDivider : AppColors.ivoryDark),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color:
                    isSelected
                        ? (isDark ? AppColors.darkBg : Colors.white)
                        : (isDark ? AppColors.sage : AppColors.inkFaint),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.labelMedium(
                  color:
                      isSelected
                          ? (isDark ? AppColors.darkBg : Colors.white)
                          : (isDark ? AppColors.sage : AppColors.inkFaint),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final SettingsState settings;
  final bool isDark;

  const _LanguageTile({required this.settings, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final currentLang = AppLanguage.fromCode(settings.languageCode);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Application Language',
                style: AppTextStyles.bodyLarge(
                  color: isDark ? AppColors.ivory : AppColors.ink,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => LanguageActionButton.showLanguageModal(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Text(
                    'Change',
                    style: AppTextStyles.labelMedium(color: AppColors.gold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  AppLanguage.supportedLanguages.map((lang) {
                    final isSelected = lang.code == currentLang.code;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap:
                            () => context.read<SettingsCubit>().setLanguage(
                              lang.code,
                            ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? (isDark
                                        ? AppColors.gold
                                        : AppColors.emerald)
                                    : (isDark
                                        ? AppColors.darkSurface
                                        : AppColors.ivoryDark),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? (isDark
                                          ? AppColors.gold
                                          : AppColors.emerald)
                                      : (isDark
                                          ? AppColors.darkDivider
                                          : AppColors.ivoryDark),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                lang.flag,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                lang.nativeName,
                                style: AppTextStyles.labelLarge(
                                  color:
                                      isSelected
                                          ? (isDark
                                              ? AppColors.darkBg
                                              : Colors.white)
                                          : (isDark
                                              ? AppColors.ivory
                                              : AppColors.ink),
                                ).copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FontSizeTile extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final bool isDark;
  final ValueChanged<double> onChanged;

  const _FontSizeTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.ivory : AppColors.ink,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${value.round()} pt',
                  style: AppTextStyles.labelLarge(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: isDark ? AppColors.gold : AppColors.emerald,
              inactiveTrackColor:
                  isDark ? AppColors.darkDivider : AppColors.ivoryDark,
              thumbColor: isDark ? AppColors.gold : AppColors.emerald,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: ((max - min) / 2).round(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _LineSpacingTile extends StatelessWidget {
  final double spacing;
  final bool isDark;
  final ValueChanged<double> onChanged;

  const _LineSpacingTile({
    required this.spacing,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reading Line Spacing',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.ivory : AppColors.ink,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${spacing.toStringAsFixed(1)}x',
                  style: AppTextStyles.labelLarge(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: isDark ? AppColors.gold : AppColors.emerald,
              inactiveTrackColor:
                  isDark ? AppColors.darkDivider : AppColors.ivoryDark,
              thumbColor: isDark ? AppColors.gold : AppColors.emerald,
            ),
            child: Slider(
              value: spacing,
              min: 1.4,
              max: 2.2,
              divisions: 8,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

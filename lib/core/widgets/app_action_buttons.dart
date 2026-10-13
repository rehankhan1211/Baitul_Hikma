import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../localization/app_language.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../../features/settings/bloc/settings_cubit.dart';

class LanguageActionButton extends StatelessWidget {
  final bool isDark;
  final Color? color;

  const LanguageActionButton({super.key, required this.isDark, this.color});

  static void showLanguageModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentCode = context.read<SettingsCubit>().state.languageCode;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Language / اختر اللغة',
                    style: AppTextStyles.displaySmall(
                      color: isDark ? AppColors.gold : AppColors.emerald,
                    ).copyWith(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Choose your preferred reading language.',
                style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.sage : AppColors.inkFaint,
                ),
              ),
              const SizedBox(height: 16),
              ...AppLanguage.supportedLanguages.map((lang) {
                final isSelected = lang.code == currentCode;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? (isDark
                                ? AppColors.gold.withValues(alpha: 0.15)
                                : AppColors.emerald.withValues(alpha: 0.08))
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppColors.gold
                              : (isDark
                                  ? AppColors.darkDivider
                                  : AppColors.ivoryDark),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    leading: Text(
                      lang.flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      lang.nativeName,
                      style: AppTextStyles.bodyLarge(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      lang.name,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    trailing:
                        isSelected
                            ? const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.gold,
                              size: 20,
                            )
                            : null,
                    onTap: () {
                      context.read<SettingsCubit>().setLanguage(lang.code);
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language set to ${lang.nativeName}'),
                          backgroundColor: AppColors.emerald,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(milliseconds: 1400),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? (isDark ? AppColors.gold : AppColors.emerald);

    return IconButton(
      tooltip: 'Change Language',
      icon: Icon(Icons.language_rounded, color: effectiveColor),
      onPressed: () => showLanguageModal(context),
    );
  }
}

class ThemeActionButton extends StatelessWidget {
  final bool isDark;
  final Color? color;

  const ThemeActionButton({super.key, required this.isDark, this.color});

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? (isDark ? AppColors.gold : AppColors.emerald);

    return IconButton(
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: effectiveColor,
      ),
      onPressed: () {
        context.read<SettingsCubit>().setTheme(
          isDark ? ThemeMode.light : ThemeMode.dark,
        );
      },
    );
  }
}

class AppTopActions extends StatelessWidget {
  final bool isDark;
  final Color? color;

  const AppTopActions({super.key, required this.isDark, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeActionButton(isDark: isDark, color: color),
        LanguageActionButton(isDark: isDark, color: color),
      ],
    );
  }
}

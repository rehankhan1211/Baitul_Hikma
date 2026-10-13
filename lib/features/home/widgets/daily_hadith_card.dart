import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/hadith_model.dart';

class DailyHadithCard extends StatelessWidget {
  final HadithModel hadith;
  final VoidCallback? onTap;

  const DailyHadithCard({super.key, required this.hadith, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : AppColors.ivory;
    final borderColor = isDark ? AppColors.darkDivider : AppColors.ivoryDark;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap ?? () => context.go(AppRoutes.hadith),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gold accent bar
              Container(
                height: 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.gold, AppColors.goldLight],
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arabic
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    hadith.arabicText,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      color:
                          isDark
                              ? AppColors.arabicTextDark
                              : AppColors.arabicText,
                      height: 2.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 1, color: borderColor),
                const SizedBox(height: 12),
                // Translation
                Text(
                  '"${hadith.englishText}"',
                  style: AppTextStyles.bodyMedium(
                    color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                  ).copyWith(fontStyle: FontStyle.italic, height: 1.65),
                ),
                const SizedBox(height: 12),
                // Narrator + Grade row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Narrated by ${hadith.narrator}',
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.sageDark,
                        ),
                      ),
                    ),
                    if (hadith.grade != null)
                      _GradeChip(grade: hadith.grade!, isDark: isDark),
                  ],
                ),
                if (hadith.reference != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    hadith.reference!,
                    style: AppTextStyles.bodySmall(
                      color:
                          isDark
                              ? AppColors.gold.withValues(alpha: 0.7)
                              : AppColors.goldDark,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
}
}

class _GradeChip extends StatelessWidget {
  final String grade;
  final bool isDark;
  const _GradeChip({required this.grade, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        grade,
        style: AppTextStyles.labelMedium(
          color: AppColors.success,
        ).copyWith(fontSize: 10),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/history_chapter_model.dart';

class FeaturedChapterCard extends StatelessWidget {
  final HistoryChapter chapter;
  const FeaturedChapterCard({super.key, required this.chapter});

  Color _eraColor(Era era) => switch (era) {
    Era.preIslamic => const Color(0xFF7A5C3E),
    Era.propheticMecca => const Color(0xFF203D31),
    Era.propheticMadina => const Color(0xFF2E5544),
    Era.khulafaRashideen => const Color(0xFF1E5F74),
    Era.umayyad => const Color(0xFF4A0E5C),
    Era.abbasid => const Color(0xFF8B0000),
    Era.scholars => const Color(0xFF4F5D2F),
    Era.lateIslamic => const Color(0xFF3D3D3D),
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eraColor = _eraColor(chapter.era);

    return GestureDetector(
      onTap: () => context.push('/history/${chapter.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.ivory,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
          ),
        ),
        child: Row(
          children: [
            // Color spine (book-like)
            Container(
              width: 6,
              height: 100,
              decoration: BoxDecoration(
                color: eraColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Era + Reading time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: eraColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            chapter.eraLabel.toUpperCase(),
                            style: AppTextStyles.labelMedium(
                              color: eraColor,
                            ).copyWith(fontSize: 9),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${chapter.readingTimeMinutes} min',
                          style: AppTextStyles.bodySmall(
                            color: isDark ? AppColors.sage : AppColors.inkFaint,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      chapter.title,
                      style: AppTextStyles.chapterTitle(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      chapter.subtitle,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.sageDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      chapter.period,
                      style: AppTextStyles.labelMedium(
                        color:
                            isDark
                                ? AppColors.gold.withValues(alpha: 0.8)
                                : AppColors.goldDark,
                      ).copyWith(letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDark ? AppColors.sage : AppColors.inkFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

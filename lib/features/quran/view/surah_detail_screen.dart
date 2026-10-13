import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quran_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../data/models/surah_model.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;
  const SurahDetailScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        final surah =
            state.surahs.isEmpty
                ? null
                : state.surahs.firstWhere(
                  (s) => s.number == surahNumber,
                  orElse: () => state.surahs.first,
                );

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _SurahAppBar(surah: surah, isDark: isDark, state: state),
              if (state.isLoadingAyahs)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.emerald),
                  ),
                )
              else if (state.currentAyahs.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📖', style: const TextStyle(fontSize: 48)),
                        const SizedBox(height: 16),
                        Text(
                          'Full Quran content will be\navailable via API integration',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.sage : AppColors.inkFaint,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _AyahCard(
                      ayah: state.currentAyahs[i],
                      isDark: isDark,
                      arabicFontSize: state.arabicFontSize,
                      showTranslation: state.showTranslation,
                      showTafseer: state.showTafseer,
                    ),
                    childCount: state.currentAyahs.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SurahAppBar extends StatelessWidget {
  final SurahModel? surah;
  final bool isDark;
  final QuranState state;
  const _SurahAppBar({
    required this.surah,
    required this.isDark,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.emerald,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  isDark
                      ? [AppColors.emeraldDeep, AppColors.darkBg]
                      : [AppColors.emerald, AppColors.emeraldLight],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text(
                  surah?.nameArabic ?? '',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                Text(
                  surah?.nameTransliteration ?? '',
                  style: AppTextStyles.displaySmall(
                    color: Colors.white70,
                  ).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  '${surah?.ayahCount ?? 0} Ayahs',
                  style: AppTextStyles.bodySmall(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        AppTopActions(isDark: isDark, color: Colors.white),
        IconButton(
          icon: Icon(
            state.showTranslation ? Icons.translate : Icons.translate_outlined,
            color: Colors.white,
          ),
          tooltip: 'Toggle translation',
          onPressed: () => context.read<QuranCubit>().toggleTranslation(),
        ),
        IconButton(
          icon: Icon(
            state.showTafseer ? Icons.book : Icons.book_outlined,
            color: Colors.white,
          ),
          tooltip: 'Toggle tafseer',
          onPressed: () => context.read<QuranCubit>().toggleTafseer(),
        ),
      ],
    );
  }
}

class _AyahCard extends StatelessWidget {
  final AyahModel ayah;
  final bool isDark;
  final double arabicFontSize;
  final bool showTranslation;
  final bool showTafseer;

  const _AyahCard({
    required this.ayah,
    required this.isDark,
    required this.arabicFontSize,
    required this.showTranslation,
    required this.showTafseer,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : AppColors.ivory;
    final borderColor = isDark ? AppColors.darkDivider : AppColors.ivoryDark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ayah number badge
          Row(
            children: [
              _AyahNumberBadge(number: ayah.ayahNumber, isDark: isDark),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.copy_outlined,
                  size: 18,
                  color: isDark ? AppColors.sage : AppColors.inkFaint,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: ayah.arabicText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Ayah copied'),
                      backgroundColor: AppColors.emerald,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Arabic text
          Text(
            ayah.arabicText,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: arabicFontSize,
              color: isDark ? AppColors.arabicTextDark : AppColors.arabicText,
              height: 2.1,
            ),
          ),
          // Translation
          if (showTranslation) ...[
            const SizedBox(height: 12),
            Container(height: 1, color: borderColor),
            const SizedBox(height: 12),
            Text(
              ayah.translation,
              style: AppTextStyles.bodyMedium(
                color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
              ).copyWith(fontStyle: FontStyle.italic, height: 1.65),
            ),
          ],
          // Tafseer
          if (showTafseer && ayah.tafseer != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.emerald.withValues(alpha: isDark ? 0.1 : 0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.emerald.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TAFSEER',
                    style: AppTextStyles.sectionLabel(
                      color: isDark ? AppColors.gold : AppColors.emerald,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ayah.tafseer!,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                    ).copyWith(height: 1.7),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AyahNumberBadge extends StatelessWidget {
  final int number;
  final bool isDark;
  const _AyahNumberBadge({required this.number, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Text(
          '$number',
          style: AppTextStyles.labelLarge(
            color: AppColors.goldDark,
          ).copyWith(fontSize: 12),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hadith_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../data/models/hadith_model.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      body: BlocBuilder<HadithCubit, HadithState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor:
                    isDark ? AppColors.darkBg : AppColors.parchment,
                title: Text(
                  context.l10n.hadithCollections,
                  style: AppTextStyles.displaySmall(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ),
                ),
                actions: [
                  AppTopActions(isDark: isDark),
                  const SizedBox(width: 4),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Collections
                      Text(
                        'COLLECTIONS',
                        style: AppTextStyles.sectionLabel(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.collections.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 12),
                          itemBuilder:
                              (context, i) => _CollectionCard(
                                collection: state.collections[i],
                                isDark: isDark,
                                onTap:
                                    () => context
                                        .read<HadithCubit>()
                                        .selectCollection(state.collections[i]),
                              ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'FEATURED HADITHS',
                        style: AppTextStyles.sectionLabel(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _HadithCard(
                        hadith: state.featured[i],
                        isDark: isDark,
                      ),
                    ),
                    childCount: state.featured.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final HadithCollection collection;
  final bool isDark;
  final VoidCallback onTap;

  const _CollectionCard({
    required this.collection,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(collection.coverColor.replaceFirst('#', 'FF'), radix: 16),
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: 0.7)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                collection.nameArabic,
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                collection.nameEnglish,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '${collection.totalHadiths.toString()} Hadiths',
                style: const TextStyle(color: Colors.white60, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HadithCard extends StatelessWidget {
  final HadithModel hadith;
  final bool isDark;
  const _HadithCard({required this.hadith, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          if (hadith.topic != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.emerald.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hadith.topic!,
                style: AppTextStyles.labelMedium(
                  color: AppColors.emerald,
                ).copyWith(fontSize: 10),
              ),
            ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              hadith.arabicText,
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18,
                color: isDark ? AppColors.arabicTextDark : AppColors.arabicText,
                height: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
          ),
          const SizedBox(height: 10),
          Text(
            '"${hadith.englishText}"',
            style: AppTextStyles.bodyMedium(
              color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
            ).copyWith(fontStyle: FontStyle.italic, height: 1.65),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  '— ${hadith.narrator}',
                  style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.sage : AppColors.sageDark,
                  ),
                ),
              ),
              if (hadith.grade != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    hadith.grade!,
                    style: AppTextStyles.labelMedium(
                      color: AppColors.success,
                    ).copyWith(fontSize: 10),
                  ),
                ),
            ],
          ),
          if (hadith.reference != null) ...[
            const SizedBox(height: 4),
            Text(
              hadith.reference!,
              style: AppTextStyles.bodySmall(
                color:
                    isDark
                        ? AppColors.gold.withValues(alpha: 0.6)
                        : AppColors.goldDark,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

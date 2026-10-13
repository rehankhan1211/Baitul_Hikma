import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/explore_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../data/models/history_chapter_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      body: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _ExploreAppBar(isDark: isDark, state: state),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  ),
                )
              else ...[
                // View toggle
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: _ViewToggle(state: state, isDark: isDark),
                  ),
                ),
                // Era filter chips
                SliverToBoxAdapter(
                  child: _EraFilterChips(state: state, isDark: isDark),
                ),
                // Content
                if (state.currentView == ExploreView.shelf)
                  _BookshelfContent(state: state, isDark: isDark)
                else
                  _TimelineContent(state: state, isDark: isDark),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ExploreAppBar extends StatelessWidget {
  final bool isDark;
  final ExploreState state;
  const _ExploreAppBar({required this.isDark, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      title: Text(
        context.l10n.exploreWisdom,
        style: AppTextStyles.displaySmall(
          color: isDark ? AppColors.gold : AppColors.emerald,
        ),
      ),
      actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
    );
  }
}

class _ViewToggle extends StatelessWidget {
  final ExploreState state;
  final bool isDark;
  const _ViewToggle({required this.state, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ToggleButton(
            label: '📚 Bookshelf',
            isActive: state.currentView == ExploreView.shelf,
            isDark: isDark,
            onTap:
                () => context.read<ExploreCubit>().setView(ExploreView.shelf),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ToggleButton(
            label: '📅 Timeline',
            isActive: state.currentView == ExploreView.timeline,
            isDark: isDark,
            onTap:
                () =>
                    context.read<ExploreCubit>().setView(ExploreView.timeline),
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;
  const _ToggleButton({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color:
              isActive
                  ? (isDark ? AppColors.gold : AppColors.emerald)
                  : (isDark ? AppColors.darkCard : AppColors.ivory),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isActive
                    ? (isDark ? AppColors.gold : AppColors.emerald)
                    : (isDark ? AppColors.darkDivider : AppColors.ivoryDark),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelLarge(
            color:
                isActive
                    ? (isDark ? AppColors.darkBg : Colors.white)
                    : (isDark ? AppColors.sage : AppColors.inkFaint),
          ).copyWith(fontSize: 13),
        ),
      ),
    );
  }
}

class _EraFilterChips extends StatelessWidget {
  final ExploreState state;
  final bool isDark;
  const _EraFilterChips({required this.state, required this.isDark});

  static const _eras = [
    (null, 'All Eras'),
    (Era.preIslamic, 'Pre-Islamic'),
    (Era.propheticMecca, 'Makkah'),
    (Era.propheticMadina, 'Madinah'),
    (Era.khulafaRashideen, 'Caliphs'),
    (Era.abbasid, 'Abbasid'),
    (Era.scholars, 'Scholars'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _eras.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (era, label) = _eras[i];
          final isSelected = state.selectedEra == era;
          return GestureDetector(
            onTap: () => context.read<ExploreCubit>().selectEra(era),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.gold
                        : (isDark ? AppColors.darkCard : AppColors.ivory),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.gold
                          : (isDark
                              ? AppColors.darkDivider
                              : AppColors.ivoryDark),
                ),
              ),
              child: Text(
                label,
                style: AppTextStyles.labelLarge(
                  color:
                      isSelected
                          ? AppColors.darkBg
                          : (isDark ? AppColors.sage : AppColors.inkFaint),
                ).copyWith(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookshelfContent extends StatelessWidget {
  final ExploreState state;
  final bool isDark;
  const _BookshelfContent({required this.state, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExploreCubit>();
    final chapters = cubit.filteredChapters;

    if (chapters.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            'No chapters in this era yet.',
            style: AppTextStyles.bodyMedium(
              color: isDark ? AppColors.sage : AppColors.inkFaint,
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _HistoryBookCard(chapter: chapters[i], isDark: isDark),
          ),
          childCount: chapters.length,
        ),
      ),
    );
  }
}

class _HistoryBookCard extends StatelessWidget {
  final HistoryChapter chapter;
  final bool isDark;
  const _HistoryBookCard({required this.chapter, required this.isDark});

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
    final eraColor = _eraColor(chapter.era);

    return GestureDetector(
      onTap: () => context.push('/history/${chapter.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.ivory,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with era color
            Container(
              height: 6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [eraColor, eraColor.withValues(alpha: 0.6)],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Text(
                        chapter.period,
                        style: AppTextStyles.bodySmall(
                          color:
                              isDark
                                  ? AppColors.gold.withValues(alpha: 0.7)
                                  : AppColors.goldDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    chapter.title,
                    style: AppTextStyles.displaySmall(
                      color: isDark ? AppColors.ivory : AppColors.ink,
                    ).copyWith(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chapter.subtitle,
                    style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.sage : AppColors.sageDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    chapter.introduction,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                    ).copyWith(height: 1.6),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${chapter.readingTimeMinutes} min read',
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.article_outlined,
                        size: 14,
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${chapter.sections.length} sections',
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: eraColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Read',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineContent extends StatelessWidget {
  final ExploreState state;
  final bool isDark;
  const _TimelineContent({required this.state, required this.isDark});

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
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, i) {
          final event = state.timeline[i];
          final color = _eraColor(event.era);
          final isLast = i == state.timeline.length - 1;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Timeline vertical connector line
              if (!isLast)
                Positioned(
                  top: 18,
                  bottom: 0,
                  left: 19,
                  child: Container(
                    width: 2,
                    color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
                  ),
                ),
              // Timeline dot
              Positioned(
                top: 4,
                left: 13,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.only(left: 44, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.year,
                      style: AppTextStyles.labelLarge(
                        color: color,
                      ).copyWith(letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.event,
                      style: AppTextStyles.bodyLarge(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (event.detail != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        event.detail!,
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ).copyWith(height: 1.5),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        }, childCount: state.timeline.length),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/home_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/daily_ayah_card.dart';
import '../widgets/daily_hadith_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/featured_chapter_card.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/home_drawer.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../settings/bloc/settings_cubit.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = context.read<SettingsCubit>();

    return Scaffold(
      drawer: const HomeDrawer(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: _HomeShimmer());
          }
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _HomeAppBar(isDark: isDark, settings: settings),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      // Streak card
                      if (state.streak > 0) ...[
                        StreakCard(streak: state.streak),
                        const SizedBox(height: 20),
                      ],
                      // Daily Ayah
                      if (state.dailyAyah != null) ...[
                        _SectionLabel(label: 'ĀYAH OF THE DAY'),
                        const SizedBox(height: 10),
                        DailyAyahCard(ayah: state.dailyAyah!),
                        const SizedBox(height: 24),
                      ],
                      // Daily Hadith
                      if (state.dailyHadith != null) ...[
                        _SectionLabel(label: 'HADITH OF THE DAY'),
                        const SizedBox(height: 10),
                        DailyHadithCard(hadith: state.dailyHadith!),
                        const SizedBox(height: 24),
                      ],
                      // Quick access
                      _SectionLabel(label: 'QUICK ACCESS'),
                      const SizedBox(height: 12),
                      const QuickAccessGrid(),
                      const SizedBox(height: 24),
                      // Featured history
                      if (state.featuredChapters.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionLabel(label: 'EXPLORE HISTORY'),
                            TextButton(
                              onPressed: () => context.go('/explore'),
                              child: Text(
                                'See all',
                                style: AppTextStyles.labelLarge(
                                  color:
                                      isDark
                                          ? AppColors.gold
                                          : AppColors.emerald,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...state.featuredChapters.map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: FeaturedChapterCard(chapter: c),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
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

class _HomeAppBar extends StatelessWidget {
  final bool isDark;
  final SettingsCubit settings;
  const _HomeAppBar({required this.isDark, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      elevation: 0,
      scrolledUnderElevation: 0,
      expandedHeight: 120,
      leading: Builder(
        builder:
            (ctx) => IconButton(
              tooltip: 'Navigation Menu',
              icon: Icon(
                Icons.menu_rounded,
                color: isDark ? AppColors.gold : AppColors.emerald,
              ),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRect(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 64, right: 20, top: 10),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  final name = authState.userName.trim();
                  final isGuest =
                      authState.isGuest ||
                      !authState.isLoggedIn ||
                      name.isEmpty;
                  final displayName = isGuest ? context.l10n.guest : name;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.assalamuAlaikum,
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.sageDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayName,
                        style: AppTextStyles.displayMedium(
                          color: isDark ? AppColors.gold : AppColors.emerald,
                        ).copyWith(fontSize: 26, height: 1.2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.sectionLabel(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.gold
                : AppColors.gold,
      ),
    );
  }
}

class _HomeShimmer extends StatefulWidget {
  const _HomeShimmer();

  @override
  State<_HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<_HomeShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _anim,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            _ShimmerBox(width: 120, height: 14, isDark: isDark),
            const SizedBox(height: 16),
            _ShimmerBox(width: double.infinity, height: 160, isDark: isDark),
            const SizedBox(height: 20),
            _ShimmerBox(width: 140, height: 14, isDark: isDark),
            const SizedBox(height: 16),
            _ShimmerBox(width: double.infinity, height: 120, isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final bool isDark;
  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.ivoryDark,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/quran_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../data/models/surah_model.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with TickerProviderStateMixin {
  late TabController _tabs;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder:
                (context, _) => [_QuranAppBar(isDark: isDark, tabs: _tabs)],
            body: TabBarView(
              controller: _tabs,
              children: [
                _SurahListTab(
                  surahs: state.surahs,
                  isLoading: state.isLoading,
                  isDark: isDark,
                ),
                _JuzListTab(isDark: isDark),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuranAppBar extends StatelessWidget {
  final bool isDark;
  final TabController tabs;
  const _QuranAppBar({required this.isDark, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      title: Text(
        context.l10n.quran,
        style: AppTextStyles.displaySmall(
          color: isDark ? AppColors.gold : AppColors.emerald,
        ),
      ),
      actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: Container(
          height: 42,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.ivoryDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: tabs,
            indicator: BoxDecoration(
              color: isDark ? AppColors.emeraldLight : AppColors.emerald,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: isDark ? AppColors.sage : AppColors.inkFaint,
            labelStyle: AppTextStyles.labelLarge().copyWith(fontSize: 13),
            tabs: [
              Tab(height: 38, text: context.l10n.surah),
              Tab(height: 38, text: context.l10n.juz),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurahListTab extends StatelessWidget {
  final List<SurahModel> surahs;
  final bool isLoading;
  final bool isDark;
  const _SurahListTab({
    required this.surahs,
    required this.isLoading,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.emerald),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: surahs.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder:
          (context, i) => _SurahListTile(surah: surahs[i], isDark: isDark),
    );
  }
}

class _SurahListTile extends StatelessWidget {
  final SurahModel surah;
  final bool isDark;
  const _SurahListTile({required this.surah, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/quran/surah/${surah.number}'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (isDark ? AppColors.emeraldLight : AppColors.emerald)
              .withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${surah.number}',
            style: AppTextStyles.labelLarge(
              color: isDark ? AppColors.gold : AppColors.emerald,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              surah.nameTransliteration,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLarge(
                color: isDark ? AppColors.ivory : AppColors.ink,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            surah.nameArabic,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18,
              color: isDark ? AppColors.arabicTextDark : AppColors.arabicText,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          '${surah.ayahCount} Ayahs',
          style: AppTextStyles.bodySmall(
            color: isDark ? AppColors.sage : AppColors.inkFaint,
          ),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: isDark ? AppColors.sage : AppColors.inkFaint,
      ),
    );
  }
}

class _JuzListTab extends StatelessWidget {
  final bool isDark;
  const _JuzListTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 30,
      itemBuilder: (context, i) {
        final juz = i + 1;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.ivory,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
            ),
          ),
          child: ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.emerald, AppColors.emeraldLight],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$juz',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              'Juz $juz',
              style: AppTextStyles.bodyLarge(
                color: isDark ? AppColors.ivory : AppColors.ink,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Pages ${(juz - 1) * 20 + 1}–${juz * 20}',
              style: AppTextStyles.bodySmall(
                color: isDark ? AppColors.sage : AppColors.inkFaint,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isDark ? AppColors.sage : AppColors.inkFaint,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/library_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';
import '../../../data/models/bookmark_model.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder:
                (context, _) => [
                  SliverAppBar(
                    floating: true,
                    backgroundColor:
                        isDark ? AppColors.darkBg : AppColors.parchment,
                    title: Text(
                      context.l10n.myLibrary,
                      style: AppTextStyles.displaySmall(
                        color: isDark ? AppColors.gold : AppColors.emerald,
                      ),
                    ),
                    actions: [
                      AppTopActions(isDark: isDark),
                      const SizedBox(width: 4),
                    ],
                  ),
                ],
            body: _BookmarksTab(
              bookmarks: state.bookmarks,
              isDark: isDark,
            ),
          );
        },
      ),
    );
  }
}

class _BookmarksTab extends StatelessWidget {
  final List<BookmarkModel> bookmarks;
  final bool isDark;

  const _BookmarksTab({
    required this.bookmarks,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) {
      return _EmptyState(
        icon: '🔖',
        title: 'No bookmarks yet',
        subtitle:
            'Bookmark ayahs, hadiths, and history chapters to access them here.',
        isDark: isDark,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookmarks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder:
          (context, i) => _BookmarkCard(
            bookmark: bookmarks[i],
            isDark: isDark,
            onDelete:
                () => context.read<LibraryCubit>().removeBookmark(
                  bookmarks[i].contentId,
                ),
          ),
    );
  }
}

class _BookmarkCard extends StatelessWidget {
  final BookmarkModel bookmark;
  final bool isDark;
  final VoidCallback onDelete;

  const _BookmarkCard({
    required this.bookmark,
    required this.isDark,
    required this.onDelete,
  });

  IconData _typeIcon(BookmarkType type) => switch (type) {
    BookmarkType.ayah => Icons.menu_book_rounded,
    BookmarkType.hadith => Icons.article_rounded,
    BookmarkType.dua => Icons.favorite_rounded,
    BookmarkType.historyChapter => Icons.history_edu_rounded,
    BookmarkType.passage => Icons.text_snippet_rounded,
  };

  Color _typeColor(BookmarkType type) => switch (type) {
    BookmarkType.ayah => AppColors.emerald,
    BookmarkType.hadith => const Color(0xFF1E5F74),
    BookmarkType.dua => const Color(0xFF8B0000),
    BookmarkType.historyChapter => AppColors.goldDark,
    BookmarkType.passage => AppColors.sageDark,
  };

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(bookmark.type);

    return Dismissible(
      key: ValueKey(bookmark.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.ivory,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_typeIcon(bookmark.type), color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookmark.title,
                    style: AppTextStyles.bodyLarge(
                      color: isDark ? AppColors.ivory : AppColors.ink,
                    ).copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (bookmark.arabicText != null)
                    Text(
                      bookmark.arabicText!,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 14,
                        color:
                            isDark
                                ? AppColors.arabicTextDark
                                : AppColors.arabicText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  Text(
                    bookmark.reference,
                    style: AppTextStyles.bodySmall(
                      color:
                          isDark
                              ? AppColors.gold.withValues(alpha: 0.7)
                              : AppColors.goldDark,
                    ),
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

class _EmptyState extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isDark;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.displaySmall(
                color: isDark ? AppColors.ivory : AppColors.ink,
              ).copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium(
                color: isDark ? AppColors.sage : AppColors.inkFaint,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

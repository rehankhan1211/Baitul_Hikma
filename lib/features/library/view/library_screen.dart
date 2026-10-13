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
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(52),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                        child: Row(
                          children: [
                            _TabButton(
                              label: context.l10n.bookmarks,
                              icon: Icons.bookmarks_rounded,
                              isActive:
                                  state.currentTab == LibraryTab.bookmarks,
                              isDark: isDark,
                              count: state.bookmarks.length,
                              onTap:
                                  () => context.read<LibraryCubit>().setTab(
                                    LibraryTab.bookmarks,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            _TabButton(
                              label: context.l10n.history,
                              icon: Icons.history_rounded,
                              isActive: state.currentTab == LibraryTab.history,
                              isDark: isDark,
                              count: state.readingHistory.length,
                              onTap:
                                  () => context.read<LibraryCubit>().setTab(
                                    LibraryTab.history,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  state.currentTab == LibraryTab.bookmarks
                      ? _BookmarksTab(
                        bookmarks: state.bookmarks,
                        isDark: isDark,
                        key: const ValueKey('bookmarks'),
                      )
                      : _HistoryTab(
                        history: state.readingHistory,
                        isDark: isDark,
                        key: const ValueKey('history'),
                      ),
            ),
          );
        },
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final bool isDark;
  final int count;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isDark,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:
              isActive
                  ? (isDark ? AppColors.emeraldLight : AppColors.emerald)
                  : (isDark ? AppColors.darkCard : AppColors.ivory),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isActive
                    ? (isDark ? AppColors.emeraldLight : AppColors.emerald)
                    : (isDark ? AppColors.darkDivider : AppColors.ivoryDark),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color:
                  isActive
                      ? Colors.white
                      : (isDark ? AppColors.sage : AppColors.inkFaint),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelLarge(
                color:
                    isActive
                        ? Colors.white
                        : (isDark ? AppColors.sage : AppColors.inkFaint),
              ).copyWith(fontSize: 13),
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      isActive
                          ? Colors.white.withValues(alpha: 0.25)
                          : AppColors.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : AppColors.goldDark,
                  ),
                ),
              ),
            ],
          ],
        ),
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
    super.key,
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

class _HistoryTab extends StatelessWidget {
  final List<Map<String, String>> history;
  final bool isDark;

  const _HistoryTab({required this.history, required this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return _EmptyState(
        icon: '📚',
        title: 'No reading history',
        subtitle: 'Your recently read content will appear here.',
        isDark: isDark,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final item = history[i];
        final date =
            item['date'] != null ? DateTime.tryParse(item['date']!) : null;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.emerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.history_edu_rounded,
              color: AppColors.emerald,
              size: 20,
            ),
          ),
          title: Text(
            item['title'] ?? '',
            style: AppTextStyles.bodyMedium(
              color: isDark ? AppColors.ivory : AppColors.ink,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle:
              date != null
                  ? Text(
                    _formatDate(date),
                    style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.sage : AppColors.inkFaint,
                    ),
                  )
                  : null,
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${d.day}/${d.month}/${d.year}';
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

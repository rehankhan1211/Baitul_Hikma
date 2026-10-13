import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../data/datasources/local/history_local_datasource.dart';
import '../../../data/models/history_chapter_model.dart';
import '../../../data/repositories/islamic_repository.dart';
import '../../../data/services/local_storage_service.dart';
import '../../library/bloc/library_cubit.dart';
import '../../../data/models/bookmark_model.dart';
import '../../../app/di.dart';

class HistoryReaderScreen extends StatefulWidget {
  final String chapterId;
  const HistoryReaderScreen({super.key, required this.chapterId});

  @override
  State<HistoryReaderScreen> createState() => _HistoryReaderScreenState();
}

class _HistoryReaderScreenState extends State<HistoryReaderScreen> {
  final _scrollCtrl = ScrollController();
  final _readingProgressNotifier = ValueNotifier<double>(0.0);
  HistoryChapter? _chapter;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    final repo = di<IslamicRepository>();
    _chapter = repo.getChapterById(widget.chapterId);
    final storage = di<LocalStorageService>();
    _isBookmarked = storage.isBookmarked(widget.chapterId);

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.hasClients && _scrollCtrl.position.maxScrollExtent > 0) {
        final progress = (_scrollCtrl.offset /
                _scrollCtrl.position.maxScrollExtent)
            .clamp(0.0, 1.0);
        if (_readingProgressNotifier.value != progress) {
          _readingProgressNotifier.value = progress;
        }
      }
    });

    if (_chapter != null) {
      di<LocalStorageService>().recordReading(
        type: 'history',
        id: widget.chapterId,
        title: _chapter!.title,
      );
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _readingProgressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chapter = _chapter;

    if (chapter == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Chapter not found')),
      );
    }

    final eraColor = _eraColor(chapter.era);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      body: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: _readingProgressNotifier,
            builder:
                (context, progress, _) => LinearProgressIndicator(
                  value: progress,
                  backgroundColor:
                      isDark ? AppColors.darkDivider : AppColors.ivoryDark,
                  color: eraColor,
                  minHeight: 3,
                ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollCtrl,
              physics: const BouncingScrollPhysics(),
              slivers: [
                _ReaderAppBar(
                  chapter: chapter,
                  eraColor: eraColor,
                  isDark: isDark,
                  isBookmarked: _isBookmarked,
                  onBookmark: _toggleBookmark,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          chapter.introduction,
                          style: AppTextStyles.bodyLarge(
                            color:
                                isDark
                                    ? AppColors.ivoryDark
                                    : AppColors.inkLight,
                          ).copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.8,
                            fontSize: 15,
                          ),
                        ),
                        if (chapter.keyFigures.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _InfoPanel(
                            title: 'KEY FIGURES',
                            items: chapter.keyFigures,
                            isDark: isDark,
                            color: eraColor,
                          ),
                        ],
                        if (chapter.keyEvents.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _InfoPanel(
                            title: 'KEY EVENTS',
                            items: chapter.keyEvents,
                            isDark: isDark,
                            color: AppColors.gold,
                          ),
                        ],
                        const SizedBox(height: 32),
                        ...chapter.sections.asMap().entries.map(
                          (entry) => _SectionContent(
                            section: entry.value,
                            index: entry.key + 1,
                            isDark: isDark,
                            eraColor: eraColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _ChapterNavigation(chapter: chapter, isDark: isDark),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleBookmark() {
    final chapter = _chapter;
    if (chapter == null) return;

    final lib = di<LibraryCubit>();
    if (_isBookmarked) {
      lib.removeBookmark(widget.chapterId);
    } else {
      lib.addBookmark(
        BookmarkModel(
          id: 'history-${widget.chapterId}',
          type: BookmarkType.historyChapter,
          title: chapter.title,
          subtitle: chapter.subtitle,
          reference: chapter.eraLabel,
          contentId: widget.chapterId,
          savedAt: DateTime.now(),
        ),
      );
    }
    setState(() => _isBookmarked = !_isBookmarked);
  }

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
}

class _ReaderAppBar extends StatelessWidget {
  final HistoryChapter chapter;
  final Color eraColor;
  final bool isDark;
  final bool isBookmarked;
  final VoidCallback onBookmark;

  const _ReaderAppBar({
    required this.chapter,
    required this.eraColor,
    required this.isDark,
    required this.isBookmarked,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      foregroundColor: Colors.white,
      actions: [
        AppTopActions(isDark: isDark, color: Colors.white),
        IconButton(
          icon: Icon(
            isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: Colors.white,
          ),
          onPressed: onBookmark,
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [eraColor, eraColor.withValues(alpha: 0.6)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${chapter.eraLabel.toUpperCase()} • ${chapter.period}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    chapter.title,
                    style: AppTextStyles.displayMedium(
                      color: Colors.white,
                    ).copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chapter.subtitle,
                    style: AppTextStyles.bodyMedium(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: Colors.white60,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${chapter.readingTimeMinutes} min read',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool isDark;
  final Color color;

  const _InfoPanel({
    required this.title,
    required this.items,
    required this.isDark,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.1 : 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.sectionLabel(color: color)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children:
                items
                    .map(
                      (item) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: color.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          item,
                          style: AppTextStyles.bodySmall(
                            color: isDark ? AppColors.ivory : AppColors.ink,
                          ).copyWith(fontSize: 12),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _SectionContent extends StatelessWidget {
  final HistorySection section;
  final int index;
  final bool isDark;
  final Color eraColor;

  const _SectionContent({
    required this.section,
    required this.index,
    required this.isDark,
    required this.eraColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: eraColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  section.heading,
                  style: AppTextStyles.chapterTitle(
                    color: isDark ? AppColors.ivory : AppColors.emerald,
                  ).copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (section.pullQuote != null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: eraColor, width: 4)),
              ),
              child: Text(
                section.pullQuote!,
                style: AppTextStyles.displaySmall(
                  color: isDark ? AppColors.gold : eraColor,
                ).copyWith(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                ),
              ),
            ),
          ],
          ...section.content
              .split('\n\n')
              .map(
                (para) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    para.trim(),
                    style: AppTextStyles.bodyLarge(
                      color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                    ).copyWith(height: 1.85, fontSize: 15),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _ChapterNavigation extends StatelessWidget {
  final HistoryChapter chapter;
  final bool isDark;

  const _ChapterNavigation({required this.chapter, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final allChapters = List<HistoryChapter>.from(
      HistoryLocalDataSource.chapters,
    )..sort((a, b) => a.order.compareTo(b.order));
    final idx = allChapters.indexWhere((c) => c.id == chapter.id);
    final prev = idx > 0 ? allChapters[idx - 1] : null;
    final next = idx < allChapters.length - 1 ? allChapters[idx + 1] : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
        ),
      ),
      child: Row(
        children: [
          if (prev != null)
            Expanded(
              child: GestureDetector(
                onTap:
                    () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => HistoryReaderScreen(chapterId: prev.id),
                      ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '← Previous',
                      style: AppTextStyles.labelMedium(color: AppColors.gold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prev.title,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          if (prev != null && next != null)
            Container(
              width: 1,
              height: 40,
              color: AppColors.darkDivider,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
          if (next != null)
            Expanded(
              child: GestureDetector(
                onTap:
                    () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => HistoryReaderScreen(chapterId: next.id),
                      ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Next →',
                      style: AppTextStyles.labelMedium(color: AppColors.gold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      next.title,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

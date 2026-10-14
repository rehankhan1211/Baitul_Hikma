import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../library/bloc/library_cubit.dart';

class ReadingHistoryScreen extends StatelessWidget {
  const ReadingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: isDark ? AppColors.gold : AppColors.emerald,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Reading History',
          style: AppTextStyles.displaySmall(
            color: isDark ? AppColors.gold : AppColors.emerald,
          ),
        ),
        actions: [
          AppTopActions(isDark: isDark),
          const SizedBox(width: 4),
        ],
      ),
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          final history = state.readingHistory;
          if (history.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('📚', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 16),
                    Text(
                      'No reading history',
                      style: AppTextStyles.displaySmall(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ).copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your recently read content will appear here.',
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

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
            ),
            itemBuilder: (context, i) {
              final item = history[i];
              final date =
                  item['date'] != null ? DateTime.tryParse(item['date']!) : null;
              final type = item['type'] ?? '';
              final id = item['id'] ?? '';

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _iconForType(type),
                    color: isDark ? AppColors.gold : AppColors.emerald,
                    size: 20,
                  ),
                ),
                title: Text(
                  item['title'] ?? '',
                  style: AppTextStyles.bodyMedium(
                    color: isDark ? AppColors.ivory : AppColors.ink,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
                subtitle: date != null
                    ? Text(
                        _formatDate(date),
                        style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.sage : AppColors.inkFaint,
                        ),
                      )
                    : null,
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: isDark ? AppColors.sage : AppColors.inkFaint,
                ),
                onTap: () {
                  if (type == 'surah' && id.isNotEmpty) {
                    context.push('/quran/surah/$id');
                  } else if (type == 'history' && id.isNotEmpty) {
                    context.push('/history/$id');
                  } else if (type == 'hadith') {
                    context.go(AppRoutes.hadith);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'surah':
      case 'ayah':
        return Icons.menu_book_rounded;
      case 'hadith':
        return Icons.library_books_rounded;
      case 'history':
      default:
        return Icons.history_edu_rounded;
    }
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

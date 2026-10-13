import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/localization/app_strings.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  List<_QuickItem> _getItems(BuildContext context) => [
    _QuickItem(
      label: context.l10n.quran,
      iconAsset: AppIcons.quran,
      path: '/quran',
      color: const Color(0xFF203D31),
    ),
    _QuickItem(
      label: context.l10n.hadith,
      iconAsset: AppIcons.hadith,
      path: '/hadith',
      color: const Color(0xFF1E5F74),
    ),
    _QuickItem(
      label: 'Duas',
      iconAsset: AppIcons.duas,
      path: '/explore',
      color: const Color(0xFF8B0000),
    ),
    _QuickItem(
      label: context.l10n.history,
      iconAsset: AppIcons.history,
      path: '/explore',
      color: const Color(0xFF7A5C3E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context);
    return Row(
      children:
          items
              .map(
                (item) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: item == items.last ? 0 : 10,
                    ),
                    child: _QuickAccessItem(item: item),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _QuickItem {
  final String label;
  final String iconAsset;
  final String path;
  final Color color;
  const _QuickItem({
    required this.label,
    required this.iconAsset,
    required this.path,
    required this.color,
  });
}

class _QuickAccessItem extends StatefulWidget {
  final _QuickItem item;
  const _QuickAccessItem({required this.item});

  @override
  State<_QuickAccessItem> createState() => _QuickAccessItemState();
}

class _QuickAccessItemState extends State<_QuickAccessItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        context.go(widget.item.path);
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            color: widget.item.color.withValues(alpha: isDark ? 0.22 : 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.item.color.withValues(alpha: isDark ? 0.35 : 0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.item.iconAsset,
                  height: 48,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.item.label,
                style: AppTextStyles.labelLarge(
                  color: isDark ? AppColors.ivory : widget.item.color,
                ).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

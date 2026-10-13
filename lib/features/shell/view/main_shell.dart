import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/constants/app_icons.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  List<_NavItem> _getTabs(BuildContext context) => [
    _NavItem(
      label: context.l10n.home,
      iconAsset: AppIcons.navHome,
      path: '/home',
    ),
    _NavItem(
      label: context.l10n.read,
      iconAsset: AppIcons.navRead,
      path: '/quran',
    ),
    _NavItem(
      label: context.l10n.explore,
      iconAsset: AppIcons.navExplore,
      path: '/explore',
    ),
    _NavItem(
      label: context.l10n.library,
      iconAsset: AppIcons.navLibrary,
      path: '/library',
    ),
  ];

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/quran') || loc.startsWith('/hadith')) return 1;
    if (loc.startsWith('/explore') || loc.startsWith('/history')) return 2;
    if (loc.startsWith('/library')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final idx = _currentIndex(context);
    final tabs = _getTabs(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: _BaitulHikmaNavBar(
        currentIndex: idx,
        isDark: isDark,
        onTap: (i) => context.go(tabs[i].path),
        tabs: tabs,
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String iconAsset;
  final String path;
  const _NavItem({
    required this.label,
    required this.iconAsset,
    required this.path,
  });
}

class _BaitulHikmaNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final void Function(int) onTap;
  final List<_NavItem> tabs;

  const _BaitulHikmaNavBar({
    required this.currentIndex,
    required this.isDark,
    required this.onTap,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? AppColors.darkSurface : AppColors.ivory;
    final border = isDark ? AppColors.darkDivider : AppColors.ivoryDark;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) {
              final isActive = i == currentIndex;
              return _NavBarItem(
                item: tabs[i],
                isActive: isActive,
                isDark: isDark,
                onTap: () => onTap(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.88,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.isDark ? AppColors.gold : AppColors.emerald;
    final inactive = widget.isDark ? AppColors.sageDark : AppColors.inkFaint;

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color:
                widget.isActive
                    ? active.withValues(alpha: widget.isDark ? 0.22 : 0.12)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  widget.isActive
                      ? active.withValues(alpha: 0.35)
                      : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Opacity(
                  key: ValueKey(widget.isActive),
                  opacity: widget.isActive ? 1.0 : 0.55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      widget.item.iconAsset,
                      width: 26,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.item.label,
                style: AppTextStyles.labelMedium(
                  color: widget.isActive ? active : inactive,
                ).copyWith(
                  fontSize: 10,
                  letterSpacing: 0.2,
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_icons.dart';

class StreakCard extends StatelessWidget {
  final int streak;
  const StreakCard({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [
                    AppColors.goldDark.withValues(alpha: 0.3),
                    AppColors.gold.withValues(alpha: 0.15),
                  ]
                  : [
                    AppColors.gold.withValues(alpha: 0.12),
                    AppColors.goldLight.withValues(alpha: 0.06),
                  ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          _AnimatedFlame(streak: streak),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$streak Day Streak',
                  style: AppTextStyles.displaySmall(
                    color: isDark ? AppColors.goldLight : AppColors.goldDark,
                  ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  streak == 1
                      ? 'You started your reading journey!'
                      : 'Keep your knowledge growing daily 🌱',
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
          // Mini progress dots
          Row(
            children: List.generate(7, (i) {
              final filled = i < (streak % 7 == 0 ? 7 : streak % 7);
              return Container(
                margin: const EdgeInsets.only(left: 3),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      filled
                          ? AppColors.gold
                          : AppColors.gold.withValues(alpha: 0.2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _AnimatedFlame extends StatefulWidget {
  final int streak;
  const _AnimatedFlame({required this.streak});

  @override
  State<_AnimatedFlame> createState() => _AnimatedFlameState();
}

class _AnimatedFlameState extends State<_AnimatedFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 44,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(AppIcons.streak, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/surah_model.dart';

class DailyAyahCard extends StatelessWidget {
  final AyahModel ayah;
  const DailyAyahCard({super.key, required this.ayah});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isDark
                  ? [AppColors.darkCard, AppColors.emeraldDeep]
                  : [AppColors.emerald, AppColors.emeraldLight],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative geometric pattern
          Positioned(
            right: -20,
            top: -20,
            child: _GeometricDecoration(isDark: isDark),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        'Surah Al-Fatihah ${ayah.surahNumber}:${ayah.ayahNumber}',
                        style: AppTextStyles.labelMedium(
                          color: AppColors.gold,
                        ).copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  ayah.arabicText,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 26,
                    color: Colors.white,
                    height: 2.0,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
                const SizedBox(height: 12),
                Text(
                  ayah.translation,
                  style: AppTextStyles.bodyMedium(
                    color: Colors.white70,
                  ).copyWith(fontStyle: FontStyle.italic, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GeometricDecoration extends StatelessWidget {
  final bool isDark;
  const _GeometricDecoration({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.08,
      child: SizedBox(
        width: 120,
        height: 120,
        child: CustomPaint(painter: _GeometricPainter()),
      ),
    );
  }
}

class _GeometricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, i * 14.0, paint);
    }
    // 8-pointed star
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final angle = i * 3.14159 / 4;
      final r = i.isEven ? size.width / 2 : size.width / 3.5;
      final x = center.dx + r * (i == 0 ? 0 : 1) * _cos(angle);
      final y = center.dy + r * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _cos(double angle) => angle == 0 ? 1.0 : _approxCos(angle);
  double _sin(double angle) => _approxSin(angle);

  double _approxCos(double a) {
    final normalized = a % (2 * 3.14159);
    if (normalized < 3.14159 / 2) return 1 - normalized * normalized / 2;
    if (normalized < 3.14159) return -(normalized - 3.14159).abs();
    return -(2 - normalized / 3.14159).abs();
  }

  double _approxSin(double a) => _approxCos(a - 3.14159 / 2);

  @override
  bool shouldRepaint(_GeometricPainter oldDelegate) => false;
}

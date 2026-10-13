import 'package:flutter/material.dart';

/// The official Baitul Hikma logo widget using the official asset:
/// `assets/icons/Baitul Hikmah Logo.png`
class BaitulHikmaLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final double size;
  final bool isDark;
  final bool wrapWithCardInDark;

  // Backward-compatible constructor parameters
  const BaitulHikmaLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.size = 120,
    bool showText = true,
    bool showSubtitle = true,
    Color? primaryColor,
    Color? accentColor,
    Color? textColor,
    this.isDark = false,
    this.wrapWithCardInDark = true,
  });

  static const String assetPath = 'assets/icons/Baitul Hikmah Logo.png';

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? (size * 1.8);
    final effectiveHeight = height ?? size;

    // Scaled cache dimensions to prevent decoding 1.2MB high-res PNG into massive uncompressed bitmaps
    final targetCacheWidth = (effectiveWidth * 2.0).round().clamp(100, 800);
    final targetCacheHeight = (effectiveHeight * 2.0).round().clamp(60, 600);

    final imageWidget = Image.asset(
      assetPath,
      width: effectiveWidth,
      height: effectiveHeight,
      fit: fit,
      cacheWidth: targetCacheWidth,
      cacheHeight: targetCacheHeight,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: const Center(child: Icon(Icons.menu_book_rounded, size: 48)),
        );
      },
    );

    if (isDark && wrapWithCardInDark) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

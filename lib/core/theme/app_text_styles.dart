import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Cached base font instances to eliminate runtime GoogleFonts lookup overhead during scroll builds
  static final TextStyle _cormorantBase = GoogleFonts.cormorantGaramond();
  static final TextStyle _interBase = GoogleFonts.inter();

  // --- Arabic ---
  static TextStyle arabicDisplay({Color? color, double? fontSize}) => TextStyle(
    fontFamily: 'Amiri',
    fontSize: fontSize ?? 32,
    color: color ?? AppColors.arabicText,
    height: 1.9,
    letterSpacing: 0.5,
  );

  static TextStyle arabicBody({Color? color, double? fontSize}) => TextStyle(
    fontFamily: 'Amiri',
    fontSize: fontSize ?? 22,
    color: color ?? AppColors.arabicText,
    height: 2.0,
  );

  static TextStyle arabicSmall({Color? color, double? fontSize}) => TextStyle(
    fontFamily: 'Amiri',
    fontSize: fontSize ?? 18,
    color: color ?? AppColors.arabicText,
    height: 2.0,
  );

  // --- Display (Cormorant Garamond cached) ---
  static final TextStyle _displayLargeBase = _cormorantBase.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    height: 1.2,
    letterSpacing: -0.5,
  );
  static TextStyle displayLarge({Color? color}) =>
      color == null
          ? _displayLargeBase
          : _displayLargeBase.copyWith(color: color);

  static final TextStyle _displayMediumBase = _cormorantBase.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    height: 1.3,
  );
  static TextStyle displayMedium({Color? color}) =>
      color == null
          ? _displayMediumBase
          : _displayMediumBase.copyWith(color: color);

  static final TextStyle _displaySmallBase = _cormorantBase.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    height: 1.4,
  );
  static TextStyle displaySmall({Color? color}) =>
      color == null
          ? _displaySmallBase
          : _displaySmallBase.copyWith(color: color);

  // --- Body (Inter cached) ---
  static final TextStyle _bodyLargeBase = _interBase.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.inkLight,
    height: 1.65,
  );
  static TextStyle bodyLarge({Color? color}) =>
      color == null ? _bodyLargeBase : _bodyLargeBase.copyWith(color: color);

  static final TextStyle _bodyMediumBase = _interBase.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.inkLight,
    height: 1.6,
  );
  static TextStyle bodyMedium({Color? color}) =>
      color == null ? _bodyMediumBase : _bodyMediumBase.copyWith(color: color);

  static final TextStyle _bodySmallBase = _interBase.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.inkFaint,
    height: 1.5,
  );
  static TextStyle bodySmall({Color? color}) =>
      color == null ? _bodySmallBase : _bodySmallBase.copyWith(color: color);

  // --- Labels ---
  static final TextStyle _labelLargeBase = _interBase.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.inkLight,
    letterSpacing: 0.3,
  );
  static TextStyle labelLarge({Color? color}) =>
      color == null ? _labelLargeBase : _labelLargeBase.copyWith(color: color);

  static final TextStyle _labelMediumBase = _interBase.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.inkFaint,
    letterSpacing: 1.0,
  );
  static TextStyle labelMedium({Color? color}) =>
      color == null
          ? _labelMediumBase
          : _labelMediumBase.copyWith(color: color);

  // --- Chapter Heading ---
  static final TextStyle _chapterTitleBase = _cormorantBase.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.emerald,
    height: 1.3,
    fontStyle: FontStyle.italic,
  );
  static TextStyle chapterTitle({Color? color}) =>
      color == null
          ? _chapterTitleBase
          : _chapterTitleBase.copyWith(color: color);

  // --- Section ---
  static final TextStyle _sectionLabelBase = _interBase.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
    letterSpacing: 1.8,
  );
  static TextStyle sectionLabel({Color? color}) =>
      color == null
          ? _sectionLabelBase
          : _sectionLabelBase.copyWith(color: color);
}

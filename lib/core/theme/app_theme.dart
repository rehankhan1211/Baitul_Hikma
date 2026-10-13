import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.emerald,
        secondary: AppColors.gold,
        tertiary: AppColors.sage,
        surface: AppColors.parchment,
        error: AppColors.error,
        onPrimary: AppColors.ivory,
        onSecondary: AppColors.ink,
        onSurface: AppColors.ink,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.parchment,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.parchment,
        foregroundColor: AppColors.emerald,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.emerald.withValues(alpha: 0.1),
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.emerald,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(color: AppColors.emerald),
      ),
      cardTheme: CardTheme(
        color: AppColors.ivory,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.ivoryDark, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.ivoryDark,
        thickness: 1,
        space: 1,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        headlineLarge: GoogleFonts.cormorantGaramond(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.emerald,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.inkLight,
          height: 1.65,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.inkLight,
          height: 1.6,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.inkFaint,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.emerald,
          foregroundColor: AppColors.ivory,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.emerald,
          side: const BorderSide(color: AppColors.emerald, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: AppColors.emerald),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.ivoryDark,
        selectedColor: AppColors.emerald,
        labelStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.inkLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.ivory,
        selectedItemColor: AppColors.emerald,
        unselectedItemColor: AppColors.inkFaint,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.emerald,
        linearTrackColor: AppColors.ivoryDark,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) =>
              s.contains(WidgetState.selected)
                  ? AppColors.emerald
                  : AppColors.ivoryDark,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) =>
              s.contains(WidgetState.selected)
                  ? AppColors.emeraldLight
                  : AppColors.parchmentDark,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.sage,
        tertiary: AppColors.emeraldLight,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: AppColors.darkBg,
        onSecondary: AppColors.ivory,
        onSurface: AppColors.ivory,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.darkBg,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.ivory,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: Colors.black26,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.ivory,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.ivory),
      ),
      cardTheme: CardTheme(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkDivider, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
        space: 1,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: AppColors.ivory,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.ivory,
        ),
        headlineLarge: GoogleFonts.cormorantGaramond(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.gold,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.ivory,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.ivoryDark,
          height: 1.65,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.ivoryDark,
          height: 1.6,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.sage,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.darkBg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkCard,
        selectedColor: AppColors.emeraldLight,
        labelStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.ivory),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.darkDivider),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.sageDark,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.gold,
        linearTrackColor: AppColors.darkCard,
      ),
    );
  }
}

class AppConstants {
  AppConstants._();

  static const String appName = 'Baitul Hikma';
  static const String appSubtitle = 'House of Wisdom';
  static const String appTagline = 'House of Wisdom';

  // Reading
  static const double minFontSize = 12.0;
  static const double maxFontSize = 28.0;
  static const double defaultFontSize = 16.0;
  static const double arabicMinFontSize = 18.0;
  static const double arabicMaxFontSize = 36.0;
  static const double arabicDefaultFontSize = 24.0;

  // Streak
  static const int streakGoalDays = 30;

  // Keys
  static const String prefsThemeKey = 'theme_mode';
  static const String prefsFontSizeKey = 'font_size';
  static const String prefsArabicFontSizeKey = 'arabic_font_size';
  static const String prefsStreakKey = 'reading_streak';
  static const String prefsLastOpenedKey = 'last_opened_date';
  static const String prefsBookmarksKey = 'bookmarks';
  static const String prefsReadingHistoryKey = 'reading_history';

  // Animation durations
  static const Duration fastAnim = Duration(milliseconds: 200);
  static const Duration normalAnim = Duration(milliseconds: 350);
  static const Duration slowAnim = Duration(milliseconds: 600);
  static const Duration pageAnim = Duration(milliseconds: 400);
}

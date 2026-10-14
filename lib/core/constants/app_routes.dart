// Route names used with GoRouter
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String shell = '/';
  static const String home = '/home';
  static const String read = '/read';
  static const String explore = '/explore';
  static const String library = '/library';

  // Sub-routes
  static const String quran = '/quran';
  static const String surahDetail = '/quran/surah/:id';
  static const String hadith = '/hadith';
  static const String hadithCollection = '/hadith/:collectionId';
  static const String duas = '/duas';
  static const String duaCategory = '/duas/:categoryId';
  static const String historyChapter = '/history/:chapterId';
  static const String audioPlayer = '/audio';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String about = '/about';
  static const String readingHistory = '/reading-history';
  static const String bookReader = '/book-reader/:type/:id';
  static const String search = '/search';
}

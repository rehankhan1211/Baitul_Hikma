import '../datasources/local/islamic_local_datasource.dart';
import '../datasources/local/history_local_datasource.dart';
import '../models/surah_model.dart';
import '../models/hadith_model.dart';
import '../models/dua_model.dart';
import '../models/history_chapter_model.dart';

abstract class IslamicRepository {
  List<SurahModel> getAllSurahs();
  List<AyahModel> getAyahs(int surahNumber);
  List<HadithCollection> getHadithCollections();
  List<HadithModel> getFeaturedHadiths();
  List<HadithModel> getHadithsByCollection(String collectionId);
  List<DuaCategory> getDuaCategories();
  List<DuaModel> getFeaturedDuas();
  List<DuaModel> getDuasByCategory(String categoryId);
  List<HistoryChapter> getAllChapters();
  HistoryChapter? getChapterById(String id);
  List<TimelineEvent> getTimelineEvents();
  DuaModel? getDailyDua();
  HadithModel? getDailyHadith();
  AyahModel? getDailyAyah();
}

class IslamicRepositoryImpl implements IslamicRepository {
  @override
  List<SurahModel> getAllSurahs() => IslamicLocalDataSource.surahs;

  @override
  List<AyahModel> getAyahs(int surahNumber) {
    if (surahNumber == 1) return IslamicLocalDataSource.alfatihahAyahs;
    return [];
  }

  @override
  List<HadithCollection> getHadithCollections() =>
      IslamicLocalDataSource.collections;

  @override
  List<HadithModel> getFeaturedHadiths() =>
      IslamicLocalDataSource.featuredHadiths;

  @override
  List<HadithModel> getHadithsByCollection(String collectionId) =>
      IslamicLocalDataSource.featuredHadiths
          .where((h) => h.collectionId == collectionId)
          .toList();

  @override
  List<DuaCategory> getDuaCategories() => IslamicLocalDataSource.duaCategories;

  @override
  List<DuaModel> getFeaturedDuas() => IslamicLocalDataSource.featuredDuas;

  @override
  List<DuaModel> getDuasByCategory(String categoryId) =>
      IslamicLocalDataSource.featuredDuas
          .where((d) => d.categoryId == categoryId)
          .toList();

  @override
  List<HistoryChapter> getAllChapters() =>
      List<HistoryChapter>.from(HistoryLocalDataSource.chapters)
        ..sort((a, b) => a.order.compareTo(b.order));

  @override
  HistoryChapter? getChapterById(String id) {
    try {
      return HistoryLocalDataSource.chapters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  List<TimelineEvent> getTimelineEvents() =>
      HistoryLocalDataSource.timelineEvents;

  @override
  DuaModel? getDailyDua() {
    final all = IslamicLocalDataSource.featuredDuas;
    if (all.isEmpty) return null;
    final idx = DateTime.now().day % all.length;
    return all[idx];
  }

  @override
  HadithModel? getDailyHadith() {
    final all = IslamicLocalDataSource.featuredHadiths;
    if (all.isEmpty) return null;
    final idx = DateTime.now().day % all.length;
    return all[idx];
  }

  @override
  AyahModel? getDailyAyah() {
    final all = IslamicLocalDataSource.alfatihahAyahs;
    if (all.isEmpty) return null;
    final idx = DateTime.now().day % all.length;
    return all[idx];
  }
}

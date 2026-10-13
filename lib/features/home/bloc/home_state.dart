part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final AyahModel? dailyAyah;
  final HadithModel? dailyHadith;
  final DuaModel? dailyDua;
  final List<HistoryChapter> featuredChapters;
  final int streak;
  final List<Map<String, String>> recentHistory;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.dailyAyah,
    this.dailyHadith,
    this.dailyDua,
    this.featuredChapters = const [],
    this.streak = 0,
    this.recentHistory = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    AyahModel? dailyAyah,
    HadithModel? dailyHadith,
    DuaModel? dailyDua,
    List<HistoryChapter>? featuredChapters,
    int? streak,
    List<Map<String, String>>? recentHistory,
    String? errorMessage,
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    dailyAyah: dailyAyah ?? this.dailyAyah,
    dailyHadith: dailyHadith ?? this.dailyHadith,
    dailyDua: dailyDua ?? this.dailyDua,
    featuredChapters: featuredChapters ?? this.featuredChapters,
    streak: streak ?? this.streak,
    recentHistory: recentHistory ?? this.recentHistory,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    isLoading,
    dailyAyah,
    dailyHadith,
    dailyDua,
    featuredChapters,
    streak,
    recentHistory,
    errorMessage,
  ];
}

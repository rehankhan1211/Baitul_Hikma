part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final bool isLoading;
  final bool isLoadingAyahs;
  final List<SurahModel> surahs;
  final List<AyahModel> currentAyahs;
  final SurahModel? selectedSurah;
  final double arabicFontSize;
  final bool showTranslation;
  final bool showTafseer;
  final String? revelationFilter;

  const QuranState({
    this.isLoading = false,
    this.isLoadingAyahs = false,
    this.surahs = const [],
    this.currentAyahs = const [],
    this.selectedSurah,
    this.arabicFontSize = 24.0,
    this.showTranslation = true,
    this.showTafseer = false,
    this.revelationFilter,
  });

  QuranState copyWith({
    bool? isLoading,
    bool? isLoadingAyahs,
    List<SurahModel>? surahs,
    List<AyahModel>? currentAyahs,
    SurahModel? selectedSurah,
    double? arabicFontSize,
    bool? showTranslation,
    bool? showTafseer,
    String? revelationFilter,
    bool clearFilter = false,
  }) => QuranState(
    isLoading: isLoading ?? this.isLoading,
    isLoadingAyahs: isLoadingAyahs ?? this.isLoadingAyahs,
    surahs: surahs ?? this.surahs,
    currentAyahs: currentAyahs ?? this.currentAyahs,
    selectedSurah: selectedSurah ?? this.selectedSurah,
    arabicFontSize: arabicFontSize ?? this.arabicFontSize,
    showTranslation: showTranslation ?? this.showTranslation,
    showTafseer: showTafseer ?? this.showTafseer,
    revelationFilter:
        clearFilter ? null : (revelationFilter ?? this.revelationFilter),
  );

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingAyahs,
    surahs,
    currentAyahs,
    selectedSurah,
    arabicFontSize,
    showTranslation,
    showTafseer,
    revelationFilter,
  ];
}

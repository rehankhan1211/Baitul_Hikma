import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/surah_model.dart';
import '../../../data/repositories/islamic_repository.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final IslamicRepository repository;

  QuranCubit({required this.repository}) : super(const QuranState());

  void loadSurahs() {
    emit(state.copyWith(isLoading: true));
    final surahs = repository.getAllSurahs();
    emit(state.copyWith(isLoading: false, surahs: surahs));
  }

  void loadAyahs(int surahNumber) {
    emit(state.copyWith(isLoadingAyahs: true));
    final ayahs = repository.getAyahs(surahNumber);
    emit(state.copyWith(isLoadingAyahs: false, currentAyahs: ayahs));
  }

  void selectSurah(SurahModel surah) {
    emit(state.copyWith(selectedSurah: surah));
    loadAyahs(surah.number);
  }

  void updateFontSize(double size) =>
      emit(state.copyWith(arabicFontSize: size));

  void toggleTranslation() =>
      emit(state.copyWith(showTranslation: !state.showTranslation));

  void toggleTafseer() => emit(state.copyWith(showTafseer: !state.showTafseer));

  void filterByRevelation(String? type) =>
      emit(state.copyWith(revelationFilter: type, clearFilter: type == null));

  List<SurahModel> get filteredSurahs {
    if (state.revelationFilter == null) return state.surahs;
    return state.surahs
        .where(
          (s) =>
              s.revelationType.toLowerCase() ==
              state.revelationFilter!.toLowerCase(),
        )
        .toList();
  }
}

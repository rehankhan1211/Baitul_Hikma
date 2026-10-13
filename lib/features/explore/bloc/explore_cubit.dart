import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/history_chapter_model.dart';
import '../../../data/repositories/islamic_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final IslamicRepository repository;

  ExploreCubit({required this.repository}) : super(const ExploreState());

  void load() {
    emit(state.copyWith(isLoading: true));
    final chapters = repository.getAllChapters();
    final timeline = repository.getTimelineEvents();
    emit(
      state.copyWith(isLoading: false, chapters: chapters, timeline: timeline),
    );
  }

  void selectEra(Era? era) =>
      emit(state.copyWith(selectedEra: era, clearEra: era == null));

  void setView(ExploreView view) => emit(state.copyWith(currentView: view));

  List<HistoryChapter> get filteredChapters {
    if (state.selectedEra == null) return state.chapters;
    return state.chapters.where((c) => c.era == state.selectedEra).toList();
  }
}

enum ExploreView { shelf, timeline }

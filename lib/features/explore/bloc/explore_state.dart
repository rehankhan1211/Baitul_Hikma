part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  final bool isLoading;
  final List<HistoryChapter> chapters;
  final List<TimelineEvent> timeline;
  final Era? selectedEra;
  final ExploreView currentView;

  const ExploreState({
    this.isLoading = false,
    this.chapters = const [],
    this.timeline = const [],
    this.selectedEra,
    this.currentView = ExploreView.shelf,
  });

  ExploreState copyWith({
    bool? isLoading,
    List<HistoryChapter>? chapters,
    List<TimelineEvent>? timeline,
    Era? selectedEra,
    ExploreView? currentView,
    bool clearEra = false,
  }) => ExploreState(
    isLoading: isLoading ?? this.isLoading,
    chapters: chapters ?? this.chapters,
    timeline: timeline ?? this.timeline,
    selectedEra: clearEra ? null : (selectedEra ?? this.selectedEra),
    currentView: currentView ?? this.currentView,
  );

  @override
  List<Object?> get props => [
    isLoading,
    chapters,
    timeline,
    selectedEra,
    currentView,
  ];
}

part of 'hadith_cubit.dart';

class HadithState extends Equatable {
  final bool isLoading;
  final List<HadithCollection> collections;
  final List<HadithModel> featured;
  final List<HadithModel> currentHadiths;
  final HadithCollection? selectedCollection;

  const HadithState({
    this.isLoading = false,
    this.collections = const [],
    this.featured = const [],
    this.currentHadiths = const [],
    this.selectedCollection,
  });

  HadithState copyWith({
    bool? isLoading,
    List<HadithCollection>? collections,
    List<HadithModel>? featured,
    List<HadithModel>? currentHadiths,
    HadithCollection? selectedCollection,
  }) => HadithState(
    isLoading: isLoading ?? this.isLoading,
    collections: collections ?? this.collections,
    featured: featured ?? this.featured,
    currentHadiths: currentHadiths ?? this.currentHadiths,
    selectedCollection: selectedCollection ?? this.selectedCollection,
  );

  @override
  List<Object?> get props => [
    isLoading,
    collections,
    featured,
    currentHadiths,
    selectedCollection,
  ];
}

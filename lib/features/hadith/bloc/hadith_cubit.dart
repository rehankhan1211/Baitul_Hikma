import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/hadith_model.dart';
import '../../../data/repositories/islamic_repository.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  final IslamicRepository repository;

  HadithCubit({required this.repository}) : super(const HadithState());

  void load() {
    emit(state.copyWith(isLoading: true));
    final collections = repository.getHadithCollections();
    final featured = repository.getFeaturedHadiths();
    emit(
      state.copyWith(
        isLoading: false,
        collections: collections,
        featured: featured,
      ),
    );
  }

  void selectCollection(HadithCollection collection) {
    final hadiths = repository.getHadithsByCollection(collection.id);
    emit(
      state.copyWith(selectedCollection: collection, currentHadiths: hadiths),
    );
  }
}

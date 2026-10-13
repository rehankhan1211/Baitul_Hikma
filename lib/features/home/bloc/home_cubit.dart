import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/surah_model.dart';
import '../../../data/models/hadith_model.dart';
import '../../../data/models/dua_model.dart';
import '../../../data/models/history_chapter_model.dart';
import '../../../data/repositories/islamic_repository.dart';
import '../../../data/services/local_storage_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IslamicRepository repository;
  final LocalStorageService storage;

  HomeCubit({required this.repository, required this.storage})
    : super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    await storage.updateStreak();

    final dailyAyah = repository.getDailyAyah();
    final dailyHadith = repository.getDailyHadith();
    final dailyDua = repository.getDailyDua();
    final featuredChapters = repository.getAllChapters().take(3).toList();
    final streak = storage.readingStreak;
    final history = storage.readingHistory.take(5).toList();

    emit(
      state.copyWith(
        isLoading: false,
        dailyAyah: dailyAyah,
        dailyHadith: dailyHadith,
        dailyDua: dailyDua,
        featuredChapters: featuredChapters,
        streak: streak,
        recentHistory: history,
      ),
    );
  }
}

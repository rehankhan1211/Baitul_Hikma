import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repositories/islamic_repository.dart';
import '../data/services/local_storage_service.dart';
import '../features/home/bloc/home_cubit.dart';
import '../features/quran/bloc/quran_cubit.dart';
import '../features/hadith/bloc/hadith_cubit.dart';
import '../features/explore/bloc/explore_cubit.dart';
import '../features/library/bloc/library_cubit.dart';
import '../features/settings/bloc/settings_cubit.dart';
import '../features/auth/bloc/auth_cubit.dart';

final GetIt di = GetIt.instance;

Future<void> setupDi() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(prefs);

  // Services
  di.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(di<SharedPreferences>()),
  );

  // Repositories
  di.registerLazySingleton<IslamicRepository>(() => IslamicRepositoryImpl());

  // Cubits (factory — new instance per route)
  di.registerFactory<HomeCubit>(
    () => HomeCubit(
      repository: di<IslamicRepository>(),
      storage: di<LocalStorageService>(),
    ),
  );
  di.registerFactory<QuranCubit>(
    () => QuranCubit(repository: di<IslamicRepository>()),
  );
  di.registerFactory<HadithCubit>(
    () => HadithCubit(repository: di<IslamicRepository>()),
  );
  di.registerFactory<ExploreCubit>(
    () => ExploreCubit(repository: di<IslamicRepository>()),
  );
  di.registerFactory<LibraryCubit>(
    () => LibraryCubit(storage: di<LocalStorageService>()),
  );

  // Settings Cubit (singleton — app-wide state)
  di.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(storage: di<LocalStorageService>()),
  );

  // Auth Cubit (singleton — app-wide state)
  di.registerLazySingleton<AuthCubit>(
    () => AuthCubit(storage: di<LocalStorageService>()),
  );
}

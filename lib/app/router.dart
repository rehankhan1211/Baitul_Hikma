import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/home/view/home_screen.dart';
import '../features/quran/view/quran_screen.dart';
import '../features/quran/view/surah_detail_screen.dart';
import '../features/hadith/view/hadith_screen.dart';
import '../features/explore/view/explore_screen.dart';
import '../features/library/view/library_screen.dart';
import '../features/history/view/history_reader_screen.dart';
import '../features/settings/view/settings_screen.dart';
import '../features/profile/view/profile_screen.dart';
import '../features/about/view/about_screen.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/auth/view/login_screen.dart';
import '../features/auth/view/register_screen.dart';
import '../features/shell/view/main_shell.dart';
import '../features/home/bloc/home_cubit.dart';
import '../features/quran/bloc/quran_cubit.dart';
import '../features/hadith/bloc/hadith_cubit.dart';
import '../features/explore/bloc/explore_cubit.dart';
import '../features/library/bloc/library_cubit.dart';
import 'di.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/splash',
  routes: [
    // Splash screen (fullscreen, 3s duration with pure white background)
    GoRoute(
      path: '/splash',
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) => _buildPage(state, const SplashScreen()),
    ),
    // Auth screens (fullscreen)
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) => _buildPage(state, const LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      parentNavigatorKey: _rootKey,
      pageBuilder:
          (context, state) => _buildPage(state, const RegisterScreen()),
    ),
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder:
              (context, state) => _buildPage(
                state,
                BlocProvider(
                  create: (_) => di<HomeCubit>()..load(),
                  child: const HomeScreen(),
                ),
              ),
        ),
        GoRoute(
          path: '/quran',
          pageBuilder:
              (context, state) => _buildPage(
                state,
                BlocProvider(
                  create: (_) => di<QuranCubit>()..loadSurahs(),
                  child: const QuranScreen(),
                ),
              ),
          routes: [
            GoRoute(
              path: 'surah/:id',
              parentNavigatorKey: _rootKey,
              pageBuilder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
                return _buildPage(
                  state,
                  BlocProvider(
                    create:
                        (_) =>
                            di<QuranCubit>()
                              ..loadSurahs()
                              ..loadAyahs(id),
                    child: SurahDetailScreen(surahNumber: id),
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/hadith',
          pageBuilder:
              (context, state) => _buildPage(
                state,
                BlocProvider(
                  create: (_) => di<HadithCubit>()..load(),
                  child: const HadithScreen(),
                ),
              ),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder:
              (context, state) => _buildPage(
                state,
                BlocProvider(
                  create: (_) => di<ExploreCubit>()..load(),
                  child: const ExploreScreen(),
                ),
              ),
        ),
        GoRoute(
          path: '/library',
          pageBuilder:
              (context, state) => _buildPage(
                state,
                BlocProvider(
                  create: (_) => di<LibraryCubit>()..load(),
                  child: const LibraryScreen(),
                ),
              ),
        ),
      ],
    ),
    // Full-screen routes (outside shell)
    GoRoute(
      path: '/history/:chapterId',
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        final chapterId = state.pathParameters['chapterId'] ?? '';
        return _buildPage(state, HistoryReaderScreen(chapterId: chapterId));
      },
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootKey,
      pageBuilder:
          (context, state) => _buildPage(state, const SettingsScreen()),
    ),
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) => _buildPage(state, const ProfileScreen()),
    ),
    GoRoute(
      path: '/about',
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) => _buildPage(state, const AboutScreen()),
    ),
  ],
);

CustomTransitionPage<void> _buildPage(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          ),
    );

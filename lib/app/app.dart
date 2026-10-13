import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/localization/app_language.dart';
import '../core/theme/app_theme.dart';
import '../features/settings/bloc/settings_cubit.dart';
import '../features/auth/bloc/auth_cubit.dart';
import 'di.dart';
import 'router.dart';

class BaitulHikmaApp extends StatelessWidget {
  const BaitulHikmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<SettingsCubit>()),
        BlocProvider.value(value: di<AuthCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
          return MaterialApp.router(
            title: 'Baitul Hikma',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale:
                DevicePreview.locale(context) ??
                Locale(settings.languageCode),
            builder: DevicePreview.appBuilder,
            supportedLocales: AppLanguage.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}

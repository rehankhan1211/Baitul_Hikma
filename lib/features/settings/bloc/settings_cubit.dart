import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/local_storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LocalStorageService storage;

  SettingsCubit({required this.storage})
    : super(
        SettingsState(
          themeMode: _toFlutterTheme(storage.themeMode),
          languageCode: storage.languageCode,
          bodyFontSize: storage.bodyFontSize,
          arabicFontSize: storage.arabicFontSize,
          lineSpacing: storage.lineSpacing,
          dailyReminder: storage.dailyReminder,
          reminderTime: storage.reminderTime,
        ),
      );

  Future<void> setTheme(ThemeMode mode) async {
    await storage.setThemeMode(_toStorageTheme(mode));
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setLanguage(String code) async {
    await storage.setLanguageCode(code);
    emit(state.copyWith(languageCode: code));
  }

  Future<void> setBodyFontSize(double size) async {
    await storage.setBodyFontSize(size);
    emit(state.copyWith(bodyFontSize: size));
  }

  Future<void> setArabicFontSize(double size) async {
    await storage.setArabicFontSize(size);
    emit(state.copyWith(arabicFontSize: size));
  }

  Future<void> setLineSpacing(double spacing) async {
    await storage.setLineSpacing(spacing);
    emit(state.copyWith(lineSpacing: spacing));
  }

  Future<void> setDailyReminder(bool enabled) async {
    await storage.setDailyReminder(enabled);
    emit(state.copyWith(dailyReminder: enabled));
  }

  Future<void> setReminderTime(String time) async {
    await storage.setReminderTime(time);
    emit(state.copyWith(reminderTime: time));
  }

  Future<void> clearReadingHistory() async {
    await storage.clearReadingHistory();
  }

  Future<void> resetPreferences() async {
    await storage.resetAllPreferences();
    emit(const SettingsState());
  }

  static ThemeMode _toFlutterTheme(StorageThemeMode m) => switch (m) {
    StorageThemeMode.light => ThemeMode.light,
    StorageThemeMode.dark => ThemeMode.dark,
    StorageThemeMode.system => ThemeMode.system,
  };

  static StorageThemeMode _toStorageTheme(ThemeMode m) => switch (m) {
    ThemeMode.light => StorageThemeMode.light,
    ThemeMode.dark => StorageThemeMode.dark,
    ThemeMode.system => StorageThemeMode.system,
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baitul_hikma/data/services/local_storage_service.dart';
import 'package:baitul_hikma/features/settings/bloc/settings_cubit.dart';

void main() {
  group('SettingsCubit Tests', () {
    late LocalStorageService storage;
    late SettingsCubit cubit;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      storage = LocalStorageService(prefs);
      cubit = SettingsCubit(storage: storage);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state defaults to dark theme on fresh installation', () {
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      expect(storage.themeMode, equals(StorageThemeMode.dark));
      expect(cubit.state.bodyFontSize, equals(16.0));
      expect(cubit.state.arabicFontSize, equals(24.0));
      expect(cubit.state.languageCode, equals('en'));
    });

    test('setTheme updates state and persists when user changes it', () async {
      await cubit.setTheme(ThemeMode.light);
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      expect(storage.themeMode, equals(StorageThemeMode.light));

      await cubit.setTheme(ThemeMode.dark);
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      expect(storage.themeMode, equals(StorageThemeMode.dark));
    });

    test('setLanguage updates state and persists', () async {
      await cubit.setLanguage('ar');
      expect(cubit.state.languageCode, equals('ar'));
      expect(storage.languageCode, equals('ar'));
    });
  });
}

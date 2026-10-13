import 'package:flutter/material.dart';

class AppLanguage {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final TextDirection direction;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    this.direction = TextDirection.ltr,
  });

  bool get isRtl => direction == TextDirection.rtl;
  Locale get locale => Locale(code);

  static const List<AppLanguage> supportedLanguages = [
    AppLanguage(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇬🇧',
      direction: TextDirection.ltr,
    ),
    AppLanguage(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇸🇦',
      direction: TextDirection.rtl,
    ),
    AppLanguage(
      code: 'ur',
      name: 'Urdu',
      nativeName: 'اردو',
      flag: '🇵🇰',
      direction: TextDirection.rtl,
    ),
    AppLanguage(
      code: 'id',
      name: 'Indonesian',
      nativeName: 'Bahasa Indonesia',
      flag: '🇮🇩',
      direction: TextDirection.ltr,
    ),
    AppLanguage(
      code: 'tr',
      name: 'Turkish',
      nativeName: 'Türkçe',
      flag: '🇹🇷',
      direction: TextDirection.ltr,
    ),
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('ur'),
    Locale('id'),
    Locale('tr'),
  ];

  static AppLanguage fromCode(String code) {
    return supportedLanguages.firstWhere(
      (l) => l.code == code,
      orElse: () => supportedLanguages.first,
    );
  }
}

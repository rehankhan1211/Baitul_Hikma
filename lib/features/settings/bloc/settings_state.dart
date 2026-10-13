part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final String languageCode;
  final double bodyFontSize;
  final double arabicFontSize;
  final double lineSpacing;
  final bool dailyReminder;
  final String reminderTime;

  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.languageCode = 'en',
    this.bodyFontSize = 16.0,
    this.arabicFontSize = 24.0,
    this.lineSpacing = 1.6,
    this.dailyReminder = false,
    this.reminderTime = '07:00 AM',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    double? bodyFontSize,
    double? arabicFontSize,
    double? lineSpacing,
    bool? dailyReminder,
    String? reminderTime,
  }) => SettingsState(
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode ?? this.languageCode,
    bodyFontSize: bodyFontSize ?? this.bodyFontSize,
    arabicFontSize: arabicFontSize ?? this.arabicFontSize,
    lineSpacing: lineSpacing ?? this.lineSpacing,
    dailyReminder: dailyReminder ?? this.dailyReminder,
    reminderTime: reminderTime ?? this.reminderTime,
  );

  @override
  List<Object?> get props => [
    themeMode,
    languageCode,
    bodyFontSize,
    arabicFontSize,
    lineSpacing,
    dailyReminder,
    reminderTime,
  ];
}

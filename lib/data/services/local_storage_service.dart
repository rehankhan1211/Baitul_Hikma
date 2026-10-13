import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark_model.dart';

enum StorageThemeMode { system, light, dark }

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // ── Theme ──
  StorageThemeMode get themeMode {
    final val = _prefs.getString('theme_mode') ?? 'dark';
    return StorageThemeMode.values.firstWhere(
      (e) => e.name == val,
      orElse: () => StorageThemeMode.dark,
    );
  }

  Future<void> setThemeMode(StorageThemeMode mode) =>
      _prefs.setString('theme_mode', mode.name);

  // ── Language ──
  String get languageCode => _prefs.getString('language_code') ?? 'en';
  Future<void> setLanguageCode(String code) =>
      _prefs.setString('language_code', code);

  // ── Font sizes ──
  double get bodyFontSize => _prefs.getDouble('font_size') ?? 16.0;
  Future<void> setBodyFontSize(double size) =>
      _prefs.setDouble('font_size', size);

  double get arabicFontSize => _prefs.getDouble('arabic_font_size') ?? 24.0;
  Future<void> setArabicFontSize(double size) =>
      _prefs.setDouble('arabic_font_size', size);

  double get lineSpacing => _prefs.getDouble('line_spacing') ?? 1.6;
  Future<void> setLineSpacing(double spacing) =>
      _prefs.setDouble('line_spacing', spacing);

  // ── Notifications ──
  bool get dailyReminder => _prefs.getBool('daily_reminder') ?? false;
  Future<void> setDailyReminder(bool enabled) =>
      _prefs.setBool('daily_reminder', enabled);

  String get reminderTime => _prefs.getString('reminder_time') ?? '07:00 AM';
  Future<void> setReminderTime(String time) =>
      _prefs.setString('reminder_time', time);

  // ── Reading streak ──
  int get readingStreak => _prefs.getInt('reading_streak') ?? 0;

  Future<void> updateStreak() async {
    final lastOpenedStr = _prefs.getString('last_opened_date');
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    if (lastOpenedStr == todayStr) return;

    int streak = readingStreak;
    if (lastOpenedStr != null) {
      final last = DateTime.parse(lastOpenedStr);
      final diff = today.difference(last).inDays;
      if (diff == 1) {
        streak++;
      } else if (diff > 1) {
        streak = 1;
      }
    } else {
      streak = 1;
    }

    await _prefs.setInt('reading_streak', streak);
    await _prefs.setString('last_opened_date', todayStr);
  }

  // ── Bookmarks ──
  List<BookmarkModel> get bookmarks {
    final json = _prefs.getStringList('bookmarks') ?? [];
    return json
        .map(
          (s) => BookmarkModel.fromJson(jsonDecode(s) as Map<String, dynamic>),
        )
        .toList()
      ..sort((a, b) => b.savedAt.compareTo(a.savedAt));
  }

  Future<void> addBookmark(BookmarkModel bookmark) async {
    final existing = bookmarks;
    final isDuplicate = existing.any((b) => b.contentId == bookmark.contentId);
    if (isDuplicate) return;
    final updated = [...existing, bookmark];
    await _prefs.setStringList(
      'bookmarks',
      updated.map((b) => jsonEncode(b.toJson())).toList(),
    );
  }

  Future<void> removeBookmark(String contentId) async {
    final updated = bookmarks.where((b) => b.contentId != contentId).toList();
    await _prefs.setStringList(
      'bookmarks',
      updated.map((b) => jsonEncode(b.toJson())).toList(),
    );
  }

  bool isBookmarked(String contentId) =>
      bookmarks.any((b) => b.contentId == contentId);

  // ── Reading history ──
  List<Map<String, String>> get readingHistory {
    final json = _prefs.getStringList('reading_history') ?? [];
    return json
        .map((s) => Map<String, String>.from(jsonDecode(s) as Map))
        .toList();
  }

  Future<void> recordReading({
    required String type,
    required String id,
    required String title,
  }) async {
    final history = readingHistory;
    history.removeWhere((e) => e['id'] == id);
    history.insert(0, {
      'type': type,
      'id': id,
      'title': title,
      'date': DateTime.now().toIso8601String(),
    });
    final trimmed = history.take(50).toList();
    await _prefs.setStringList(
      'reading_history',
      trimmed.map((e) => jsonEncode(e)).toList(),
    );
  }

  Future<void> clearReadingHistory() => _prefs.remove('reading_history');

  Future<void> resetAllPreferences() async {
    await _prefs.remove('theme_mode');
    await _prefs.remove('font_size');
    await _prefs.remove('arabic_font_size');
    await _prefs.remove('line_spacing');
    await _prefs.remove('daily_reminder');
    await _prefs.remove('reminder_time');
  }

  // ── Authentication ──
  bool get isLoggedIn => _prefs.getBool('is_logged_in') ?? false;
  String? get currentUserName => _prefs.getString('user_name');
  String? get currentUserEmail => _prefs.getString('user_email');
  bool get isGuest => _prefs.getBool('is_guest') ?? false;

  Future<void> saveUser({
    required String name,
    required String email,
    bool isGuest = false,
  }) async {
    await _prefs.setBool('is_logged_in', true);
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
    await _prefs.setBool('is_guest', isGuest);
  }

  Future<void> logout() async {
    await _prefs.setBool('is_logged_in', false);
    await _prefs.remove('user_name');
    await _prefs.remove('user_email');
    await _prefs.remove('is_guest');
  }
}

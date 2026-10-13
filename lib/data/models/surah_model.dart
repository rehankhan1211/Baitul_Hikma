import 'package:equatable/equatable.dart';

class SurahModel extends Equatable {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String nameTransliteration;
  final String revelationType; // 'meccan' | 'medinan'
  final int ayahCount;
  final String juz;

  const SurahModel({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameTransliteration,
    required this.revelationType,
    required this.ayahCount,
    required this.juz,
  });

  bool get isMeccan => revelationType.toLowerCase() == 'meccan';

  @override
  List<Object?> get props => [number, nameArabic, nameEnglish];
}

class AyahModel extends Equatable {
  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String translation;
  final String? tafseer;
  final String? audioUrl;

  const AyahModel({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
    this.tafseer,
    this.audioUrl,
  });

  @override
  List<Object?> get props => [surahNumber, ayahNumber];
}

import 'package:equatable/equatable.dart';

class DuaCategory extends Equatable {
  final String id;
  final String nameEnglish;
  final String nameArabic;
  final String icon;
  final int duaCount;

  const DuaCategory({
    required this.id,
    required this.nameEnglish,
    required this.nameArabic,
    required this.icon,
    required this.duaCount,
  });

  @override
  List<Object?> get props => [id];
}

class DuaModel extends Equatable {
  final String id;
  final String categoryId;
  final String titleEnglish;
  final String arabicText;
  final String transliteration;
  final String translationEnglish;
  final String? reference;
  final String? occasion;
  final String? audioUrl;

  const DuaModel({
    required this.id,
    required this.categoryId,
    required this.titleEnglish,
    required this.arabicText,
    required this.transliteration,
    required this.translationEnglish,
    this.reference,
    this.occasion,
    this.audioUrl,
  });

  @override
  List<Object?> get props => [id];
}

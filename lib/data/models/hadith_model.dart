import 'package:equatable/equatable.dart';

class HadithCollection extends Equatable {
  final String id;
  final String nameEnglish;
  final String nameArabic;
  final String author;
  final int totalHadiths;
  final String description;
  final String coverColor; // hex string

  const HadithCollection({
    required this.id,
    required this.nameEnglish,
    required this.nameArabic,
    required this.author,
    required this.totalHadiths,
    required this.description,
    required this.coverColor,
  });

  @override
  List<Object?> get props => [id];
}

class HadithModel extends Equatable {
  final String id;
  final String collectionId;
  final int number;
  final String arabicText;
  final String englishText;
  final String narrator;
  final String? grade; // Sahih, Hasan, etc.
  final String? reference;
  final String? topic;

  const HadithModel({
    required this.id,
    required this.collectionId,
    required this.number,
    required this.arabicText,
    required this.englishText,
    required this.narrator,
    this.grade,
    this.reference,
    this.topic,
  });

  @override
  List<Object?> get props => [id, collectionId, number];
}

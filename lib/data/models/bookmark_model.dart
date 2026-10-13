import 'package:equatable/equatable.dart';

enum BookmarkType { ayah, hadith, dua, historyChapter, passage }

class BookmarkModel extends Equatable {
  final String id;
  final BookmarkType type;
  final String title;
  final String? subtitle;
  final String? arabicText;
  final String reference;
  final String contentId;
  final DateTime savedAt;
  final String? note;

  const BookmarkModel({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    this.arabicText,
    required this.reference,
    required this.contentId,
    required this.savedAt,
    this.note,
  });

  BookmarkModel copyWith({String? note}) => BookmarkModel(
    id: id,
    type: type,
    title: title,
    subtitle: subtitle,
    arabicText: arabicText,
    reference: reference,
    contentId: contentId,
    savedAt: savedAt,
    note: note ?? this.note,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'subtitle': subtitle,
    'arabicText': arabicText,
    'reference': reference,
    'contentId': contentId,
    'savedAt': savedAt.toIso8601String(),
    'note': note,
  };

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    id: json['id'] as String,
    type: BookmarkType.values.byName(json['type'] as String),
    title: json['title'] as String,
    subtitle: json['subtitle'] as String?,
    arabicText: json['arabicText'] as String?,
    reference: json['reference'] as String,
    contentId: json['contentId'] as String,
    savedAt: DateTime.parse(json['savedAt'] as String),
    note: json['note'] as String?,
  );

  @override
  List<Object?> get props => [id, type, contentId];
}

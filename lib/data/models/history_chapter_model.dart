import 'package:equatable/equatable.dart';

enum Era {
  preIslamic,
  propheticMecca,
  propheticMadina,
  khulafaRashideen,
  umayyad,
  abbasid,
  scholars,
  lateIslamic,
}

class HistoryChapter extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final Era era;
  final String eraLabel;
  final String period; // e.g. "570–632 CE"
  final String introduction;
  final List<HistorySection> sections;
  final List<String> keyFigures;
  final List<String> keyEvents;
  final String? audioNarrationUrl;
  final int readingTimeMinutes;
  final int order;

  const HistoryChapter({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.era,
    required this.eraLabel,
    required this.period,
    required this.introduction,
    required this.sections,
    required this.keyFigures,
    required this.keyEvents,
    this.audioNarrationUrl,
    required this.readingTimeMinutes,
    required this.order,
  });

  int get totalWords =>
      sections.fold(0, (sum, s) => sum + s.content.split(' ').length);

  @override
  List<Object?> get props => [id];
}

class HistorySection extends Equatable {
  final String heading;
  final String content;
  final String? imageCaption;
  final String? pullQuote;

  const HistorySection({
    required this.heading,
    required this.content,
    this.imageCaption,
    this.pullQuote,
  });

  @override
  List<Object?> get props => [heading];
}

class TimelineEvent extends Equatable {
  final String year; // e.g. "570 CE" or "Before Islam"
  final String event;
  final String? detail;
  final Era era;

  const TimelineEvent({
    required this.year,
    required this.event,
    this.detail,
    required this.era,
  });

  @override
  List<Object?> get props => [year, event];
}

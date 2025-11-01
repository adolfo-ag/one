import 'package:flutter/material.dart';

@immutable
class StoryDefinition {
  const StoryDefinition({
    required this.id,
    required this.titleEs,
    required this.titleEn,
    required this.summaryEs,
    required this.summaryEn,
    required this.coverColor,
    required this.readingTimeMinutes,
    required this.paragraphs,
    required this.focusWordsEs,
    required this.focusWordsEn,
  });

  final String id;
  final String titleEs;
  final String titleEn;
  final String summaryEs;
  final String summaryEn;
  final Color coverColor;
  final int readingTimeMinutes;
  final List<BilingualParagraph> paragraphs;
  final List<String> focusWordsEs;
  final List<String> focusWordsEn;
}

@immutable
class BilingualParagraph {
  const BilingualParagraph({
    required this.spanish,
    required this.english,
  });

  final String spanish;
  final String english;
}

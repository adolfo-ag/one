import 'package:flutter/widgets.dart';

enum LessonFocus { phonics, sightWords, story }

enum LessonStepType {
  soundMatch,
  blending,
  syllablePuzzle,
  minimalPairs,
  sightWord,
  speedChallenge,
  story,
  comprehension,
}

@immutable
class LessonDefinition {
  const LessonDefinition({
    required this.id,
    required this.title,
    required this.focus,
    required this.steps,
  });

  final String id;
  final String title;
  final LessonFocus focus;
  final List<LessonStep> steps;
}

@immutable
class LessonStep {
  const LessonStep._({
    required this.type,
    this.locale,
    this.grapheme,
    this.phoneme,
    this.sampleWords,
    this.syllables,
    this.targetWord,
    this.tiles,
    this.pairs,
    this.word,
    this.contextSentence,
    this.words,
    this.storyId,
    this.prompt,
    this.options,
    this.correctIndex,
  });

  factory LessonStep.soundMatch({
    required Locale locale,
    required String grapheme,
    required String phoneme,
    required List<String> sampleWords,
  }) {
    return LessonStep._(
      type: LessonStepType.soundMatch,
      locale: locale,
      grapheme: grapheme,
      phoneme: phoneme,
      sampleWords: sampleWords,
    );
  }

  factory LessonStep.blending({
    required Locale locale,
    required List<String> syllables,
  }) {
    return LessonStep._(
      type: LessonStepType.blending,
      locale: locale,
      syllables: syllables,
    );
  }

  factory LessonStep.syllablePuzzle({
    required Locale locale,
    required String targetWord,
    required List<String> tiles,
  }) {
    return LessonStep._(
      type: LessonStepType.syllablePuzzle,
      locale: locale,
      targetWord: targetWord,
      tiles: tiles,
    );
  }

  factory LessonStep.minimalPairs({
    required Locale locale,
    required List<MinimalPair> pairs,
  }) {
    return LessonStep._(
      type: LessonStepType.minimalPairs,
      locale: locale,
      pairs: pairs,
    );
  }

  factory LessonStep.sightWord({
    required Locale locale,
    required String word,
    required String contextSentence,
  }) {
    return LessonStep._(
      type: LessonStepType.sightWord,
      locale: locale,
      word: word,
      contextSentence: contextSentence,
    );
  }

  factory LessonStep.speedChallenge({
    required Locale locale,
    required List<String> words,
  }) {
    return LessonStep._(
      type: LessonStepType.speedChallenge,
      locale: locale,
      words: words,
    );
  }

  factory LessonStep.story({
    required String storyId,
  }) {
    return LessonStep._(
      type: LessonStepType.story,
      storyId: storyId,
    );
  }

  factory LessonStep.comprehension({
    required Locale locale,
    required String prompt,
    required List<String> options,
    required int correctIndex,
  }) {
    return LessonStep._(
      type: LessonStepType.comprehension,
      locale: locale,
      prompt: prompt,
      options: options,
      correctIndex: correctIndex,
    );
  }

  final LessonStepType type;
  final Locale? locale;
  final String? grapheme;
  final String? phoneme;
  final List<String>? sampleWords;
  final List<String>? syllables;
  final String? targetWord;
  final List<String>? tiles;
  final List<MinimalPair>? pairs;
  final String? word;
  final String? contextSentence;
  final List<String>? words;
  final String? storyId;
  final String? prompt;
  final List<String>? options;
  final int? correctIndex;
}

@immutable
class MinimalPair {
  const MinimalPair({
    required this.first,
    required this.second,
  });

  final String first;
  final String second;
}

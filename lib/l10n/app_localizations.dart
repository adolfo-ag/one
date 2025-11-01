import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;
  late final Map<String, dynamic> _values;

  static const supportedLocales = [Locale('es'), Locale('en')];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<void> load() async {
    final code = locale.languageCode;
    final data = await rootBundle
        .loadString('assets/translations/app_${code.toLowerCase()}.json');
    final Map<String, dynamic> decoded = json.decode(data);
    _values = decoded;
  }

  String _applyParams(String template, Map<String, String>? params) {
    if (params == null || params.isEmpty) {
      return template;
    }
    return params.entries.fold(template, (value, entry) {
      return value.replaceAll('{${entry.key}}', entry.value);
    });
  }

  String translate(String key, {Map<String, String>? params}) {
    final value = _values[key];
    if (value is String) {
      return _applyParams(value, params);
    }
    if (value is Map<String, dynamic>) {
      final variant = value[locale.languageCode] ??
          value['default'] ??
          (value.values.isNotEmpty ? value.values.first : key);
      return _applyParams(variant.toString(), params);
    }
    return key;
  }

  String stepText(
    String key,
    Locale stepLocale, {
    Map<String, String>? params,
  }) {
    final value = _values[key];
    if (value is Map<String, dynamic>) {
      final code = stepLocale.languageCode;
      final variant = value[code] ?? value[locale.languageCode];
      if (variant != null) {
        return _applyParams(variant.toString(), params);
      }
      if (value.values.isNotEmpty) {
        return _applyParams(value.values.first.toString(), params);
      }
    }
    if (value is String) {
      return _applyParams(value, params);
    }
    return key;
  }

  String get appTitle => translate('app_title');
  String get errorRouteNotFound => translate('error_route_not_found');
  String get lessonsTitle => translate('lessons_title');
  String get lessonsEmpty => translate('lessons_empty');
  String get lessonsChange => translate('lessons_change');
  String get commonNext => translate('common_action_next');
  String get commonFinish => translate('common_action_finish');
  String get commonKeepPlaying => translate('common_action_keep_playing');
  String get commonCheck => translate('common_action_check');
  String get commonRetryMessage => translate('common_retry_message');
  String get worldMapTitle => translate('world_map_title');
  String get storyLibraryTitle => translate('story_library_title');

  String homeGreeting(String name) =>
      translate('home_greeting', params: {'name': name});
  String homeContinueWorld(String world) =>
      translate('home_continue_world', params: {'world': world});
  String get homeButtonWorldMap => translate('home_button_world_map');
  String get homeButtonLibrary => translate('home_button_library');
  String homeBadgesLabel(int count) =>
      translate('home_badges_label', params: {'count': '$count'});
  String homeWordsLabel(int count) =>
      translate('home_words_label', params: {'count': '$count'});

  String worldLessonsLabel(int count) =>
      translate('world_card_lessons', params: {'count': '$count'});
  String get worldLockedLabel => translate('world_card_locked');

  String rewardLessonComplete(String lessonTitle) => translate(
        'reward_lesson_complete',
        params: {'lesson': lessonTitle},
      );

  String storyReadingTime(int minutes) => translate(
        'story_reading_time',
        params: {'minutes': '$minutes'},
      );
  String storyFocusWords(String words) =>
      translate('story_focus_words', params: {'words': words});

  String stepSoundMatch(Locale locale, String grapheme) => stepText(
        'sound_match_prompt',
        locale,
        params: {'grapheme': grapheme},
      );
  String stepBlending(Locale locale) =>
      stepText('blending_prompt', locale);
  String stepBlendingListen(Locale locale) =>
      stepText('blending_listen_button', locale);
  String stepSyllablePrompt(Locale locale, String word) => stepText(
        'syllable_prompt',
        locale,
        params: {'word': word},
      );
  String stepMinimalPairs(Locale locale) =>
      stepText('minimal_pairs_prompt', locale);
  String stepSightWordTitle(Locale locale) =>
      stepText('sight_word_title', locale);
  String stepSightWordAction(Locale locale) =>
      stepText('sight_word_action', locale);
  String stepSpeedPrompt(Locale locale) =>
      stepText('speed_prompt', locale);
  String stepSpeedStart(Locale locale) =>
      stepText('speed_start', locale);
  String stepSpeedReward(Locale locale) =>
      stepText('speed_reward', locale);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((element) => element.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

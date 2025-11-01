import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/lesson.dart';
import '../../models/story.dart';

final worldCatalogProvider = Provider<List<WorldDefinition>>((ref) {
  return const [
    WorldDefinition(
      id: 'world_1',
      name: 'Granja de Sonidos',
      icon: Icons.pets,
      color: Color(0xFF81C784),
      lessonCount: 5,
    ),
    WorldDefinition(
      id: 'world_2',
      name: 'Bosque de Palabras',
      icon: Icons.eco,
      color: Color(0xFF4DB6AC),
      lessonCount: 5,
    ),
    WorldDefinition(
      id: 'world_3',
      name: 'Ciudad de Historias',
      icon: Icons.apartment,
      color: Color(0xFF64B5F6),
      lessonCount: 5,
    ),
  ];
});

final lessonCatalogProvider = Provider<Map<String, List<LessonDefinition>>>((ref) {
  return {
    'world_1': [
      LessonDefinition(
        id: 's1_l1',
        title: 'Sonido M / Vocal A',
        focus: LessonFocus.phonics,
        steps: [
          LessonStep.soundMatch(
            locale: const Locale('es'),
            grapheme: 'M',
            phoneme: 'm',
            sampleWords: ['mamá', 'mesa', 'mano'],
          ),
          LessonStep.soundMatch(
            locale: const Locale('en'),
            grapheme: 'M',
            phoneme: 'm',
            sampleWords: ['moon', 'map', 'milk'],
          ),
          LessonStep.blending(
            locale: const Locale('es'),
            syllables: ['ma', 'me', 'mi'],
          ),
        ],
      ),
      LessonDefinition(
        id: 's1_l2',
        title: 'Sílabas abiertas',
        focus: LessonFocus.phonics,
        steps: [
          LessonStep.syllablePuzzle(
            locale: const Locale('es'),
            targetWord: 'sapo',
            tiles: ['sa', 'po'],
          ),
          LessonStep.minimalPairs(
            locale: const Locale('en'),
            pairs: [
              MinimalPair(first: 'bat', second: 'bet'),
              MinimalPair(first: 'cat', second: 'cut'),
            ],
          ),
        ],
      ),
    ],
    'world_2': [
      LessonDefinition(
        id: 's2_l1',
        title: 'Palabras mágicas 1',
        focus: LessonFocus.sightWords,
        steps: [
          LessonStep.sightWord(
            locale: const Locale('es'),
            word: 'yo',
            contextSentence: 'Yo veo un gato.',
          ),
          LessonStep.sightWord(
            locale: const Locale('en'),
            word: 'the',
            contextSentence: 'The cat sleeps.',
          ),
        ],
      ),
      LessonDefinition(
        id: 's2_l2',
        title: 'Reto de velocidad',
        focus: LessonFocus.sightWords,
        steps: [
          LessonStep.speedChallenge(
            locale: const Locale('es'),
            words: ['el', 'la', 'que', 'con'],
          ),
          LessonStep.speedChallenge(
            locale: const Locale('en'),
            words: ['and', 'you', 'said', 'are'],
          ),
        ],
      ),
    ],
    'world_3': [
      LessonDefinition(
        id: 's3_l1',
        title: 'Historia bilingüe',
        focus: LessonFocus.story,
        steps: [
          LessonStep.story(
            storyId: 'story_001',
          ),
          LessonStep.comprehension(
            locale: const Locale('es'),
            prompt: '¿Qué animal encontró Luna?',
            options: ['Un perro', 'Un gato', 'Un pez'],
            correctIndex: 1,
          ),
        ],
      ),
    ],
  };
});

final storyCatalogProvider = Provider<List<StoryDefinition>>((ref) {
  return const [
    StoryDefinition(
      id: 'story_001',
      titleEs: 'Luna y el gato curioso',
      titleEn: 'Luna and the Curious Cat',
      summaryEs: 'Luna visita la granja y encuentra un gato juguetón.',
      summaryEn: 'Luna visits the farm and meets a playful cat.',
      coverColor: Color(0xFFFFCC80),
      readingTimeMinutes: 3,
      paragraphs: [
        BilingualParagraph(
          spanish: 'Luna camina por la granja y escucha "muu".',
          english: 'Luna walks through the farm and hears "moo".',
        ),
        BilingualParagraph(
          spanish: 'Sigue el sonido y encuentra un gato curioso escondido.',
          english: 'She follows the sound and finds a curious cat hiding.',
        ),
        BilingualParagraph(
          spanish: 'Luna acaricia al gato y lee las palabras en su collar.',
          english: 'Luna pets the cat and reads the words on its collar.',
        ),
      ],
      focusWordsEs: ['gato', 'muu', 'leer'],
      focusWordsEn: ['cat', 'moo', 'read'],
    ),
  ];
});

class WorldDefinition {
  const WorldDefinition({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.lessonCount,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int lessonCount;
}

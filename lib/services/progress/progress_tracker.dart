import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressTrackerProvider = ChangeNotifierProvider<ProgressTracker>((ref) {
  return ProgressTracker();
});

class ProgressTracker extends ChangeNotifier {
  String currentLearnerName = 'Luna';
  int currentWorld = 0;
  final Set<String> masteredWords = <String>{};
  final List<String> completedLessons = <String>[];
  int totalBadges = 0;

  void markLessonCompleted(String lessonId) {
    if (!completedLessons.contains(lessonId)) {
      completedLessons.add(lessonId);
      totalBadges += 1;
      notifyListeners();
    }
  }

  void unlockNextWorldIfNeeded(int worldIndex, int totalWorlds) {
    if (worldIndex == currentWorld && worldIndex < totalWorlds - 1) {
      currentWorld = worldIndex + 1;
      notifyListeners();
    }
  }

  void registerMasteredWord(String word) {
    if (masteredWords.add(word)) {
      notifyListeners();
    }
  }

  ProgressSnapshot snapshot() {
    return ProgressSnapshot(
      learner: currentLearnerName,
      worldsCompleted: currentWorld,
      lessons: List.unmodifiable(completedLessons),
      words: List.unmodifiable(masteredWords),
      badges: totalBadges,
    );
  }
}

class ProgressSnapshot {
  const ProgressSnapshot({
    required this.learner,
    required this.worldsCompleted,
    required this.lessons,
    required this.words,
    required this.badges,
  });

  final String learner;
  final int worldsCompleted;
  final List<String> lessons;
  final List<String> words;
  final int badges;
}

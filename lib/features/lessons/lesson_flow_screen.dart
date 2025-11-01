import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../models/lesson.dart';
import '../../services/content/content_repository.dart';
import '../../services/progress/progress_tracker.dart';
import '../../widgets/app_scaffold.dart';
import 'lesson_carousel.dart';

class LessonFlowArgs {
  const LessonFlowArgs({required this.worldId});
  final String worldId;
}

class LessonFlowScreen extends ConsumerStatefulWidget {
  const LessonFlowScreen({super.key, required this.args});

  static const String routeName = '/lesson_flow';

  final LessonFlowArgs args;

  @override
  ConsumerState<LessonFlowScreen> createState() => _LessonFlowScreenState();
}

class _LessonFlowScreenState extends ConsumerState<LessonFlowScreen> {
  int selectedLessonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(lessonCatalogProvider)[widget.args.worldId] ?? [];
    if (lessons.isEmpty) {
      return AppScaffold(
        title: context.l10n.lessonsTitle,
        body: Center(
          child: Text(context.l10n.lessonsEmpty),
        ),
      );
    }

    final lesson = lessons[selectedLessonIndex];

    return AppScaffold(
      title: lesson.title,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              selectedLessonIndex = (selectedLessonIndex + 1) % lessons.length;
            });
          },
          icon: const Icon(Icons.swap_horiz),
          tooltip: context.l10n.lessonsChange,
        )
      ],
      body: LessonCarousel(
        lesson: lesson,
        onLessonCompleted: () {
          final tracker = ref.read(progressTrackerProvider);
          tracker.markLessonCompleted(lesson.id);

          final worlds = ref.read(worldCatalogProvider);
          final worldIndex =
              worlds.indexWhere((world) => world.id == widget.args.worldId);
          if (worldIndex != -1) {
            final lessonIds = lessons.map((entry) => entry.id);
            if (tracker.hasCompletedLessons(lessonIds)) {
              tracker.unlockNextWorldIfNeeded(worldIndex, worlds.length);
            }
          }
        },
        onWordMastered: (word) {
          ref.read(progressTrackerProvider).registerMasteredWord(word);
        },
      ),
    );
  }
}

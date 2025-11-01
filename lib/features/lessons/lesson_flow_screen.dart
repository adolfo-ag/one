import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        title: 'Lecciones',
        body: const Center(
          child: Text('Contenido en preparación. Próximamente más aventuras.'),
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
          tooltip: 'Cambiar lección',
        )
      ],
      body: LessonCarousel(
        lesson: lesson,
        onLessonCompleted: () {
          ref
              .read(progressTrackerProvider)
              .markLessonCompleted(lesson.id);
        },
        onWordMastered: (word) {
          ref.read(progressTrackerProvider).registerMasteredWord(word);
        },
      ),
    );
  }
}

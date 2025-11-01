import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/lesson.dart';
import '../../../services/content/content_repository.dart';
import '../../stories/story_player.dart';

class StoryStep extends ConsumerWidget {
  const StoryStep({
    super.key,
    required this.step,
  });

  final LessonStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stories = ref.watch(storyCatalogProvider);
    final story = stories.firstWhere(
      (element) => element.id == step.storyId,
      orElse: () => stories.first,
    );

    return StoryPlayer(story: story);
  }
}

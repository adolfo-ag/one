import 'package:flutter/material.dart';

import '../../models/story.dart';
import 'story_player.dart';

class StoryReaderBottomSheet extends StatelessWidget {
  const StoryReaderBottomSheet({
    super.key,
    required this.story,
  });

  final StoryDefinition story;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StoryPlayer(
              story: story,
              scrollController: scrollController,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../services/content/content_repository.dart';
import '../../services/progress/progress_tracker.dart';
import '../../widgets/app_scaffold.dart';
import '../lessons/lesson_flow_screen.dart';

class WorldMapScreen extends ConsumerWidget {
  const WorldMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worlds = ref.watch(worldCatalogProvider);
    final progress = ref.watch(progressTrackerProvider);

    return AppScaffold(
      title: context.l10n.worldMapTitle,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: worlds.length,
        itemBuilder: (context, index) {
          final world = worlds[index];
          final unlocked = index <= progress.currentWorld;
          return GestureDetector(
            onTap: unlocked
                ? () {
                    Navigator.of(context).pushNamed(
                      LessonFlowScreen.routeName,
                      arguments: LessonFlowArgs(worldId: world.id),
                    );
                  }
                : null,
            child: Card(
              color: unlocked ? world.color : Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(world.icon, color: Colors.white),
                        const SizedBox(width: 8),
                    Text(
                      world.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      unlocked
                          ? context.l10n.worldLessonsLabel(world.lessonCount)
                          : context.l10n.worldLockedLabel,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

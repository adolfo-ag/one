import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../services/progress/progress_tracker.dart';
import '../../widgets/app_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressTrackerProvider);
    return AppScaffold(
      title: 'Lectura Bilingüe',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Hola, ${progress.currentLearnerName}! 👋',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            'Continúa tu aventura en el mundo ${progress.currentWorld + 1}.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoute.worlds.path);
            },
            icon: const Icon(Icons.map),
            label: const Text('Mapa de mundos'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoute.storyLibrary.path);
            },
            icon: const Icon(Icons.auto_stories),
            label: const Text('Biblioteca bilingüe'),
          ),
          const SizedBox(height: 24),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.emoji_events, size: 48, color: Colors.amber),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Logros desbloqueados: ${progress.totalBadges}'),
                        Text('Palabras dominadas: ${progress.masteredWords.length}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

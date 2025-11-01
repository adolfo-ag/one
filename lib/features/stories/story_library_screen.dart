import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/content/content_repository.dart';
import '../../widgets/app_scaffold.dart';
import 'story_reader_bottom_sheet.dart';

class StoryLibraryScreen extends ConsumerWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stories = ref.watch(storyCatalogProvider);

    return AppScaffold(
      title: 'Biblioteca bilingüe',
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => StoryReaderBottomSheet(story: story),
              );
            },
            child: Card(
              color: story.coverColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.titleEs,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      story.summaryEs,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Text('${story.readingTimeMinutes} min'),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../services/content/content_repository.dart';
import '../../widgets/app_scaffold.dart';
import 'story_reader_bottom_sheet.dart';

class StoryLibraryScreen extends ConsumerWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stories = ref.watch(storyCatalogProvider);

    return AppScaffold(
      title: context.l10n.storyLibraryTitle,
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
          final locale = Localizations.localeOf(context);
          final isSpanish = locale.languageCode == 'es';
          final title = isSpanish ? story.titleEs : story.titleEn;
          final summary = isSpanish ? story.summaryEs : story.summaryEn;

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
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      summary,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Text(
                      context.l10n.storyReadingTime(
                        story.readingTimeMinutes,
                      ),
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

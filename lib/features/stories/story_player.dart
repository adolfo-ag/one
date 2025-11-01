import 'package:flutter/material.dart';

import '../../models/story.dart';

class StoryPlayer extends StatefulWidget {
  const StoryPlayer({
    super.key,
    required this.story,
  });

  final StoryDefinition story;

  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
  bool _spanish = true;

  @override
  Widget build(BuildContext context) {
    final paragraphs = widget.story.paragraphs;
    final focusWords = _spanish ? widget.story.focusWordsEs : widget.story.focusWordsEn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _spanish ? widget.story.titleEs : widget.story.titleEn,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('ES')),
                ButtonSegment(value: false, label: Text('EN')),
              ],
              selected: {_spanish},
              onSelectionChanged: (selection) {
                setState(() => _spanish = selection.first);
              },
            )
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: paragraphs.length,
            itemBuilder: (context, index) {
              final paragraph = paragraphs[index];
              final text = _spanish ? paragraph.spanish : paragraph.english;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Palabras foco: ${focusWords.join(', ')}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

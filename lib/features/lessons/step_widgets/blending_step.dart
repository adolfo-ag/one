import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class BlendingStep extends StatelessWidget {
  const BlendingStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    final syllables = step.syllables ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Une las sílabas para formar palabras',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: syllables
              .map(
                (syllable) => Chip(
                  label: Text(syllable),
                ),
              )
              .toList(),
        ),
        const Spacer(),
        FilledButton(
          onPressed: onCompleted,
          child: const Text('Escuchar palabra formada'),
        ),
      ],
    );
  }
}

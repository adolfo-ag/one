import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class SightWordStep extends StatelessWidget {
  const SightWordStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    final locale = step.locale ?? const Locale('es');
    final focusWord = step.word ?? '';
    final sentence = step.contextSentence ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.languageCode == 'es'
              ? 'Palabra mágica'
              : 'Sight word highlight',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            focusWord,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          sentence,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        FilledButton(
          onPressed: onCompleted,
          child: Text(locale.languageCode == 'es' ? '¡Lo leí!' : 'Read it!'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
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
    final locale = step.locale ?? const Locale('es');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.stepBlending(locale),
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
          child: Text(context.l10n.stepBlendingListen(locale)),
        ),
      ],
    );
  }
}

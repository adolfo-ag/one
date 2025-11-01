import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/lesson.dart';

class MinimalPairsStep extends StatefulWidget {
  const MinimalPairsStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  State<MinimalPairsStep> createState() => _MinimalPairsStepState();
}

class _MinimalPairsStepState extends State<MinimalPairsStep> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pairs = widget.step.pairs ?? const [];
    if (pairs.isEmpty) {
      return const SizedBox.shrink();
    }

    final pair = pairs[_currentIndex];

    final locale = widget.step.locale ?? const Locale('es');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.stepMinimalPairs(locale),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            for (final option in [pair.first, pair.second])
              ElevatedButton(
                onPressed: () {
                  if (_currentIndex == pairs.length - 1) {
                    widget.onCompleted();
                  } else {
                    setState(() => _currentIndex += 1);
                  }
                },
                child: Text(option),
              ),
          ],
        ),
      ],
    );
  }
}

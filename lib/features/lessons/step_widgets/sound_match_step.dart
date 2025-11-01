import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class SoundMatchStep extends StatefulWidget {
  const SoundMatchStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  State<SoundMatchStep> createState() => _SoundMatchStepState();
}

class _SoundMatchStepState extends State<SoundMatchStep> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final locale = widget.step.locale ?? const Locale('es');
    final prompt = locale.languageCode == 'es'
        ? 'Toca la palabra que comienza con ${widget.step.grapheme}'
        : 'Tap the word that starts with ${widget.step.grapheme}';

    final words = widget.step.sampleWords ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prompt, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var i = 0; i < words.length; i++)
              ChoiceChip(
                label: Text(words[i]),
                selected: _selectedIndex == i,
                onSelected: (value) {
                  setState(() => _selectedIndex = i);
                  widget.onCompleted();
                },
              ),
          ],
        ),
      ],
    );
  }
}

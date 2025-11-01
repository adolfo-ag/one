import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class SyllablePuzzleStep extends StatefulWidget {
  const SyllablePuzzleStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  State<SyllablePuzzleStep> createState() => _SyllablePuzzleStepState();
}

class _SyllablePuzzleStepState extends State<SyllablePuzzleStep> {
  final List<String> _assembled = [];

  @override
  Widget build(BuildContext context) {
    final tiles = widget.step.tiles ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Arrastra las sílabas para formar "${widget.step.targetWord}"',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: tiles
              .map(
                (tile) => ActionChip(
                  label: Text(tile),
                  onPressed: () {
                    setState(() {
                      _assembled.add(tile);
                    });
                    if (_assembled.join() == widget.step.targetWord) {
                      widget.onCompleted();
                    }
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        Text(
          _assembled.join(),
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}

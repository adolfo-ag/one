import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/lesson.dart';

class ComprehensionStep extends StatefulWidget {
  const ComprehensionStep({
    super.key,
    required this.step,
    required this.onCompleted,
  });

  final LessonStep step;
  final VoidCallback onCompleted;

  @override
  State<ComprehensionStep> createState() => _ComprehensionStepState();
}

class _ComprehensionStepState extends State<ComprehensionStep> {
  int? _selectedIndex;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final options = widget.step.options ?? const [];
    final prompt = widget.step.prompt ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prompt, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        for (var i = 0; i < options.length; i++)
          RadioListTile<int>(
            title: Text(options[i]),
            value: i,
            groupValue: _selectedIndex,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value;
                _isCorrect = value == widget.step.correctIndex;
              });
            },
          ),
        const Spacer(),
        FilledButton(
          onPressed: _selectedIndex == null
              ? null
              : () {
                  if (_isCorrect) {
                    widget.onCompleted();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.commonRetryMessage),
                      ),
                    );
                  }
                },
          child: Text(context.l10n.commonCheck),
        ),
      ],
    );
  }
}

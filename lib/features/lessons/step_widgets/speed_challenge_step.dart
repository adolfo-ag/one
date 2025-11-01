import 'dart:async';

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/lesson.dart';
import '../../rewards/reward_overlay.dart';

typedef WordCallback = void Function(String word);

class SpeedChallengeStep extends StatefulWidget {
  const SpeedChallengeStep({
    super.key,
    required this.step,
    required this.onCompleted,
    required this.onWordMastered,
  });

  final LessonStep step;
  final VoidCallback onCompleted;
  final WordCallback onWordMastered;

  @override
  State<SpeedChallengeStep> createState() => _SpeedChallengeStepState();
}

class _SpeedChallengeStepState extends State<SpeedChallengeStep> {
  int _currentIndex = 0;
  bool _running = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startChallenge() {
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentIndex >= (widget.step.words?.length ?? 0)) {
        timer.cancel();
        widget.onCompleted();
      } else {
        final word = widget.step.words![_currentIndex];
        widget.onWordMastered(word);
        setState(() => _currentIndex += 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.step.words ?? const [];
    final locale = widget.step.locale ?? const Locale('es');

    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.stepSpeedPrompt(locale),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _currentIndex < words.length
                  ? Text(
                      words[_currentIndex],
                      key: ValueKey(_currentIndex),
                      style: Theme.of(context).textTheme.displayLarge,
                    )
                  : RewardCard(message: l10n.stepSpeedReward(locale)),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _running ? null : _startChallenge,
          child: Text(l10n.stepSpeedStart(locale)),
        ),
      ],
    );
  }
}

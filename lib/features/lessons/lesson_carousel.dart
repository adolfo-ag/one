import 'package:flutter/material.dart';

import '../../models/lesson.dart';
import 'step_widgets/blending_step.dart';
import 'step_widgets/comprehension_step.dart';
import 'step_widgets/minimal_pairs_step.dart';
import 'step_widgets/sight_word_step.dart';
import 'step_widgets/sound_match_step.dart';
import 'step_widgets/speed_challenge_step.dart';
import 'step_widgets/story_step.dart';
import 'step_widgets/syllable_puzzle_step.dart';
import '../rewards/reward_overlay.dart';

typedef WordCallback = void Function(String word);

typedef VoidCallback = void Function();

class LessonCarousel extends StatefulWidget {
  const LessonCarousel({
    super.key,
    required this.lesson,
    required this.onLessonCompleted,
    required this.onWordMastered,
  });

  final LessonDefinition lesson;
  final VoidCallback onLessonCompleted;
  final WordCallback onWordMastered;

  @override
  State<LessonCarousel> createState() => _LessonCarouselState();
}

class _LessonCarouselState extends State<LessonCarousel> {
  final PageController _controller = PageController();
  int _currentStepIndex = 0;
  bool _showReward = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNextStep() {
    if (_currentStepIndex == widget.lesson.steps.length - 1) {
      widget.onLessonCompleted();
      setState(() => _showReward = true);
      return;
    }
    setState(() {
      _currentStepIndex += 1;
    });
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.lesson.steps;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentStepIndex + 1) / steps.length,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return _buildStep(step);
                },
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _handleNextStep,
              child: Text(
                _currentStepIndex == steps.length - 1 ? 'Finalizar' : 'Siguiente',
              ),
            ),
          ],
        ),
        RewardOverlay(
          isVisible: _showReward,
          lessonTitle: widget.lesson.title,
          onDismissed: () {
            setState(() => _showReward = false);
          },
        )
      ],
    );
  }

  Widget _buildStep(LessonStep step) {
    switch (step.type) {
      case LessonStepType.soundMatch:
        return SoundMatchStep(
          step: step,
          onCompleted: _handleNextStep,
        );
      case LessonStepType.blending:
        return BlendingStep(step: step, onCompleted: _handleNextStep);
      case LessonStepType.syllablePuzzle:
        return SyllablePuzzleStep(step: step, onCompleted: _handleNextStep);
      case LessonStepType.minimalPairs:
        return MinimalPairsStep(step: step, onCompleted: _handleNextStep);
      case LessonStepType.sightWord:
        return SightWordStep(
          step: step,
          onCompleted: () {
            if (step.word != null) {
              widget.onWordMastered(step.word!);
            }
            _handleNextStep();
          },
        );
      case LessonStepType.speedChallenge:
        return SpeedChallengeStep(
          step: step,
          onCompleted: _handleNextStep,
          onWordMastered: widget.onWordMastered,
        );
      case LessonStepType.story:
        return StoryStep(step: step);
      case LessonStepType.comprehension:
        return ComprehensionStep(step: step, onCompleted: _handleNextStep);
    }
  }
}

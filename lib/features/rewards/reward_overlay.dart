import 'package:flutter/material.dart';

class RewardOverlay extends StatelessWidget {
  const RewardOverlay({
    super.key,
    required this.isVisible,
    required this.lessonTitle,
    required this.onDismissed,
  });

  final bool isVisible;
  final String lessonTitle;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Center(
          child: RewardCard(
            message: '¡Lección "$lessonTitle" completada! 🎉',
            onDismissed: onDismissed,
          ),
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  const RewardCard({
    super.key,
    required this.message,
    this.onDismissed,
  });

  final String message;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 64, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (onDismissed != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onDismissed,
                child: const Text('Seguir jugando'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

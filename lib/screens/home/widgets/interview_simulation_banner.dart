import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterviewSimulationBanner extends StatelessWidget {
  const InterviewSimulationBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.quiz_outlined,
                    size: 22, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  'Interview Simulation',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Timed scenarios with hint cards and missed-concept review.',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.push('/simulation'),
                child: const Text('Start Interview'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/all_concepts.dart';
import '../../domain/models/simulation_session.dart';

class SimulationResultsScreen extends StatelessWidget {
  final SimulationSession session;

  const SimulationResultsScreen({
    super.key,
    required this.session,
  });

  static String _formatElapsed(Duration d) {
    final clamped = d.isNegative ? Duration.zero : d;
    final minutes = clamped.inMinutes;
    final seconds = clamped.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final conceptById = {for (final c in allConcepts) c.id: c};

    final required = session.requiredConcepts;
    final viewed = session.viewedHints;

    final missed = required.where((id) => !viewed.contains(id)).toList();

    final scorePct = (session.score01 * 100).round();
    final elapsed = session.elapsed;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Complete'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '🔎 $scorePct%',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Completed in ${_formatElapsed(elapsed)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${session.viewedRequiredCount} / ${session.requiredConceptCount} required concepts covered',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: required.length,
                itemBuilder: (context, index) {
                  final conceptId = required[index];
                  final concept = conceptById[conceptId];

                  final isViewed = viewed.contains(conceptId);
                  final title = concept?.title ?? 'Concept #$conceptId';
                  final subtitle = isViewed
                      ? 'Covered (hint viewed)'
                      : 'You should have covered this';

                  return Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: ListTile(
                      leading: Icon(
                        isViewed ? Icons.check_circle : Icons.cancel,
                        color: isViewed
                            ? Colors.green
                            : theme.colorScheme.error,
                      ),
                      title: Text(title),
                      subtitle: Text(subtitle),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: missed.isEmpty
                          ? null
                          : () => context.push(
                                '/study/concepts',
                                extra: missed,
                              ),
                      child: Text(
                        missed.isEmpty
                            ? 'All concepts covered'
                            : 'Review missed concepts (${missed.length})',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/home'),
                      child: const Text('Back to Home'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

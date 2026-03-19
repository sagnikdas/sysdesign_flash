import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/all_concepts.dart';
import '../../data/simulation_scenarios.dart';
import '../../domain/models/concept.dart';
import '../../domain/models/simulation_session.dart';
import 'widgets/concept_modal.dart';

class SimulationSessionScreen extends StatefulWidget {
  final SimulationSession session;

  const SimulationSessionScreen({
    super.key,
    required this.session,
  });

  @override
  State<SimulationSessionScreen> createState() =>
      _SimulationSessionScreenState();
}

class _SimulationSessionScreenState extends State<SimulationSessionScreen> {
  late SimulationSession _session;

  Timer? _timer;
  late final DateTime _endsAt;
  Duration _remaining = Duration.zero;
  bool _ended = false;

  late final Map<int, Concept> _conceptById;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
    _endsAt = _session.startedAt.add(_session.duration);
    _conceptById = {for (final c in allConcepts) c.id: c};
    _remaining = _endsAt.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _ended) return;
      final now = DateTime.now();
      final remaining = _endsAt.difference(now);

      if (remaining.inSeconds <= 0) {
        _finishSession(now);
        return;
      }

      setState(() => _remaining = remaining);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static String _formatRemaining(Duration d) {
    final clamped = d.isNegative ? Duration.zero : d;
    final minutes = clamped.inMinutes;
    final seconds = clamped.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _viewHint(int conceptId) async {
    if (_ended) return;

    if (!_session.viewedHints.contains(conceptId)) {
      setState(() {
        _session = _session.copyWith(
          viewedHints: {..._session.viewedHints, conceptId},
        );
      });
    }

    final concept = _conceptById[conceptId];
    if (concept == null) return;

    await Future<void>.delayed(Duration.zero);

    if (!mounted || _ended) return;
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ConceptModal(concept: concept),
      ),
    );
  }

  void _finishSession(DateTime endedAt) {
    if (_ended) return;
    _ended = true;
    _timer?.cancel();

    final completed = _session.copyWith(endedAt: endedAt);

    if (!mounted) return;
    context.go(
      '/simulation/results',
      extra: completed,
    );
  }

  Future<void> _confirmEndSession() async {
    final shouldEnd = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('End Session?'),
        content: const Text(
          'You can review missed concepts after ending. Are you sure you want to finish now?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('End Session'),
          ),
        ],
      ),
    );

    if (shouldEnd == true) {
      _finishSession(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scenario = scenarioByName(_session.scenario);

    final remainingText = _formatRemaining(_remaining);
    final totalHints = _session.hintCardIds.length;
    final viewedHintsCount = _session.viewedHints
        .intersection(_session.hintCardIds.toSet())
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulation Session'),
        actions: [
          IconButton(
            tooltip: 'End session',
            icon: const Icon(Icons.stop_circle_outlined),
            onPressed: _confirmEndSession,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time Remaining',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      remainingText,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Level: ${_session.level.label}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _session.scenario,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scenario?.description ?? '',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      title: Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Hint cards ($viewedHintsCount / $totalHints)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      childrenPadding:
                          const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      children: [
                        ..._session.hintCardIds.map((conceptId) {
                          final concept = _conceptById[conceptId];
                          if (concept == null) {
                            return const SizedBox.shrink();
                          }
                          final viewed =
                              _session.viewedHints.contains(conceptId);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              leading: CircleAvatar(
                                backgroundColor:
                                    concept.color.withValues(alpha: 0.18),
                                child: Text(concept.icon),
                              ),
                              title: Text(concept.title),
                              subtitle: Text(
                                concept.tagline,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(
                                viewed
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: viewed
                                    ? Colors.green
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              onTap: () => _viewHint(conceptId),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tip: Tap hints to open the full concept card.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FilledButton(
                onPressed: _confirmEndSession,
                child: const Text('End Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

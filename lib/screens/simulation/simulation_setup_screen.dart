import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/simulation_scenarios.dart';
import '../../domain/models/simulation_session.dart';

class SimulationSetupScreen extends StatefulWidget {
  const SimulationSetupScreen({super.key});

  @override
  State<SimulationSetupScreen> createState() => _SimulationSetupScreenState();
}

class _SimulationSetupScreenState extends State<SimulationSetupScreen> {
  final _rng = Random();

  SimulationScenario _selectedScenario = simulationScenarios.first;
  int _durationMinutes = 45;
  SimulationLevel _level = SimulationLevel.mid;

  void _pickRandomScenario() {
    final next =
        simulationScenarios[_rng.nextInt(simulationScenarios.length)];
    setState(() => _selectedScenario = next);
  }

  void _start() {
    final now = DateTime.now();
    final session = SimulationSession(
      scenario: _selectedScenario.name,
      duration: Duration(minutes: _durationMinutes),
      level: _level,
      hintCardIds: _selectedScenario.hintCardIds,
      requiredConcepts: _selectedScenario.requiredConceptIds,
      viewedHints: const <int>{},
      startedAt: now,
    );

    context.push(
      '/simulation/session',
      extra: session,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Simulation'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Pick your scenario',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: _pickRandomScenario,
                        icon: const Icon(Icons.shuffle),
                        label: const Text('Random'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedScenario.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _selectedScenario.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: simulationScenarios.length,
                itemBuilder: (context, index) {
                  final scenario = simulationScenarios[index];
                  final isSelected = scenario.name == _selectedScenario.name;
                  final color = isSelected
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => setState(() => _selectedScenario = scenario),
                      child: Ink(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant
                                .withValues(alpha: isSelected ? 0.9 : 0.45),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                scenario.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Duration',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 30, label: Text('30 min')),
                      ButtonSegment(value: 45, label: Text('45 min')),
                      ButtonSegment(value: 60, label: Text('60 min')),
                    ],
                    selected: {_durationMinutes},
                    onSelectionChanged: (selected) => setState(
                      () => _durationMinutes = selected.first,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Level',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<SimulationLevel>(
                    segments: const [
                      ButtonSegment(value: SimulationLevel.mid, label: Text('Mid')),
                      ButtonSegment(
                        value: SimulationLevel.senior,
                        label: Text('Senior'),
                      ),
                      ButtonSegment(
                        value: SimulationLevel.staff,
                        label: Text('Staff'),
                      ),
                    ],
                    selected: {_level},
                    onSelectionChanged: (selected) =>
                        setState(() => _level = selected.first),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _start,
                      child: const Text('Start Interview'),
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

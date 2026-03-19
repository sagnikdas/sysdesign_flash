import '../domain/models/simulation_session.dart';

class SimulationScenario {
  final String name;
  final String description;
  final List<int> requiredConceptIds;
  final List<int> hintCardIds;
  final List<SimulationLevel> difficultyTiers;

  const SimulationScenario({
    required this.name,
    required this.description,
    required this.requiredConceptIds,
    required this.hintCardIds,
    required this.difficultyTiers,
  });
}

/// Phase 9: Interview Simulation scenarios.
///
/// The required/hint concept IDs refer to cards in `lib/data/all_concepts.dart`.
const simulationScenarios = <SimulationScenario>[
  SimulationScenario(
    name: 'Design Twitter Feed',
    description:
        'Practice fan-out at scale: timeline assembly, caching, and event streaming under load.',
    requiredConceptIds: [119, 137, 33, 130, 27],
    hintCardIds: [119, 137, 33, 130, 27],
    difficultyTiers: const [
      SimulationLevel.mid,
      SimulationLevel.senior,
      SimulationLevel.staff,
    ],
  ),
  SimulationScenario(
    name: 'Design a URL Shortener',
    description:
        'Design fast redirects with caching, collision-safe URL keys, and traffic protection.',
    requiredConceptIds: [126, 4, 25, 131],
    hintCardIds: [126, 4, 25, 131],
    difficultyTiers: const [
      SimulationLevel.mid,
      SimulationLevel.senior,
      SimulationLevel.staff,
    ],
  ),
  SimulationScenario(
    name: 'Design a Notification System',
    description:
        'Build multi-channel notifications with preferences, idempotency, and reliable async delivery.',
    requiredConceptIds: [132, 36, 33, 131],
    hintCardIds: [132, 36, 33, 131],
    difficultyTiers: const [
      SimulationLevel.mid,
      SimulationLevel.senior,
      SimulationLevel.staff,
    ],
  ),
  SimulationScenario(
    name: 'Design Uber',
    description:
        'Handle real-time matching, geo search, and safe payments with idempotent processing.',
    requiredConceptIds: [121, 134, 36, 139],
    hintCardIds: [121, 134, 36, 139],
    difficultyTiers: const [
      SimulationLevel.mid,
      SimulationLevel.senior,
      SimulationLevel.staff,
    ],
  ),
];

SimulationScenario? scenarioByName(String name) {
  try {
    return simulationScenarios.firstWhere((s) => s.name == name);
  } catch (_) {
    return null;
  }
}

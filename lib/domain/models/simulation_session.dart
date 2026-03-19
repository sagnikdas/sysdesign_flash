import 'dart:math';

enum SimulationLevel { mid, senior, staff }

extension SimulationLevelX on SimulationLevel {
  String get label => switch (this) {
        SimulationLevel.mid => 'Mid',
        SimulationLevel.senior => 'Senior',
        SimulationLevel.staff => 'Staff',
      };
}

class SimulationSession {
  final String scenario;
  final Duration duration;
  final SimulationLevel level;
  final List<int> hintCardIds;
  final List<int> requiredConcepts;
  final Set<int> viewedHints;
  final DateTime startedAt;
  final DateTime? endedAt;

  const SimulationSession({
    required this.scenario,
    required this.duration,
    required this.level,
    required this.hintCardIds,
    required this.requiredConcepts,
    required this.viewedHints,
    required this.startedAt,
    this.endedAt,
  });

  int get requiredConceptCount => requiredConcepts.length;

  int get viewedRequiredCount =>
      requiredConcepts.where(viewedHints.contains).length;

  double get score01 =>
      requiredConceptCount == 0 ? 0 : viewedRequiredCount / requiredConceptCount;

  List<int> get missedRequiredConceptIds => requiredConcepts
      .where((id) => !viewedHints.contains(id))
      .toList(growable: false);

  SimulationSession copyWith({
    String? scenario,
    Duration? duration,
    SimulationLevel? level,
    List<int>? hintCardIds,
    List<int>? requiredConcepts,
    Set<int>? viewedHints,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    // Ensure Set immutability semantics for state updates.
    final safeViewedHints =
        viewedHints == null ? this.viewedHints : Set<int>.from(viewedHints);

    return SimulationSession(
      scenario: scenario ?? this.scenario,
      duration: duration ?? this.duration,
      level: level ?? this.level,
      hintCardIds: hintCardIds ?? this.hintCardIds,
      requiredConcepts: requiredConcepts ?? this.requiredConcepts,
      viewedHints: safeViewedHints,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  SimulationSession endNow() {
    return copyWith(endedAt: DateTime.now());
  }

  Duration get elapsed =>
      (endedAt ?? DateTime.now()).difference(startedAt);

  /// Small helper for scenarios that need deterministic random picks.
  static int pickIndex(int length, int seed) {
    if (length <= 0) return 0;
    final rng = Random(seed);
    return rng.nextInt(length);
  }
}

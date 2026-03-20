import '../../domain/models/concept.dart';
import '../../domain/models/review_schedule.dart';

/// Weakness score for a category (0-1).
///
/// Defined as the ratio of cards that are either unseen or whose SM-2
/// lastQuality is < 3. Unseen cards count as weak because the user hasn't
/// learned them yet. A score of 0 means all cards in the category have been
/// reviewed and answered correctly (quality >= 3).
double weaknessScore(
  String category, {
  required List<Concept> allConcepts,
  required Map<int, ReviewSchedule> schedules,
}) {
  final conceptsInCategory =
      allConcepts.where((c) => c.category == category).toList();
  final total = conceptsInCategory.length;
  if (total == 0) return 0.0;

  // Strong = reviewed AND lastQuality >= 3. Everything else (unseen or failed) is weak.
  final strongCount = conceptsInCategory.where((c) {
    final s = schedules[c.id];
    return s != null && s.lastQuality >= 3;
  }).length;

  return ((total - strongCount) / total).clamp(0.0, 1.0);
}


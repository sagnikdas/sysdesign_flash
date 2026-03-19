import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'streak_provider.g.dart';

class StreakState {
  final int count;
  final DateTime? lastStudyDate;

  const StreakState({this.count = 0, this.lastStudyDate});
}

@riverpod
class Streak extends _$Streak {
  late Box<dynamic> _box;

  @override
  StreakState build() {
    _box = Hive.box('profile');
    final count = _box.get('streak', defaultValue: 0) as int;
    final lastStr = _box.get('lastStudyDate') as String?;
    final lastDate = lastStr != null ? DateTime.tryParse(lastStr) : null;
    return StreakState(count: count, lastStudyDate: lastDate);
  }

  /// Call this when user completes a study action.
  /// Returns true if streak was incremented (new day).
  bool recordStudy() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = state.lastStudyDate;

    if (last != null) {
      final lastDay = DateTime(last.year, last.month, last.day);
      if (lastDay == today) {
        // Already studied today — no change
        return false;
      }
      final yesterday = today.subtract(const Duration(days: 1));
      if (lastDay == yesterday) {
        // Studied yesterday — increment
        final newCount = state.count + 1;
        _persist(newCount, today);
        state = StreakState(count: newCount, lastStudyDate: today);
        return true;
      }
    }

    // First study or missed a day — start at 1
    _persist(1, today);
    state = StreakState(count: 1, lastStudyDate: today);
    return true;
  }

  void reset() {
    _persist(0, null);
    state = const StreakState(count: 0);
  }

  void _persist(int count, DateTime? date) {
    _box.put('streak', count);
    if (date != null) {
      _box.put('lastStudyDate', date.toIso8601String());
    } else {
      _box.delete('lastStudyDate');
    }
  }
}

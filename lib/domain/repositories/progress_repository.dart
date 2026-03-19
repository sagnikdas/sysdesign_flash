import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/supabase_config.dart';

class ProgressRepository {
  ProgressRepository({SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;

  Box<bool> get _masteredBox => Hive.box<bool>('mastered');
  Box<String> get _reviewSchedulesBox => Hive.box<String>('review_schedules');
  SupabaseClient get _supabase => _client ?? Supabase.instance.client;

  List<Map<String, dynamic>> readLocalProgressRows(String userId) {
    final rows = <Map<String, dynamic>>[];
    for (final key in _masteredBox.keys) {
      if (key is! int || _masteredBox.get(key) != true) continue;
      final scheduleJson = _reviewSchedulesBox.get(key);
      Map<String, dynamic> schedule = <String, dynamic>{};
      if (scheduleJson != null && scheduleJson.isNotEmpty) {
        final decoded = jsonDecode(scheduleJson);
        if (decoded is Map<String, dynamic>) {
          schedule = decoded;
        }
      }
      rows.add(<String, dynamic>{
        'user_id': userId,
        'concept_id': key,
        'mastered': true,
        'easiness': schedule['easiness'],
        'interval': schedule['interval'],
        'repetitions': schedule['repetitions'],
        'next_review': schedule['nextReview'],
        'last_quality': schedule['lastQuality'],
        'last_reviewed': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
    return rows;
  }

  Future<void> upsertCloudProgress(List<Map<String, dynamic>> rows) async {
    if (!isSupabaseConfigured || rows.isEmpty) return;
    await _supabase.from('user_progress').upsert(rows);
  }

  Future<List<Map<String, dynamic>>> fetchCloudProgress(String userId) async {
    if (!isSupabaseConfigured) return const <Map<String, dynamic>>[];
    final rows = await _supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId);
    return rows.whereType<Map<String, dynamic>>().toList();
  }

  Future<void> writeLocalFromCloud(
    List<Map<String, dynamic>> rows, {
    required bool serverWins,
  }) async {
    if (!serverWins) return;
    await _masteredBox.clear();
    for (final row in rows) {
      final conceptId = row['concept_id'];
      if (conceptId is int && row['mastered'] == true) {
        await _masteredBox.put(conceptId, true);
      }
    }
  }
}
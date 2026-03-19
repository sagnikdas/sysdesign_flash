import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/supabase_config.dart';

class ProfileRepository {
  ProfileRepository({SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;

  Box<dynamic> get _profileBox => Hive.box('profile');
  SupabaseClient get _supabase => _client ?? Supabase.instance.client;

  Map<String, dynamic> readLocal() {
    return <String, dynamic>{
      'display_name': (_profileBox.get('name') ?? '').toString(),
      'streak': _profileBox.get('streak') ?? 0,
      'daily_goal': _profileBox.get('dailyGoal') ?? 10,
      'join_date': _profileBox.get('joinDate'),
      'last_study_date': _profileBox.get('lastStudyDate'),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  Future<void> writeLocalFromCloud(Map<String, dynamic> row) async {
    await _profileBox.put('name', (row['display_name'] ?? '').toString());
    await _profileBox.put('streak', row['streak'] ?? 0);
    await _profileBox.put('dailyGoal', row['daily_goal'] ?? 10);
    if (row['join_date'] != null) {
      await _profileBox.put('joinDate', row['join_date']);
    }
    if (row['last_study_date'] != null) {
      await _profileBox.put('lastStudyDate', row['last_study_date']);
    }
  }

  Future<void> upsertCloudProfile({
    required String userId,
    required Map<String, dynamic> profile,
  }) async {
    if (!isSupabaseConfigured) return;
    await _supabase.from('user_profiles').upsert(<String, dynamic>{
      'user_id': userId,
      ...profile,
    });
  }

  Future<Map<String, dynamic>?> fetchCloudProfile(String userId) async {
    if (!isSupabaseConfigured) return null;
    final row = await _supabase
        .from('user_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (row is Map<String, dynamic>) return row;
    return null;
  }
}

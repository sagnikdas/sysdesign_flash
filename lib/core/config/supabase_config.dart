import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
const _supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue: '',
);

bool get isSupabaseConfigured =>
    _supabaseUrl.trim().isNotEmpty && _supabaseAnonKey.trim().isNotEmpty;

Future<bool> initializeSupabaseIfConfigured() async {
  if (!isSupabaseConfigured) {
    debugPrint(
      'Supabase not configured. Skipping initialization; app remains local-only.',
    );
    return false;
  }

  try {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
    return true;
  } catch (error, stackTrace) {
    debugPrint('Supabase init failed: $error');
    debugPrintStack(stackTrace: stackTrace);
    return false;
  }
}

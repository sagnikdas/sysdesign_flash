import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/config/supabase_config.dart';
import '../domain/repositories/profile_repository.dart';

class AuthService {
  AuthService({
    SupabaseClient? client,
    GoogleSignIn? googleSignIn,
    ProfileRepository? profileRepository,
  }) : _client = client,
       _googleSignIn = googleSignIn,
       _profileRepository = profileRepository ?? ProfileRepository();

  final SupabaseClient? _client;
  final GoogleSignIn? _googleSignIn;
  final ProfileRepository _profileRepository;

  SupabaseClient get _supabase => _client ?? Supabase.instance.client;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  User? get currentUser => _supabase.auth.currentUser;

  Future<bool> signInWithGoogle() async {
    if (!isSupabaseConfigured) return false;
    final googleSignIn = _googleSignIn ?? GoogleSignIn.instance;

    await googleSignIn.initialize();
    final account = await googleSignIn.authenticate();
    final auth = account.authentication;
    final idToken = auth.idToken;
    if (idToken == null || idToken.isEmpty) return false;

    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    await _upsertProfile();
    return true;
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (!isSupabaseConfigured) return;
    await _supabase.auth.signInWithPassword(email: email, password: password);
    await _upsertProfile();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!isSupabaseConfigured) return;
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: <String, dynamic>{'display_name': name.trim()},
    );
    await _upsertProfile();
  }

  Future<void> signOut() async {
    if (!isSupabaseConfigured) return;
    await _supabase.auth.signOut();
  }

  Future<void> _upsertProfile() async {
    final user = currentUser;
    if (user == null) return;
    final local = _profileRepository.readLocal();
    final displayName =
        (local['display_name'] as String?)?.trim().isNotEmpty == true
        ? local['display_name'] as String
        : (user.userMetadata?['display_name'] ?? user.email ?? 'User')
              .toString();
    await _profileRepository.upsertCloudProfile(
      userId: user.id,
      profile: <String, dynamic>{
        ...local,
        'display_name': displayName,
      },
    );
  }
}


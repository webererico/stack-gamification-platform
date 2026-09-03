import 'package:stack_gamification_platform/features/authentication/domain/model/google_sign_in_result.dart';

abstract interface class AuthRepository {
  Stream<String?> authStateChanges();

  String? get currentUserId;

  Future<String?> signInWithEmail({
    required String email,
    required String password,
  });

  Future<String?> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Signs in (or signs up, if it's the account's first time) via Google,
  /// returning the account's name/e-mail/photo so the caller can sync the
  /// user profile.
  Future<GoogleSignInResult?> signInWithGoogle();

  Future<void> signOut();
}

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

  Future<void> signOut();
}

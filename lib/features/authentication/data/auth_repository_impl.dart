import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(this._firebaseAuth, this._errorHandler);

  @override
  Stream<String?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } catch (e) {
      _errorHandler.handle(e);
      return null;
    }
  }

  @override
  Future<String?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } catch (e) {
      _errorHandler.handle(e);
      return null;
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}

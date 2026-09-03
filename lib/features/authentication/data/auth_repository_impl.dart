import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/features/authentication/domain/model/google_sign_in_result.dart';
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
  Future<GoogleSignInResult?> signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();
      // On web, Firebase Auth's own popup flow handles Google login. On
      // Android/iOS it delegates to the native Google sign-in UI — no need
      // for the separate google_sign_in package either way.
      final credential = kIsWeb
          ? await _firebaseAuth.signInWithPopup(provider)
          : await _firebaseAuth.signInWithProvider(provider);
      final user = credential.user;
      if (user == null) return null;
      return GoogleSignInResult(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
        isNewUser: credential.additionalUserInfo?.isNewUser ?? false,
      );
    } catch (e) {
      _errorHandler.handle(e);
      return null;
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}

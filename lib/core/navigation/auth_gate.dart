import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';

/// Tracks the two pieces of state go_router needs to decide where to send a
/// user: whether they're signed in, and whether their profile already
/// belongs to a squad. Exposed as a ChangeNotifier so it can drive
/// GoRouter's `refreshListenable` and `redirect` synchronously.
class AuthGate extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthGate(this._authRepository, this._userRepository) {
    _authSubscription = _authRepository.authStateChanges().listen(
      _onAuthChanged,
    );
  }

  String? uid;
  bool hasSquad = false;
  bool authResolved = false;
  bool isLoadingUser = false;

  StreamSubscription<String?>? _authSubscription;
  StreamSubscription? _userSubscription;

  void _onAuthChanged(String? newUid) {
    uid = newUid;
    authResolved = true;
    _userSubscription?.cancel();
    if (newUid == null) {
      hasSquad = false;
      isLoadingUser = false;
      notifyListeners();
      return;
    }
    isLoadingUser = true;
    notifyListeners();
    _userSubscription = _userRepository.watchUser(newUid).listen((user) {
      hasSquad = user?.squadId != null;
      isLoadingUser = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _userSubscription?.cancel();
    super.dispose();
  }
}

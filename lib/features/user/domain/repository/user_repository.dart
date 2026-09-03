import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';

abstract interface class UserRepository {
  Stream<AppUser?> watchUser(String uid);

  Stream<List<AppUser>> watchSquadMembers(String squadId);

  Future<void> createProfile({
    required String uid,
    required String name,
    required String email,
  });

  /// Syncs the profile after a Google sign-in. On a brand-new account this
  /// creates the full profile (name/e-mail/photo); on a returning account
  /// it only refreshes the photo (and e-mail), leaving the name — which the
  /// user may have customized in-app — and squad untouched.
  Future<void> upsertGoogleProfile({
    required String uid,
    required String name,
    required String email,
    required String? photoUrl,
    required bool isNewUser,
  });

  Future<void> updateName({required String uid, required String name});

  Future<void> updateAggregateXp({required String uid, required int totalXp});
}

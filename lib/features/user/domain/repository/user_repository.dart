import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';

abstract interface class UserRepository {
  Stream<AppUser?> watchUser(String uid);

  Stream<List<AppUser>> watchSquadMembers(String squadId);

  Future<void> createProfile({
    required String uid,
    required String name,
    required String email,
  });

  Future<void> updateName({required String uid, required String name});

  Future<void> updateAggregateXp({required String uid, required int totalXp});
}

import 'package:stack_gamification_platform/features/squad/domain/model/squad.dart';

abstract interface class SquadRepository {
  Stream<List<Squad>> watchSquads();

  Future<Squad?> createSquad({required String name, required String stack});

  /// Joins [squadId] as [uid]: sets the squad fields on the user profile
  /// and bumps the squad's member counter in a single atomic write.
  Future<void> joinSquad({required String uid, required Squad squad});
}

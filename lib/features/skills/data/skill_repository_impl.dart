import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';

class SkillRepositoryImpl implements SkillRepository {
  final FirebaseFirestore _firestore;
  final ErrorHandler _errorHandler;

  SkillRepositoryImpl(this._firestore, this._errorHandler);

  CollectionReference<Map<String, dynamic>> _skillsOf(String uid) =>
      _firestore.collection('users').doc(uid).collection('skills');

  @override
  Stream<List<SkillRating>> watchSkills(String uid) {
    return _skillsOf(uid)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => SkillRating.fromMap(doc.id, doc.data()))
              .toList(),
        )
        .handleError((Object e) => _errorHandler.handle(e));
  }

  @override
  Future<void> upsertRating({
    required String uid,
    required String skillId,
    required String name,
    required int rating,
  }) async {
    try {
      await _skillsOf(uid)
          .doc(skillId)
          .set(
            SkillRating(skillId: skillId, name: name, rating: rating).toMap(),
          );
    } catch (e) {
      _errorHandler.handle(e);
    }
  }
}

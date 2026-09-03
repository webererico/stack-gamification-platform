import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/gamification/skill_questions.dart';

class SkillRating {
  final String skillId;
  final String name;
  final int rating;
  final Map<String, SkillAnswer> answers;
  final int projectsCount;
  final DateTime? updatedAt;

  const SkillRating({
    required this.skillId,
    required this.name,
    required this.rating,
    this.answers = const {},
    this.projectsCount = 0,
    this.updatedAt,
  });

  int get xp => LevelCalculator.xpForRating(rating);
  SkillTier get tier => SkillTierX.fromRating(rating);

  /// Whether this skill has already gone through the questionnaire, as
  /// opposed to being an unrated catalog placeholder.
  bool get hasAssessment => answers.isNotEmpty || projectsCount > 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'answers': answers.map((id, answer) => MapEntry(id, answer.name)),
      'projectsCount': projectsCount,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory SkillRating.fromMap(String skillId, Map<String, dynamic> map) {
    final updatedAtValue = map['updatedAt'];
    final rawAnswers = map['answers'] as Map<String, dynamic>? ?? const {};
    return SkillRating(
      skillId: skillId,
      name: map['name'] as String? ?? skillId,
      rating: (map['rating'] as num?)?.toInt() ?? 0,
      answers: rawAnswers.map(
        (id, value) => MapEntry(id, SkillAnswerX.fromName(value as String?)),
      ),
      projectsCount: (map['projectsCount'] as num?)?.toInt() ?? 0,
      updatedAt: updatedAtValue is Timestamp ? updatedAtValue.toDate() : null,
    );
  }
}

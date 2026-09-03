import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';

class SkillRating {
  final String skillId;
  final String name;
  final int rating;
  final DateTime? updatedAt;

  const SkillRating({
    required this.skillId,
    required this.name,
    required this.rating,
    this.updatedAt,
  });

  int get xp => LevelCalculator.xpForRating(rating);
  SkillTier get tier => SkillTierX.fromRating(rating);

  SkillRating copyWith({int? rating}) {
    return SkillRating(
      skillId: skillId,
      name: name,
      rating: rating ?? this.rating,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory SkillRating.fromMap(String skillId, Map<String, dynamic> map) {
    final updatedAtValue = map['updatedAt'];
    return SkillRating(
      skillId: skillId,
      name: map['name'] as String? ?? skillId,
      rating: (map['rating'] as num?)?.toInt() ?? 0,
      updatedAt: updatedAtValue is Timestamp ? updatedAtValue.toDate() : null,
    );
  }
}

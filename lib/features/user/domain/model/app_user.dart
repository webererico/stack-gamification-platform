import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? squadId;
  final String? squadName;
  final String? stack;
  final int totalXp;
  final DateTime? createdAt;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.squadId,
    this.squadName,
    this.stack,
    this.totalXp = 0,
    this.createdAt,
  });

  bool get hasSquad => squadId != null;
  DevLevel get level => LevelCalculator.levelForXp(totalXp);

  AppUser copyWith({
    String? name,
    String? photoUrl,
    String? squadId,
    String? squadName,
    String? stack,
    int? totalXp,
  }) {
    return AppUser(
      uid: uid,
      name: name ?? this.name,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
      squadId: squadId ?? this.squadId,
      squadName: squadName ?? this.squadName,
      stack: stack ?? this.stack,
      totalXp: totalXp ?? this.totalXp,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'squadId': squadId,
      'squadName': squadName,
      'stack': stack,
      'totalXp': totalXp,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    final createdAtValue = map['createdAt'];
    return AppUser(
      uid: uid,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
      squadId: map['squadId'] as String?,
      squadName: map['squadName'] as String?,
      stack: map['stack'] as String?,
      totalXp: (map['totalXp'] as num?)?.toInt() ?? 0,
      createdAt: createdAtValue is Timestamp ? createdAtValue.toDate() : null,
    );
  }
}

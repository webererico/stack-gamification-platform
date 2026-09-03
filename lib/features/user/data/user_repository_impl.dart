import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final ErrorHandler _errorHandler;

  UserRepositoryImpl(this._firestore, this._errorHandler);

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Stream<AppUser?> watchUser(String uid) {
    return _users
        .doc(uid)
        .snapshots()
        .map((doc) {
          if (!doc.exists || doc.data() == null) return null;
          return AppUser.fromMap(doc.id, doc.data()!);
        })
        .handleError((Object e) => _errorHandler.handle(e));
  }

  @override
  Stream<List<AppUser>> watchSquadMembers(String squadId) {
    return _users
        .where('squadId', isEqualTo: squadId)
        .orderBy('totalXp', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => AppUser.fromMap(doc.id, doc.data()))
              .toList(),
        )
        .handleError((Object e) => _errorHandler.handle(e));
  }

  @override
  Future<void> createProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      await _users
          .doc(uid)
          .set(AppUser(uid: uid, name: name, email: email).toMap());
    } catch (e) {
      _errorHandler.handle(e);
    }
  }

  @override
  Future<void> updateName({required String uid, required String name}) async {
    try {
      await _users.doc(uid).update({'name': name});
    } catch (e) {
      _errorHandler.handle(e);
    }
  }

  @override
  Future<void> updateAggregateXp({
    required String uid,
    required int totalXp,
  }) async {
    try {
      await _users.doc(uid).update({'totalXp': totalXp});
    } catch (e) {
      _errorHandler.handle(e);
    }
  }
}

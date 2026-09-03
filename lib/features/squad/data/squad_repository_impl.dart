import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/features/squad/domain/model/squad.dart';
import 'package:stack_gamification_platform/features/squad/domain/repository/squad_repository.dart';

class SquadRepositoryImpl implements SquadRepository {
  final FirebaseFirestore _firestore;
  final ErrorHandler _errorHandler;

  SquadRepositoryImpl(this._firestore, this._errorHandler);

  CollectionReference<Map<String, dynamic>> get _squads =>
      _firestore.collection('squads');

  @override
  Stream<List<Squad>> watchSquads() {
    return _squads
        .orderBy('name')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Squad.fromMap(doc.id, doc.data()))
              .toList(),
        )
        .handleError((Object e) => _errorHandler.handle(e));
  }

  @override
  Future<Squad?> createSquad({
    required String name,
    required String stack,
  }) async {
    try {
      final squad = Squad(id: '', name: name, stack: stack);
      final ref = await _squads.add(squad.toMap());
      return Squad(id: ref.id, name: name, stack: stack);
    } catch (e) {
      _errorHandler.handle(e);
      return null;
    }
  }

  @override
  Future<void> joinSquad({required String uid, required Squad squad}) async {
    try {
      final batch = _firestore.batch();
      batch.update(_firestore.collection('users').doc(uid), {
        'squadId': squad.id,
        'squadName': squad.name,
        'stack': squad.stack,
      });
      batch.update(_squads.doc(squad.id), {
        'memberCount': FieldValue.increment(1),
      });
      await batch.commit();
    } catch (e) {
      _errorHandler.handle(e);
    }
  }
}

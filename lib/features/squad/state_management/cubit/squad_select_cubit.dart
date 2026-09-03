import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/squad/domain/model/squad.dart';
import 'package:stack_gamification_platform/features/squad/domain/repository/squad_repository.dart';
part 'squad_select_state.dart';

class SquadSelectCubit extends Cubit<SquadSelectState> {
  final SquadRepository _squadRepository;
  final String _uid;
  StreamSubscription<List<Squad>>? _subscription;

  SquadSelectCubit(this._squadRepository, AuthRepository authRepository)
    : _uid = authRepository.currentUserId ?? '',
      super(const SquadSelectState()) {
    _subscription = _squadRepository.watchSquads().listen((squads) {
      emit(state.copyWith(squads: squads, isLoading: false));
    });
  }

  Future<void> createAndJoinSquad({
    required String name,
    required String stack,
  }) async {
    emit(state.copyWith(isJoining: true));
    final squad = await _squadRepository.createSquad(name: name, stack: stack);
    if (squad != null) {
      await _squadRepository.joinSquad(uid: _uid, squad: squad);
      emit(state.copyWith(isJoining: false, joined: true));
    } else {
      emit(state.copyWith(isJoining: false));
    }
  }

  Future<void> joinSquad(Squad squad) async {
    emit(state.copyWith(isJoining: true));
    await _squadRepository.joinSquad(uid: _uid, squad: squad);
    emit(state.copyWith(isJoining: false, joined: true));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

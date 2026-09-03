import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final String _uid;
  StreamSubscription<AppUser?>? _userSubscription;
  StreamSubscription<List<SkillRating>>? _skillsSubscription;

  ProfileCubit(
    this._userRepository,
    SkillRepository skillRepository,
    this._authRepository,
  ) : _uid = _authRepository.currentUserId ?? '',
      super(const ProfileState()) {
    _userSubscription = _userRepository.watchUser(_uid).listen((user) {
      emit(state.copyWith(user: user, isLoading: false));
    });
    _skillsSubscription = skillRepository.watchSkills(_uid).listen((skills) {
      final rated = skills.where((s) => s.rating > 0).toList()
        ..sort((a, b) => b.rating.compareTo(a.rating));
      emit(state.copyWith(ratedSkills: rated));
    });
  }

  Future<void> updateName(String name) {
    return _userRepository.updateName(uid: _uid, name: name);
  }

  Future<void> signOut() => _authRepository.signOut();

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _skillsSubscription?.cancel();
    return super.close();
  }
}

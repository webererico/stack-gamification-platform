part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final AppUser? user;
  final List<SkillRating> ratedSkills;
  final bool isLoading;

  const ProfileState({
    this.user,
    this.ratedSkills = const [],
    this.isLoading = true,
  });

  ProfileState copyWith({
    AppUser? user,
    List<SkillRating>? ratedSkills,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      ratedSkills: ratedSkills ?? this.ratedSkills,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, ratedSkills, isLoading];
}

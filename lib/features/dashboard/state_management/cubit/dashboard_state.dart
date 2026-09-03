part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final AppUser? user;
  final List<SkillRating> ratedSkills;
  final bool isLoading;

  const DashboardState({
    this.user,
    this.ratedSkills = const [],
    this.isLoading = true,
  });

  DashboardState copyWith({
    AppUser? user,
    List<SkillRating>? ratedSkills,
    bool? isLoading,
  }) {
    return DashboardState(
      user: user ?? this.user,
      ratedSkills: ratedSkills ?? this.ratedSkills,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, ratedSkills, isLoading];
}

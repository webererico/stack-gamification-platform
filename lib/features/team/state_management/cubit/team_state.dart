part of 'team_cubit.dart';

class TeamState extends Equatable {
  final List<AppUser> members;
  final String? squadName;
  final String? currentUid;
  final bool isLoading;

  const TeamState({
    this.members = const [],
    this.squadName,
    this.currentUid,
    this.isLoading = true,
  });

  TeamState copyWith({
    List<AppUser>? members,
    String? squadName,
    String? currentUid,
    bool? isLoading,
  }) {
    return TeamState(
      members: members ?? this.members,
      squadName: squadName ?? this.squadName,
      currentUid: currentUid ?? this.currentUid,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [members, squadName, currentUid, isLoading];
}

part of 'team_builder_cubit.dart';

class TeamBuilderState extends Equatable {
  final List<AppUser> members;
  final List<String> selectedUids;
  final Map<String, List<SkillRating>> skillsByUid;
  final bool isLoading;

  const TeamBuilderState({
    this.members = const [],
    this.selectedUids = const [],
    this.skillsByUid = const {},
    this.isLoading = true,
  });

  TeamBuilderState copyWith({
    List<AppUser>? members,
    List<String>? selectedUids,
    Map<String, List<SkillRating>>? skillsByUid,
    bool? isLoading,
  }) {
    return TeamBuilderState(
      members: members ?? this.members,
      selectedUids: selectedUids ?? this.selectedUids,
      skillsByUid: skillsByUid ?? this.skillsByUid,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [members, selectedUids, skillsByUid, isLoading];
}

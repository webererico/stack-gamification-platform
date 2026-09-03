part of 'squad_select_cubit.dart';

class SquadSelectState extends Equatable {
  final List<Squad> squads;
  final bool isLoading;
  final bool isJoining;
  final bool joined;

  const SquadSelectState({
    this.squads = const [],
    this.isLoading = true,
    this.isJoining = false,
    this.joined = false,
  });

  SquadSelectState copyWith({
    List<Squad>? squads,
    bool? isLoading,
    bool? isJoining,
    bool? joined,
  }) {
    return SquadSelectState(
      squads: squads ?? this.squads,
      isLoading: isLoading ?? this.isLoading,
      isJoining: isJoining ?? this.isJoining,
      joined: joined ?? this.joined,
    );
  }

  @override
  List<Object?> get props => [squads, isLoading, isJoining, joined];
}

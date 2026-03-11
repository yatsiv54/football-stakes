part of 'matches_cubit.dart';

@freezed
class MatchesCubitState with _$MatchesCubitState {
  const factory MatchesCubitState.initial() = _Initial;

  const factory MatchesCubitState.loading() = _Loading;

  const factory MatchesCubitState.matchesLoaded({
    required List<MatchEntity> matches,
    required List<MatchEntity> filteredMatches,
  }) = _MatchesLoaded;

  const factory MatchesCubitState.failure() = _Failure;
}

part of 'watchlist_cubit.dart';

enum WatchlistSort { kickoffTime, league }

abstract class WatchlistState {
  const WatchlistState();
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<MatchEntity> matches;
  final WatchlistSort sortType;

  const WatchlistLoaded(this.matches, {this.sortType = WatchlistSort.kickoffTime});
}
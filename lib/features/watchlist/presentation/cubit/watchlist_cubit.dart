import 'package:bloc/bloc.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:get_it/get_it.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final MatchesRepository repository;

  WatchlistCubit({required this.repository}) : super(WatchlistInitial());

  List<MatchEntity> _currentMatches = [];
  WatchlistSort _currentSort = WatchlistSort.kickoffTime;

  Future<void> loadWatchlist() async {
    emit(WatchlistLoading());
    try {
      final matches = await repository.getSavedWatchlistMatches();
      _currentMatches = matches;
      _applySort();
      emit(WatchlistLoaded(List.from(_currentMatches), sortType: _currentSort));
    } catch (e) {
      emit(WatchlistLoaded([], sortType: _currentSort));
    }
  }

  Future<void> toggleMatch(MatchEntity match) async {
    final isSaved = _currentMatches.any((m) => m.id == match.id);

    if (isSaved) {
      // 1. Якщо видаляємо з Watchlist - видаляємо і нотифікацію
      try {
        await GetIt.I<MatchesCubit>().cancelNotificationForMatch(match.id);
      } catch (_) {}

      // 2. Видаляємо з Watchlist
      await repository.removeWatchlistMatch(match.id);
      _currentMatches.removeWhere((m) => m.id == match.id);
    } else {
      await repository.saveWatchlistMatch(match);
      _currentMatches.add(match);
    }

    _applySort();
    emit(WatchlistLoaded(List.from(_currentMatches), sortType: _currentSort));
  }

  bool isMatchSaved(String matchId) {
    return _currentMatches.any((m) => m.id == matchId);
  }

  void changeSort(WatchlistSort sort) {
    _currentSort = sort;
    _applySort();
    emit(WatchlistLoaded(List.from(_currentMatches), sortType: _currentSort));
  }

  void _applySort() {
    if (_currentSort == WatchlistSort.kickoffTime) {
      _currentMatches.sort((a, b) {
        final dateCmp = a.date.compareTo(b.date);
        if (dateCmp != 0) return dateCmp;
        return a.time.compareTo(b.time);
      });
    } else {
      _currentMatches.sort((a, b) {
        int leagueCmp = a.league.compareTo(b.league);
        if (leagueCmp != 0) return leagueCmp;

        final dateCmp = a.date.compareTo(b.date);
        if (dateCmp != 0) return dateCmp;
        return a.time.compareTo(b.time);
      });
    }
  }

  Future<void> clearWatchlist() async {
    await repository.clearWatchlist();
    _currentMatches.clear();
    emit(WatchlistLoaded([], sortType: _currentSort));
  }
}
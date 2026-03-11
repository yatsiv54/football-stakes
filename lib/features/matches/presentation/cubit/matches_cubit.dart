// ignore_for_file: unused_field

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:football/core/services/notification_service.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/data/enums/date_filter.dart';
import 'package:football/features/matches/data/enums/league_filter.dart';
import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matches_cubit.freezed.dart';
part 'matches_state.dart';

enum NotificationResult {
  successScheduled,
  successRemoved,
  errorDisabledInSettings,
  errorPermissionsRequired,
  errorTooLate,
}

class MatchesCubit extends Cubit<MatchesCubitState> {
  final MatchesRepository repository;

  DateFilter _currentDateFilter = DateFilter.today;
  LeagueFilter _currentLeagueFilter = LeagueFilter.topLeagues;
  List<String> _favoriteLeagues = [];

  List<String> _notifiedMatchIds = [];

  List<MatchEntity> _allMatches = [];
  
  List<MatchEntity> _currentFiltered = [];

  Timer? _debounceTimer;
  int _loadingRequestId = 0;

  final _notificationsController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get notificationsStream =>
      _notificationsController.stream;

  MatchesCubit({required this.repository})
    : super(const MatchesCubitState.initial()) {
    _loadNotifiedMatchIds();
  }

  DateFilter get currentDateFilter => _currentDateFilter;
  LeagueFilter get currentLeagueFilter => _currentLeagueFilter;
  List<String> get favoriteLeagues => _favoriteLeagues;
  List<String> get notifiedMatchIds => _notifiedMatchIds;

  Future<void> _loadNotifiedMatchIds() async {
    _notifiedMatchIds = await repository.getNotifiedMatchIds();
    _notificationsController.add(_notifiedMatchIds);
  }

  Future<void> setKickoffReminders(bool enabled) async {
    await repository.setKickoffReminder(enabled);

    if (!enabled) {
      final service = NotificationService();
      for (final id in _notifiedMatchIds) {
        await service.cancelReminder(id);
      }
      _notifiedMatchIds.clear();
      await repository.clearAllNotifiedMatchIds();
      _notificationsController.add([]);
    }
  }

  
  Future<void> cancelNotificationForMatch(String matchId) async {
    if (_notifiedMatchIds.contains(matchId)) {
      final service = NotificationService();
      await service.cancelReminder(matchId);
      await repository.removeNotifiedMatchId(matchId);
      _notifiedMatchIds.remove(matchId);
      _notificationsController.add(List.from(_notifiedMatchIds));
    }
  }

  Future<NotificationResult> toggleNotification({
    required String matchId,
    required String matchTitle,
    required DateTime matchTime,
  }) async {
    final areRemindersEnabled = await repository.getKickoffReminder();
    if (!areRemindersEnabled) {
      return NotificationResult.errorDisabledInSettings;
    }

    final service = NotificationService();

    if (_notifiedMatchIds.contains(matchId)) {
      await service.cancelReminder(matchId);
      await repository.removeNotifiedMatchId(matchId);
      _notifiedMatchIds.remove(matchId);
      _notificationsController.add(List.from(_notifiedMatchIds));
      return NotificationResult.successRemoved;
    } else {
      final hasPerms = await service.ensurePermissions();
      if (!hasPerms) {
        return NotificationResult.errorPermissionsRequired;
      }

      final success = await service.scheduleMatchReminder(
        pickId: matchId,
        matchTitle: matchTitle,
        matchTime: matchTime,
      );

      if (success) {
        await repository.addNotifiedMatchId(matchId);
        _notifiedMatchIds.add(matchId);
        _notificationsController.add(List.from(_notifiedMatchIds));
        return NotificationResult.successScheduled;
      } else {
        return NotificationResult.errorTooLate;
      }
    }
  }

  Future<void> loadMatches({bool isRefresh = false}) async {
    if (isClosed) return;
    _loadingRequestId++;
    final int currentRequestId = _loadingRequestId;
 
    if (!isRefresh) {
      emit(const MatchesCubitState.loading());
    }

    try {
      final matches = await repository.getFixtures(
        dateFilter: _currentDateFilter,
        leagueFilter: _currentLeagueFilter,
        favoriteLeagues: _favoriteLeagues,
      );

      if (currentRequestId != _loadingRequestId) return;

      _allMatches = matches;
      _currentFiltered = matches;

      emit(
        MatchesCubitState.matchesLoaded(
          matches: matches,
          filteredMatches: matches,
        ),
      );
    } catch (_) {
      if (currentRequestId != _loadingRequestId) return;
      emit(const MatchesCubitState.failure());
    }
  }

  Future<void> refreshMatches() async {
    if (isClosed) return;
    _debounceTimer?.cancel();
    await loadMatches(isRefresh: true);
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _currentFiltered = _allMatches;
      emit(
        MatchesCubitState.matchesLoaded(
          matches: _allMatches,
          filteredMatches: _allMatches,
        ),
      );
      return;
    }

    try {
      final q = query.toLowerCase();
      final filtered =
          _allMatches.where((m) {
            return m.homeTeam.name.toLowerCase().contains(q) ||
                m.awayTeam.name.toLowerCase().contains(q) ||
                m.league.toLowerCase().contains(q);
          }).toList();

      _currentFiltered = filtered;

      emit(
        MatchesCubitState.matchesLoaded(
          matches: _allMatches,
          filteredMatches: filtered,
        ),
      );
    } catch (e) {
      print("Search error: $e");
    }
  }

  void changeDateFilter(DateFilter filter) {
    if (isClosed) return;
    _currentDateFilter = filter;
    emit(const MatchesCubitState.loading());
    _startDebounce();
  }

  void changeLeagueFilter(LeagueFilter filter) {
    if (isClosed) return;
    _currentLeagueFilter = filter;
    emit(const MatchesCubitState.loading());
    _startDebounce();
  }

  void toggleFavoriteLeague(String leagueName) {
    if (isClosed) return;
    if (_favoriteLeagues.contains(leagueName)) {
      _favoriteLeagues.remove(leagueName);
    } else {
      _favoriteLeagues.add(leagueName);
    }

    if (_currentLeagueFilter == LeagueFilter.favorites) {
      emit(const MatchesCubitState.loading());
      _startDebounce();
    }
  }

  void _startDebounce() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      loadMatches();
    });
  }

  @override
  Future<void> close() {
    _notificationsController.close();
    _debounceTimer?.cancel();
    return super.close();
  }
}
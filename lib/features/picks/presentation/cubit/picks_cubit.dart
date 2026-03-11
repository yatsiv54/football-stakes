// ignore_for_file: dead_code, unused_local_variable

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:football/core/helpers/cooldown_helper.dart';
import 'package:football/core/services/notification_service.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';
import 'package:football/features/picks/data/models/pick_with_match.dart';

class WeeklyStats {
  final int weekNumber;
  final int wins;
  final int losses;

  const WeeklyStats(this.weekNumber, this.wins, this.losses);
}

class PicksStats {
  final int total;
  final int open;
  final String hitRate;

  final int settled;
  final String winRate;
  final String avgOdds;
  final String roi;
  final bool isRoiPositive;
  final List<WeeklyStats> weeklyStats;

  final double homePercent;
  final double drawPercent;
  final double awayPercent;

  final double lowConfPercent;
  final double medConfPercent;
  final double highConfPercent;

  final String lowConfWinRate;
  final String medConfWinRate;
  final String highConfWinRate;

  const PicksStats({
    this.total = 0,
    this.open = 0,
    this.hitRate = '0%',
    this.settled = 0,
    this.winRate = '0%',
    this.avgOdds = '0.00',
    this.roi = '0.0%',
    this.isRoiPositive = true,
    this.weeklyStats = const [],
    this.homePercent = 0,
    this.drawPercent = 0,
    this.awayPercent = 0,
    this.lowConfPercent = 0,
    this.medConfPercent = 0,
    this.highConfPercent = 0,
    this.lowConfWinRate = '0% wins',
    this.medConfWinRate = '0% wins',
    this.highConfWinRate = '0% wins',
  });
}

abstract class PicksState {}

class PicksInitial extends PicksState {}

class PicksLoading extends PicksState {}

class PicksLoaded extends PicksState {
  final List<PickWithMatch> picks;
  final PicksStats stats;
  PicksLoaded(this.picks, {this.stats = const PicksStats()});
}

class PicksError extends PicksState {
  final String message;
  PicksError(this.message);
}

class PicksCubit extends Cubit<PicksState> {
  final MatchesRepository repository;
  Timer? _timer;

  PicksCubit({required this.repository}) : super(PicksInitial()) {
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      loadPicks(isSilent: true);
    });
  }

  Future<void> loadPicks({
    bool isRefresh = false,
    bool isSilent = false,
  }) async {
    if (isClosed) return;

    if (!isSilent && !isRefresh && state is! PicksLoaded) {
      emit(PicksLoading());
    }

    try {
      final savedPicks = await repository.getSavedPicks();

      if (savedPicks.isEmpty) {
        if (!isClosed) emit(PicksLoaded([], stats: const PicksStats()));
        return;
      }

      if (!isSilent && state is! PicksLoaded) {
        final cachedStats = _calculateStatsFromEntities(savedPicks);
        emit(PicksLoaded([], stats: cachedStats));
      }

      bool shouldFetchApi = true;
      if (state is PicksLoaded && !isSilent && !isRefresh) {}

      if (!shouldFetchApi && !isSilent) return;
      if (isRefresh) CooldownManager().setCooldown('picks_refresh');

      List<PickWithMatch> resultList = [];
      bool hasUpdates = false;
      List<PickEntity> updatedEntities = [];

      final futures = savedPicks.map((pick) async {
        final match = await repository.getMatchById(pick.matchId);

        if (match != null) {
          final pwm = PickWithMatch(pick: pick, match: match);
          final calculatedStatus = pwm.status;

          PickStatus newEntityStatus = PickStatus.wait;
          if (calculatedStatus == CalculatedPickStatus.win)
            newEntityStatus = PickStatus.win;
          if (calculatedStatus == CalculatedPickStatus.loss)
            newEntityStatus = PickStatus.lose;

          if (pick.status != newEntityStatus) {
            hasUpdates = true;
            final updatedPick = pick.copyWith(status: newEntityStatus);
            updatedEntities.add(updatedPick);
            return PickWithMatch(pick: updatedPick, match: match);
          } else {
            updatedEntities.add(pick);
            return pwm;
          }
        }
        updatedEntities.add(pick);
        return null;
      });

      final results = await Future.wait(futures);
      resultList = results.whereType<PickWithMatch>().toList();
      resultList.sort((a, b) => b.match.date.compareTo(a.match.date));

      if (hasUpdates) {
        await repository.updateAllPicks(updatedEntities);
      }

      final stats = _calculateStats(resultList);

      if (!isClosed) {
        emit(PicksLoaded(resultList, stats: stats));
      }
    } catch (e) {
      if (!isSilent && !isClosed) {
        if (state is! PicksLoaded) {
          emit(PicksError("Failed to load picks: $e"));
        }
      }
    }
  }

  PicksStats _calculateStats(List<PickWithMatch> list) {
    int total = list.length;
    int open = 0;
    int wins = 0;
    int losses = 0;

    int settled = 0;
    double totalStaked = 0;
    double totalReturn = 0;
    double sumOdds = 0;

    int homeCount = 0;
    int drawCount = 0;
    int awayCount = 0;

    List<int> lowConfStats = [0, 0];
    List<int> medConfStats = [0, 0];
    List<int> highConfStats = [0, 0];

    final now = DateTime.now();
    Map<int, Map<String, int>> weeksData = {
      1: {'wins': 0, 'losses': 0},
      2: {'wins': 0, 'losses': 0},
      3: {'wins': 0, 'losses': 0},
      4: {'wins': 0, 'losses': 0},
    };

    for (var item in list) {
      if (item.pick.status == PickStatus.wait) open++;
      if (item.pick.status == PickStatus.win) wins++;
      if (item.pick.status == PickStatus.lose) losses++;

      sumOdds += item.pick.odd;

      if (item.pick.outcomeType == OutcomeType.home) homeCount++;
      if (item.pick.outcomeType == OutcomeType.draw) drawCount++;
      if (item.pick.outcomeType == OutcomeType.away) awayCount++;

      final conf = item.pick.confidence;

      if (item.pick.status != PickStatus.wait) {
        settled++;
        totalStaked += item.pick.stake;

        if (item.pick.status == PickStatus.win) {
          totalReturn += (item.pick.stake * item.pick.odd);
        }

        final difference = now.difference(item.match.date).inDays;
        if (difference >= 0 && difference < 28) {
          int weekIndex = 4 - (difference ~/ 7);
          if (item.pick.status == PickStatus.win) {
            weeksData[weekIndex]!['wins'] = weeksData[weekIndex]!['wins']! + 1;
          } else if (item.pick.status == PickStatus.lose) {
            weeksData[weekIndex]!['losses'] =
                weeksData[weekIndex]!['losses']! + 1;
          }
        }

        if (conf <= 2) {
          lowConfStats[0]++;
          if (item.pick.status == PickStatus.win) lowConfStats[1]++;
        } else if (conf == 3) {
          medConfStats[0]++;
          if (item.pick.status == PickStatus.win) medConfStats[1]++;
        } else {
          highConfStats[0]++;
          if (item.pick.status == PickStatus.win) highConfStats[1]++;
        }
      }
    }

    String winRateStr = '0%';
    if (settled > 0) {
      final percent = (wins / settled) * 100;
      winRateStr = '${percent.toStringAsFixed(0)}%';
    }

    String avgOddsStr = '0.00';
    if (total > 0) {
      final avg = sumOdds / total;
      avgOddsStr = avg.toStringAsFixed(2);
    }

    String roiStr = '0.0%';
    bool isPositive = true;

    if (totalStaked > 0) {
      final profit = totalReturn - totalStaked;
      final roiVal = (profit / totalStaked) * 100;

      isPositive = roiVal >= 0;
      final sign = isPositive ? '+' : '';
      roiStr = '$sign${roiVal.toStringAsFixed(1)}%';
    }

    final weeklyStatsList = weeksData.entries.map((e) {
      return WeeklyStats(e.key, e.value['wins']!, e.value['losses']!);
    }).toList();

    double homePct = total > 0 ? (homeCount / total) * 100 : 0;
    double drawPct = total > 0 ? (drawCount / total) * 100 : 0;
    double awayPct = total > 0 ? (awayCount / total) * 100 : 0;

    int totalWins = wins;
    double lowPct = totalWins > 0 ? (lowConfStats[1] / totalWins) * 100 : 0;
    double medPct = totalWins > 0 ? (medConfStats[1] / totalWins) * 100 : 0;
    double highPct = totalWins > 0 ? (highConfStats[1] / totalWins) * 100 : 0;

    String formatWinRate(List<int> stats) {
      if (stats[0] == 0) return '0% wins';
      return '${((stats[1] / stats[0]) * 100).toStringAsFixed(0)}% wins';
    }

    return PicksStats(
      total: total,
      open: open,
      hitRate: winRateStr,
      settled: settled,
      winRate: winRateStr,
      avgOdds: avgOddsStr,
      roi: roiStr,
      isRoiPositive: isPositive,
      weeklyStats: weeklyStatsList,
      homePercent: homePct,
      drawPercent: drawPct,
      awayPercent: awayPct,
      lowConfPercent: lowPct,
      medConfPercent: medPct,
      highConfPercent: highPct,
      lowConfWinRate: formatWinRate(lowConfStats),
      medConfWinRate: formatWinRate(medConfStats),
      highConfWinRate: formatWinRate(highConfStats),
    );
  }

  PicksStats _calculateStatsFromEntities(List<PickEntity> list) {
    int total = list.length;
    int open = 0;
    int wins = 0;
    int losses = 0;

    int settled = 0;
    double totalStaked = 0;
    double totalReturn = 0;
    double sumOdds = 0;

    for (var item in list) {
      if (item.status == PickStatus.wait) open++;
      if (item.status == PickStatus.win) wins++;
      if (item.status == PickStatus.lose) losses++;

      sumOdds += item.odd;

      if (item.status != PickStatus.wait) {
        settled++;
        totalStaked += item.stake;

        if (item.status == PickStatus.win) {
          totalReturn += (item.stake * item.odd);
        }
      }
    }

    String winRateStr = '0%';
    if (settled > 0) {
      final percent = (wins / settled) * 100;
      winRateStr = '${percent.toStringAsFixed(0)}%';
    }

    String avgOddsStr = '0.00';
    if (total > 0) {
      final avg = sumOdds / total;
      avgOddsStr = avg.toStringAsFixed(2);
    }

    String roiStr = '0.0%';
    bool isPositive = true;

    if (totalStaked > 0) {
      final profit = totalReturn - totalStaked;
      final roiVal = (profit / totalStaked) * 100;

      isPositive = roiVal >= 0;
      final sign = isPositive ? '+' : '';
      roiStr = '$sign${roiVal.toStringAsFixed(1)}%';
    }

    return PicksStats(
      total: total,
      open: open,
      hitRate: winRateStr,
      settled: settled,
      winRate: winRateStr,
      avgOdds: avgOddsStr,
      roi: roiStr,
      isRoiPositive: isPositive,
    );
  }

  Future<void> deletePick(PickWithMatch item) async {
    if (state is PicksLoaded) {
      final currentList = (state as PicksLoaded).picks;

      final updatedList = currentList
          .where((element) => element.pick.id != item.pick.id)
          .toList();

      final newStats = _calculateStats(updatedList);

      emit(PicksLoaded(updatedList, stats: newStats));
    }

    try {
      await repository.deletePick(item.pick);

      if (item.pick.remind) {
        await NotificationService().cancelReminder(item.pick.id);
      }
    } catch (e) {
      print("Error deleting pick: $e");
    }
  }

  Future<void> deleteAllPicks() async {
    try {
      if (state is PicksLoaded) {
        final currentList = (state as PicksLoaded).picks;
        for (var item in currentList) {
          if (item.pick.remind) {
             await NotificationService().cancelReminder(item.pick.id);
          }
        }
      }
      
      await repository.deleteAllPicks();
      emit(PicksLoaded([], stats: const PicksStats()));
    } catch (e) {
      print('Error clearing all picks: $e');
    }
  }

  void addPickLocally(PickEntity pick, MatchEntity match) {
    if (state is PicksLoaded) {
      final currentList = (state as PicksLoaded).picks;

      final newItem = PickWithMatch(pick: pick, match: match);

      final updatedList = List<PickWithMatch>.from(currentList)..add(newItem);

      updatedList.sort((a, b) => b.match.date.compareTo(a.match.date));

      final newStats = _calculateStats(updatedList);

      emit(PicksLoaded(updatedList, stats: newStats));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
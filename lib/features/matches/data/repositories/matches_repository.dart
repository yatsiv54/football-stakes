import 'dart:convert';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/data/entities/odd/odd_entity.dart';
import 'package:football/features/matches/data/enums/date_filter.dart';
import 'package:football/features/matches/data/enums/league_filter.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchesRepository {
  static const String _apiKey =
      '6deaa29b7fc1ec872d8e0646352d9dcfbe3e5ae451a30006675ad44aa2e5dfde';
  static const String _baseUrl = 'https://apiv3.apifootball.com/';

  static const Map<String, int> top5Leagues = {
    'Premier League': 152,
    'La Liga': 302,
    'Bundesliga': 175,
    'Serie A': 207,
    'Ligue 1': 168,
    'Segunda Liga': 267,
    'Liga 1': 194,
    'NPFL': 248,
    'Premier League Cup - Group Stage': 716,
    'Club Friendlies': 355,
  };

  static const Map<String, int> top3Leagues = {
    'Premier League': 152,
    'La Liga': 302,
    'Serie A': 207,
  };

  Future<void> saveWatchlistMatch(MatchEntity match) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedJson = prefs.getStringList('saved_watchlist') ?? [];

    savedJson.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['match_id'] == match.id || decoded['id'] == match.id;
    });

    savedJson.add(jsonEncode(match.toJson()));
    await prefs.setStringList('saved_watchlist', savedJson);
  }

  Future<void> removeWatchlistMatch(String matchId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedJson = prefs.getStringList('saved_watchlist') ?? [];

    savedJson.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['match_id'] == matchId || decoded['id'] == matchId;
    });

    await prefs.setStringList('saved_watchlist', savedJson);
  }

  Future<List<MatchEntity>> getSavedWatchlistMatches() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedJson = prefs.getStringList('saved_watchlist') ?? [];

    return savedJson.map((str) {
      return MatchEntity.fromJson(jsonDecode(str));
    }).toList();
  }

  Future<void> clearWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_watchlist');
  }

  Future<List<MatchEntity>> getFixtures({
    DateFilter dateFilter = DateFilter.today,
    LeagueFilter leagueFilter = LeagueFilter.topLeagues,
    List<String>? favoriteLeagues,
  }) async {
    final dateStr = _getDateFromFilter(dateFilter);
    List<MatchEntity> matches = [];

    try {
      switch (leagueFilter) {
        case LeagueFilter.allLeagues:
          matches = await _fetchLeaguesMatches(
            date: dateStr,
            leagues: top5Leagues,
          );
          break;
        case LeagueFilter.topLeagues:
          matches = await _fetchLeaguesMatches(
            date: dateStr,
            leagues: top3Leagues,
          );
          break;

        case LeagueFilter.favorites:
          final savedMatches = await getSavedWatchlistMatches();
          matches = savedMatches.where((match) {
            final matchDateStr = _formatDate(match.date);
            return matchDateStr == dateStr;
          }).toList();
          _sortMatches(matches);
          break;

        case LeagueFilter.finished:
          matches = await _fetchFinishedMatches(date: dateStr);
          break;
      }
    } catch (e) {
      print('Error getting fixtures: $e');
      return [];
    }

    return matches;
  }

  Future<List<MatchEntity>> _fetchLeaguesMatches({
    required String date,
    required Map<String, int> leagues,
  }) async {
    List<MatchEntity> allMatches = [];

    for (var leagueId in leagues.values) {
      final matches = await _fetchMatchesByLeague(
        leagueId: leagueId,
        date: date,
      );
      allMatches.addAll(matches);
    }

    _sortMatches(allMatches);
    return allMatches;
  }

  Future<List<MatchEntity>> _fetchFinishedMatches({
    required String date,
  }) async {
    final allMatches = await _fetchLeaguesMatches(
      date: date,
      leagues: top5Leagues,
    );
    return allMatches
        .where((match) => match.status.toLowerCase() == 'finished')
        .toList();
  }

  Future<List<MatchEntity>> _fetchMatchesByLeague({
    required int leagueId,
    required String date,
  }) async {
    try {
      final matchesUri = Uri.parse(
        '$_baseUrl?action=get_events&from=$date&to=$date&league_id=$leagueId&APIkey=$_apiKey',
      );
      final oddsUri = Uri.parse(
        '$_baseUrl?action=get_odds&from=$date&to=$date&league_id=$leagueId&APIkey=$_apiKey',
      );

      final responses = await Future.wait([
        http.get(matchesUri),
        http.get(oddsUri),
      ]);

      final matchesResponse = responses[0];
      final oddsResponse = responses[1];

      if (matchesResponse.statusCode != 200) return [];

      final matchesJson = jsonDecode(matchesResponse.body);
      if (matchesJson is! List) return [];

      final List<MatchEntity> matches = matchesJson
          .map((json) => MatchEntity.fromJson(json as Map<String, dynamic>))
          .toList();

      Map<String, Odd> oddsMap = {};

      if (oddsResponse.statusCode == 200) {
        final oddsJson = jsonDecode(oddsResponse.body);
        if (oddsJson is List) {
          for (var item in oddsJson) {
            try {
              final matchId = item['match_id'].toString();
              oddsMap[matchId] = Odd.fromJson(item as Map<String, dynamic>);
            } catch (e) {
              print("ERROR PARSING ODD: $e");
            }
          }
        }
      }

      return matches.map((match) {
        final odd = oddsMap[match.id.toString()];
        return match.copyWith(odd: odd);
      }).toList();
    } catch (e) {
      print('Fetch Error for league $leagueId: $e');
      return [];
    }
  }

  Future<bool> isMatchStarted(String matchId) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?action=get_events&match_id=$matchId&APIkey=$_apiKey',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is List && decoded.isNotEmpty) {
          final matchData = decoded[0];
          final status = matchData['match_status']?.toString().trim() ?? '';
          if (status.isEmpty) return false;
          if (status.toLowerCase() == 'finished') return true;
          final isNumber = int.tryParse(status);
          if (isNumber != null) return true;
          if (RegExp(r'^\d').hasMatch(status) && !status.contains(':')) {
            return true;
          }
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> savePickLocal(PickEntity pick) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> picksJson = prefs.getStringList('saved_picks') ?? [];
    picksJson.add(jsonEncode(pick.toJson()));
    await prefs.setStringList('saved_picks', picksJson);
  }

  Future<List<PickEntity>> getSavedPicks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> picksJson = prefs.getStringList('saved_picks') ?? [];
    return picksJson
        .map((str) => PickEntity.fromJson(jsonDecode(str)))
        .toList();
  }

  Future<void> updateAllPicks(List<PickEntity> picks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> picksJson = picks
        .map((pick) => jsonEncode(pick.toJson()))
        .toList();
    await prefs.setStringList('saved_picks', picksJson);
  }

  Future<void> deletePick(PickEntity pickToDelete) async {
    final picks = await getSavedPicks();
    picks.removeWhere((p) => p.id == pickToDelete.id);
    await updateAllPicks(picks);
  }

  Future<void> deleteAllPicks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_picks');
  }

  Future<void> setKickoffReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('kickoff_reminders', value);
  }

  Future<bool> getKickoffReminder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('kickoff_reminders') ?? true;
  }

  Future<List<String>> getNotifiedMatchIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('notified_match_ids') ?? [];
  }

  Future<void> addNotifiedMatchId(String matchId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('notified_match_ids') ?? [];
    if (!ids.contains(matchId)) {
      ids.add(matchId);
      await prefs.setStringList('notified_match_ids', ids);
    }
  }

  Future<void> removeNotifiedMatchId(String matchId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('notified_match_ids') ?? [];
    if (ids.contains(matchId)) {
      ids.remove(matchId);
      await prefs.setStringList('notified_match_ids', ids);
    }
  }

  Future<void> clearAllNotifiedMatchIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notified_match_ids');
  }

  Future<MatchEntity?> getMatchById(String matchId) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?action=get_events&match_id=$matchId&APIkey=$_apiKey',
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is List && decoded.isNotEmpty) {
          return MatchEntity.fromJson(decoded[0]);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String _getDateFromFilter(DateFilter filter) {
    final now = DateTime.now();
    DateTime targetDate;
    switch (filter) {
      case DateFilter.yesterday:
        targetDate = now.subtract(const Duration(days: 1));
        break;
      case DateFilter.today:
        targetDate = now;
        break;
      case DateFilter.tomorrow:
        targetDate = now.add(const Duration(days: 1));
        break;
    }
    return _formatDate(targetDate);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _sortMatches(List<MatchEntity> matches) {
    matches.sort((a, b) {
      final dateCompare = a.date.compareTo(b.date);
      if (dateCompare != 0) return dateCompare;
      return a.time.compareTo(b.time);
    });
  }
}

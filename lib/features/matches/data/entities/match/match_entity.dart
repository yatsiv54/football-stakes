import 'package:football/features/matches/data/entities/odd/odd_entity.dart';
import 'package:football/features/matches/data/entities/score/score_entity.dart';
import 'package:football/features/matches/data/entities/team/team_entity.dart';

class MatchEntity {
  final String id;
  final String country;
  final String leagueLogo;
  final String league;
  final DateTime date;
  final String time;
  final String status;
  final Team homeTeam;
  final Team awayTeam;
  final Score score;
  final String live;
  final String stadium;
  final Odd? odd;

  MatchEntity({
    required this.id,
    required this.country,
    required this.league,
    required this.date,
    required this.time,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.odd,
    required this.leagueLogo,
    required this.live,
    required this.stadium,
  });

  factory MatchEntity.fromJson(Map<String, dynamic> json) {
    // Helper to get value from either API key or local key
    T? get<T>(String apiKey, String localKey) {
      if (json.containsKey(localKey)) return json[localKey] as T?;
      if (json.containsKey(apiKey)) return json[apiKey] as T?;
      return null;
    }

    // Handle nested objects which might be flat in API but nested in local JSON
    Team getTeam(String nameKey, String logoKey, String localKey) {
      if (json.containsKey(localKey)) {
        return Team.fromJson(json[localKey] as Map<String, dynamic>);
      }
      return Team(
        name: json[nameKey] as String? ?? '',
        logo: json[logoKey] as String? ?? '',
      );
    }

    Score getScore(String homeKey, String awayKey, String localKey) {
      if (json.containsKey(localKey)) {
        return Score.fromJson(json[localKey] as Map<String, dynamic>);
      }
      return Score(
        home: int.tryParse(json[homeKey]?.toString() ?? '') ?? 0,
        away: int.tryParse(json[awayKey]?.toString() ?? '') ?? 0,
      );
    }

    return MatchEntity(
      id: get<String>('match_id', 'id') ?? '',
      country: get<String>('country_name', 'country') ?? '',
      stadium: get<String>('match_stadium', 'stadium') ?? '',
      league: get<String>('league_name', 'league') ?? '',
      live: get<String>('match_live', 'live') ?? '',
      status: (get<String>('match_status', 'status') ?? '') == ''
          ? 'Upcoming'
          : get<String>('match_status', 'status')!,
      date: DateTime.parse(get<String>('match_date', 'date') ?? DateTime.now().toIso8601String()),
      time: get<String>('match_time', 'time') ?? '',
      leagueLogo: get<String>('league_logo', 'leagueLogo') ?? '',
      
      homeTeam: getTeam('match_hometeam_name', 'team_home_badge', 'homeTeam'),
      awayTeam: getTeam('match_awayteam_name', 'team_away_badge', 'awayTeam'),
      score: getScore('match_hometeam_score', 'match_awayteam_score', 'score'),

      odd: json['odd'] != null ? Odd.fromJson(json['odd'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'league': league,
      'date': date.toIso8601String(),
      'time': time,
      'status': status,
      'leagueLogo': leagueLogo,
      'live': live,
      'stadium': stadium,
      'homeTeam': homeTeam.toJson(),
      'awayTeam': awayTeam.toJson(),
      'score': score.toJson(),
      'odd': odd?.toJson(),
    };
  }

  MatchEntity copyWith({
    String? id,
    String? country,
    String? league,
    String? leagueLogo,
    String? live,
    DateTime? date,
    String? time,
    String? status,
    Team? homeTeam,
    Team? awayTeam,
    Score? score,
    Odd? odd,
    String? stadium,
  }) {
    return MatchEntity(
      id: id ?? this.id,
      country: country ?? this.country,
      stadium: stadium ?? this.stadium,
      league: league ?? this.league,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      score: score ?? this.score,
      odd: odd ?? this.odd,
      leagueLogo: leagueLogo ?? this.leagueLogo,
      live: live ?? this.live,
    );
  }
}
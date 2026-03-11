
enum LeagueFilter {
  allLeagues,
  topLeagues,
  favorites,
  finished,
}

extension LeagueFilterExtension on LeagueFilter {
  String get label {
    switch (this) {
      case LeagueFilter.allLeagues:
        return 'All Leagues'; 
      case LeagueFilter.topLeagues:
        return 'Top Leagues'; 
      case LeagueFilter.favorites:
        return 'Favorites';
      case LeagueFilter.finished:
        return 'Finished';
    }
  }

  String get description {
    switch (this) {
      case LeagueFilter.allLeagues:
        return 'Premier League, La Liga, Bundesliga, Serie A, Ligue 1';
      case LeagueFilter.topLeagues:
        return 'Premier League, La Liga, Serie A';
      case LeagueFilter.favorites:
        return 'Your favorite leagues';
      case LeagueFilter.finished:
        return 'Finished matches only';
    }
  }
}
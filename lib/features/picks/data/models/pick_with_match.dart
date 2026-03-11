import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';

enum CalculatedPickStatus { open, win, loss }

class PickWithMatch {
  final PickEntity pick;
  final MatchEntity match;

  PickWithMatch({required this.pick, required this.match});

  CalculatedPickStatus get status {
    if (match.status != 'Finished') {
      return CalculatedPickStatus.open;
    }

    final home = match.score.home;
    final away = match.score.away;

    OutcomeType actualOutcome;
    if (home > away) {
      actualOutcome = OutcomeType.home;
    } else if (away > home) {
      actualOutcome = OutcomeType.away;
    } else {
      actualOutcome = OutcomeType.draw;
    }

    if (pick.outcomeType == actualOutcome) {
      return CalculatedPickStatus.win;
    } else {
      return CalculatedPickStatus.loss;
    }
  }
}

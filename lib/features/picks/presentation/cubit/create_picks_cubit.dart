import 'package:bloc/bloc.dart';
import 'package:football/core/services/notification_service.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';

abstract class CreatePickState {}

class CreatePickInitial extends CreatePickState {}

class CreatePickLoading extends CreatePickState {}

class CreatePickSuccess extends CreatePickState {
  final PickEntity pick;
  CreatePickSuccess(this.pick);
}

class CreatePickError extends CreatePickState {
  final List<String> message;
  CreatePickError(this.message);
}

class CreatePickCubit extends Cubit<CreatePickState> {
  final MatchesRepository repository;

  CreatePickCubit({required this.repository}) : super(CreatePickInitial());

  Future<void> submitPick({
    required MatchEntity match,
    required double stake,
    required OutcomeType outcomeType,
    required int confidence,
    required String note,
    required bool remind,
  }) async {
    emit(CreatePickLoading());

    try {
      final isStarted = await repository.isMatchStarted(match.id);
      if (isStarted) {
        emit(CreatePickError(['TOO LATE', 'This match has already started']));
        return;
      }

      double selectedOdd = 1.0;
      if (match.odd != null) {
        switch (outcomeType) {
          case OutcomeType.home:
            selectedOdd = match.odd!.home;
            break;
          case OutcomeType.draw:
            selectedOdd = match.odd!.draw;
            break;
          case OutcomeType.away:
            selectedOdd = match.odd!.away;
            break;
        }
      }

      final newPick = PickEntity(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        matchId: match.id,
        stake: stake,
        outcomeType: outcomeType,
        note: note.isEmpty ? null : note,
        confidence: confidence,
        remind: remind,
        whenComplete: DateTime.parse(match.date.toString()),
        status: PickStatus.wait,
        odd: selectedOdd,
      );

      await repository.savePickLocal(newPick);

      if (remind) {
        final matchTitle = '${match.homeTeam.name} vs ${match.awayTeam.name}';
        await NotificationService().scheduleMatchReminder(
          pickId: newPick.id,
          matchTitle: matchTitle,
          matchTime: match.date,
        );
      }

      emit(CreatePickSuccess(newPick));
    } catch (e) {
      emit(CreatePickError(["Failed to save pick: $e"]));
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';
import 'package:football/features/picks/presentation/cubit/create_picks_cubit.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:football/features/picks/presentation/widgets/info_dialog.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/core/widgets/action_button.dart';
import 'package:football/core/widgets/custom_text_field.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:football/features/match_details/presentation/widgets/standing_widget.dart';
import 'package:football/features/picks/presentation/widgets/custom_slider.dart';
import 'package:football/features/picks/presentation/widgets/outcome_selector.dart';
import 'package:football/features/picks/presentation/widgets/remind_widget.dart';

import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';

class CreatePickPage extends StatelessWidget {
  final MatchEntity match;

  const CreatePickPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<CreatePickCubit>()),
        BlocProvider.value(value: GetIt.I<PicksCubit>()),
      ],
      child: _CreatePickView(match: match),
    );
  }
}

class _CreatePickView extends StatefulWidget {
  final MatchEntity match;
  const _CreatePickView({required this.match});

  @override
  State<_CreatePickView> createState() => _CreatePickViewState();
}

class _CreatePickViewState extends State<_CreatePickView> {
  final TextEditingController _stakeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  double _sliderValue = 3;
  bool _remindMe = false;
  OutcomeType _selectedOutcome = OutcomeType.home;

  @override
  void initState() {
    super.initState();
    final matchesCubit = GetIt.I<MatchesCubit>();
    _remindMe = matchesCubit.notifiedMatchIds.contains(widget.match.id);
  }

  OutcomeType _mapWidgetOutcomeToEntity(Outcome outcome) {
    switch (outcome) {
      case Outcome.home:
        return OutcomeType.home;
      case Outcome.draw:
        return OutcomeType.draw;
      case Outcome.away:
        return OutcomeType.away;
    }
  }

  Outcome _mapEntityOutcomeToWidget(OutcomeType type) {
    switch (type) {
      case OutcomeType.home:
        return Outcome.home;
      case OutcomeType.draw:
        return Outcome.draw;
      case OutcomeType.away:
        return Outcome.away;
    }
  }

  DateTime _getFullDate() {
    DateTime date = widget.match.date;
    int hour = 0;
    int minute = 0;

    try {
      final parts = widget.match.time.split(':');
      if (parts.length == 2) {
        hour = int.parse(parts[0]);
        minute = int.parse(parts[1]);
      }
    } catch (_) {}

    return DateTime.utc(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    ).toLocal();
  }

  @override
  void dispose() {
    _stakeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSave() {
    final stakeText = _stakeController.text.replaceAll(',', '.');
    final stake = double.tryParse(stakeText) ?? 0.0;

    context.read<CreatePickCubit>().submitPick(
      match: widget.match,
      stake: stake,
      outcomeType: _selectedOutcome,
      confidence: _sliderValue.toInt(),
      note: _noteController.text,
      remind: _remindMe,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(
        leading: LayoutBackButton(onTap: context.pop),
        centerTittle: true,
        tittle: Text(
          'CREATE PICK',
          style: MyStyles.h1.copyWith(color: MyColors.yellow),
        ),
      ),
      body: BlocListener<CreatePickCubit, CreatePickState>(
        listener: (context, state) {
          if (state is CreatePickLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is CreatePickError) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              barrierColor: Color(0xFF505050).withValues(alpha: 0.6),
              context: context,
              builder: (context) => InfoDialog(message: state.message),
            );
          } else if (state is CreatePickSuccess) {
            Navigator.of(context, rootNavigator: true).pop();

            context.read<PicksCubit>().addPickLocally(state.pick, widget.match);

            final matchesCubit = GetIt.I<MatchesCubit>();
            final watchlistCubit = GetIt.I<WatchlistCubit>();

            final isAlreadyNotified = matchesCubit.notifiedMatchIds.contains(
              widget.match.id,
            );

            if (_remindMe) {
              if (!watchlistCubit.isMatchSaved(widget.match.id)) {
                watchlistCubit.toggleMatch(widget.match);
              }
              if (!isAlreadyNotified) {
                matchesCubit.toggleNotification(
                  matchId: widget.match.id,
                  matchTitle:
                      '${widget.match.homeTeam.name} vs ${widget.match.awayTeam.name}',
                  matchTime: _getFullDate(),
                );
              }
            } else {
              if (isAlreadyNotified) {
                matchesCubit.toggleNotification(
                  matchId: widget.match.id,
                  matchTitle: '',
                  matchTime: DateTime.now(),
                );
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Pick saved successfully!"),
                backgroundColor: MyColors.yellow,
              ),
            );
            context.pop();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandingWidget(match: widget.match),

                    Text('Outcome selector', style: MyStyles.bodyBold),
                    const SizedBox(height: 8),

                    OutcomeSelector(
                      selectedOutcome: _mapEntityOutcomeToWidget(
                        _selectedOutcome,
                      ),
                      onChanged: (outcome) {
                        setState(() {
                          _selectedOutcome = _mapWidgetOutcomeToEntity(outcome);
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    Text('Stake (optional)', style: MyStyles.bodyBold),
                    const SizedBox(height: 4),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        'For tracking only. No real bets.',
                        style: MyStyles.medium,
                      ),
                    ),
                    const SizedBox(height: 4),

                    CustomTextField(
                      controller: _stakeController,
                      hintText: 'e.g. 10.00',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(5),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text('Confidence', style: MyStyles.bodyBold),
                    const SizedBox(height: 4),

                    CustomSlider(
                      value: _sliderValue,
                      max: 5,
                      min: 1,
                      activeColor: MyColors.yellow,
                      onChanged: (val) {
                        setState(() {
                          _sliderValue = val;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    Text('Note (optional)', style: MyStyles.bodyBold),
                    const SizedBox(height: 4),

                    CustomTextField(
                      controller: _noteController,
                      hintText: 'Add a quick note...',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    RemindMeWidget(
                      initialValue: _remindMe,
                      onChanged: (val) {
                        setState(() {
                          _remindMe = val;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ActionButton(onTap: _onSave, title: 'Save Pick'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

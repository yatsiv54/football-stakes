import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/widgets/action_button.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:football/features/match_details/presentation/widgets/odds_widget.dart';
import 'package:football/features/match_details/presentation/widgets/standing_widget.dart';
import 'package:football/features/match_details/presentation/widgets/venue_widget.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/match_details/presentation/widgets/league_chip.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MatchDetailsPage extends StatelessWidget {
  final MatchEntity match;
  const MatchDetailsPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = GetIt.I<WatchlistCubit>();
    return Scaffold(
      appBar: LayoutAppbar(
        leading: LayoutBackButton(onTap: context.pop),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: BlocBuilder<WatchlistCubit, WatchlistState>(
              bloc: watchlistCubit,
              builder: (context, state) {
                final isSaved = watchlistCubit.isMatchSaved(match.id);

                return GestureDetector(
                  onTap: () {
                    watchlistCubit.toggleMatch(match);
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      isSaved ? Icons.star : Icons.star_border,
                      key: ValueKey(isSaved),
                      color: MyColors.yellow,
                      size: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: LeagueChip(match: match)),
            SizedBox(height: 24),
            StandingWidget(match: match),
            OddsWidget(match: match),
            SizedBox(height: 24),
            VenueWidget(match: match),
            Spacer(),
            match.status == 'Upcoming'
                ? ActionButton(
                    onTap: () => context.push(
                      '/matches/details/createpick',
                      extra: match,
                    ),
                    title: 'Create Pick',
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

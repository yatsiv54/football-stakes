import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/features/academy/presentation/academy_page.dart';
import 'package:football/features/academy/presentation/academy_search_page.dart';
import 'package:football/features/academy/presentation/content/bankroll_content.dart';
import 'package:football/features/academy/presentation/content/beyond_content.dart';
import 'package:football/features/academy/presentation/content/mental_content.dart';
import 'package:football/features/academy/presentation/content/news_content.dart';
import 'package:football/features/academy/presentation/content/odds_content.dart';
import 'package:football/features/academy/presentation/content/steps_content.dart';
import 'package:football/features/academy/presentation/content/trap_content.dart';
import 'package:football/features/insights/presentation/insights_page.dart';
import 'package:football/features/layout/presentation/layout_scaffold.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/match_details/presentation/match_details_page.dart';
import 'package:football/features/matches/presentation/matches_page.dart';
import 'package:football/features/matches/presentation/search_page.dart';
import 'package:football/features/picks/presentation/create_pick_page.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:football/features/picks/presentation/picks_page.dart';
import 'package:football/features/settings/presentation/settings_page.dart';
import 'package:football/features/splash/splash_page.dart';
import 'package:football/features/watchlist/presentation/watchlist_page.dart';
import 'package:football/features/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'routerKey',
);

final GlobalKey<NavigatorState> _matchesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRouterKey');
final GlobalKey<NavigatorState> _picksNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellRouterKey',
);
final GlobalKey<NavigatorState> _academyNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRouterKey');
final GlobalKey<NavigatorState> _insightsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRouterKey');
final GlobalKey<NavigatorState> _settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRouterKey');

final router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(
      path: '/matches/watchlist',
      pageBuilder: (context, state) => NoTransitionPage(
        child: BlocProvider.value(
          value: GetIt.I<MatchesCubit>(),
          child: const WatchlistPage(),
        ),
      ),
    ),
    GoRoute(
      path: '/matches/search',
      pageBuilder: (context, state) => NoTransitionPage(
        child: BlocProvider.value(
          value: GetIt.I<MatchesCubit>(),
          child: SearchPage(),
        ),
      ),
    ),
    GoRoute(
      path: '/academy/search',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const AcademySearchPage()),
    ),
    GoRoute(
      path: '/academy/odds',
      pageBuilder: (context, state) => NoTransitionPage(child: OddsContent()),
    ),
    GoRoute(
      path: '/academy/steps',
      pageBuilder: (context, state) => NoTransitionPage(child: StepsContent()),
    ),
    GoRoute(
      path: '/academy/trap',
      pageBuilder: (context, state) => NoTransitionPage(child: TrapContent()),
    ),
    GoRoute(
      path: '/academy/mental',
      pageBuilder: (context, state) => NoTransitionPage(child: MentalContent()),
    ),
    GoRoute(
      path: '/academy/beyond',
      pageBuilder: (context, state) => NoTransitionPage(child: BeyondContent()),
    ),
    GoRoute(
      path: '/academy/bankroll',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: BankrollContent()),
    ),
    GoRoute(
      path: '/academy/news',
      pageBuilder: (context, state) => NoTransitionPage(child: NewsContent()),
    ),
    GoRoute(
      path: '/matches/details',
      pageBuilder: (context, state) {
        final match = state.extra as MatchEntity;
        return NoTransitionPage(child: MatchDetailsPage(match: match));
      },
    ),
    GoRoute(
      path: '/matches/details/createpick',
      pageBuilder: (context, state) {
        final match = state.extra as MatchEntity;
        return NoTransitionPage(child: CreatePickPage(match: match));
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _matchesNavigatorKey,
          routes: [
            GoRoute(
              path: '/matches',
              pageBuilder: (context, state) => NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: GetIt.I<MatchesCubit>()),

                    BlocProvider.value(
                      value: GetIt.I<PicksCubit>()..loadPicks(),
                    ),
                  ],
                  child: MatchesPage(),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _picksNavigatorKey,
          routes: [
            GoRoute(
              path: '/picks',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider.value(
                  value: GetIt.I<PicksCubit>(),
                  child: PicksPage(),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _academyNavigatorKey,
          routes: [
            GoRoute(
              path: '/academy',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: AcademyPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _insightsNavigatorKey,
          routes: [
            GoRoute(
              path: '/insights',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider.value(
                  value: GetIt.I<PicksCubit>(),
                  child: InsightsPage(),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider.value(
                  value: GetIt.I<MatchesCubit>(),
                  child: SettingsPage(),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

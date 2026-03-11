import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart'; 
import 'package:football/features/picks/presentation/cubit/create_picks_cubit.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:get_it/get_it.dart';

void loadDependencies() {
  final di = GetIt.instance;

  di.registerLazySingleton<MatchesRepository>(() => MatchesRepository());

  di.registerLazySingleton<MatchesCubit>(
    () => MatchesCubit(repository: di<MatchesRepository>()),
  );
  
  
  di.registerLazySingleton<WatchlistCubit>(
    () => WatchlistCubit(repository: di<MatchesRepository>()),
  );

  di.registerLazySingleton<PicksCubit>(
    () => PicksCubit(repository: di<MatchesRepository>()),
  );

  di.registerFactory<CreatePickCubit>(
    () => CreatePickCubit(repository: di<MatchesRepository>()),
  );
}
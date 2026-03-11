import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/picks_button.dart';
import 'package:football/features/layout/presentation/widgets/search_button.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/matches/presentation/widgets/date_switcher.dart';
import 'package:football/features/matches/presentation/widgets/filter_switcher.dart';
import 'package:football/features/matches/presentation/widgets/match_card.dart';
import 'package:football/features/matches/presentation/widgets/stat_widget.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchesCubit>().loadMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(
        needDateWidget: true,
        actions: [PicksButton(), SearchButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<MatchesCubit>().refreshMatches(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DateSwitcher(),
                SizedBox(height: 12),
                FilterSwitcher(),
                SizedBox(height: 20),
                StatWidget(),
                SizedBox(height: 20),
                BlocBuilder<MatchesCubit, MatchesCubitState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      loading: () => Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      ),

                      failure: () => Center(
                        child: Column(
                          children: [
                            Text('Error loading matches'),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MatchesCubit>().loadMatches();
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                      matchesLoaded: (matchesLoaded, _) {
                        if (matchesLoaded.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Text('No matches found'),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: matchesLoaded.length,
                          itemBuilder: (context, index) {
                            return MatchCard(match: matchesLoaded[index]);
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

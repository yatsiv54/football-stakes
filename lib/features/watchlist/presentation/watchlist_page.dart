import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:football/features/watchlist/presentation/widgets/watch_list_card.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<WatchlistCubit>()..loadWatchlist(),
      child: const _WatchlistView(),
    );
  }
}

class _WatchlistView extends StatelessWidget {
  const _WatchlistView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(
        leading: LayoutBackButton(onTap: context.pop),
        centerTittle: true,
        tittle: Text(
          'WATCHLIST',
          style: MyStyles.h1.copyWith(color: MyColors.yellow),
        ),
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return Center(
              child: CircularProgressIndicator(color: MyColors.yellow),
            );
          }

          if (state is WatchlistLoaded) {
            final matches = state.matches;

            return RefreshIndicator(
              color: MyColors.yellow,
              backgroundColor: MyColors.grey2,
              onRefresh: () async =>
                  context.read<WatchlistCubit>().loadWatchlist(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Sort by: ', style: MyStyles.body),
                        const SizedBox(width: 8),
                        _SortToggle(
                          currentSort: state.sortType,
                          onChanged: (val) {
                            context.read<WatchlistCubit>().changeSort(val);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: matches.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your watchlist is empty',
                                  style: MyStyles.body,
                                ),
                                SizedBox(height: 24),
                                InkWell(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.yellow,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        horizontal: 37,
                                        vertical: 16,
                                      ),
                                      child: Text(
                                        'Add matches',
                                        style: MyStyles.bodyBold.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: matches.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final match = matches[index];
                              return WatchListCard(
                                key: ValueKey(match.id),
                                match: match,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SortToggle extends StatelessWidget {
  final WatchlistSort currentSort;
  final ValueChanged<WatchlistSort> onChanged;

  const _SortToggle({required this.currentSort, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: MyColors.grey1,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SortButton(
            label: 'Kickoff time',
            isActive: currentSort == WatchlistSort.kickoffTime,
            onTap: () => onChanged(WatchlistSort.kickoffTime),
          ),
          _SortButton(
            label: 'League',
            isActive: currentSort == WatchlistSort.league,
            onTap: () => onChanged(WatchlistSort.league),
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SortButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 114,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2F2F2F) : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          label,
          style: MyStyles.bodyBold.copyWith(
            color: isActive ? MyColors.yellow : Colors.white,
          ),
        ),
      ),
    );
  }
}

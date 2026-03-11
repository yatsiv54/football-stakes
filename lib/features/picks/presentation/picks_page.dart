import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/picks_title.dart';
import 'package:football/features/picks/data/models/pick_with_match.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:football/features/picks/presentation/widgets/delete_dialog.dart';
import 'package:football/features/picks/presentation/widgets/pick_card.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

enum PickFilter { all, open, settled, wins, losses }

class PicksPage extends StatelessWidget {
  const PicksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<PicksCubit>(),
      child: const _PicksView(),
    );
  }
}

class _PicksView extends StatefulWidget {
  const _PicksView();

  @override
  State<_PicksView> createState() => _PicksViewState();
}

class _PicksViewState extends State<_PicksView> {
  PickFilter _currentFilter = PickFilter.all;

  List<PickWithMatch> _getFilteredList(List<PickWithMatch> allPicks) {
    switch (_currentFilter) {
      case PickFilter.all:
        return allPicks;
      case PickFilter.open:
        return allPicks
            .where((p) => p.status == CalculatedPickStatus.open)
            .toList();
      case PickFilter.settled:
        return allPicks
            .where((p) => p.status != CalculatedPickStatus.open)
            .toList();
      case PickFilter.wins:
        return allPicks
            .where((p) => p.status == CalculatedPickStatus.win)
            .toList();
      case PickFilter.losses:
        return allPicks
            .where((p) => p.status == CalculatedPickStatus.loss)
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(tittle: PicksTitle()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _currentFilter == PickFilter.all,
                    onTap: () =>
                        setState(() => _currentFilter = PickFilter.all),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Open',
                    isSelected: _currentFilter == PickFilter.open,
                    onTap: () =>
                        setState(() => _currentFilter = PickFilter.open),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Settled',
                    isSelected: _currentFilter == PickFilter.settled,
                    onTap: () =>
                        setState(() => _currentFilter = PickFilter.settled),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Wins',
                    isSelected: _currentFilter == PickFilter.wins,
                    onTap: () =>
                        setState(() => _currentFilter = PickFilter.wins),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Losses',
                    isSelected: _currentFilter == PickFilter.losses,
                    onTap: () =>
                        setState(() => _currentFilter = PickFilter.losses),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<PicksCubit, PicksState>(
              builder: (context, state) {
                if (state is PicksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PicksError) {
                  return Center(child: Text(state.message));
                }
                if (state is PicksLoaded) {
                  final filteredList = _getFilteredList(state.picks);

                  return RefreshIndicator(
                    color: MyColors.yellow,
                    backgroundColor: MyColors.grey2,
                    onRefresh: () async {
                      await context.read<PicksCubit>().loadPicks(
                        isRefresh: true,
                      );
                    },
                    child: filteredList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No picks yet', style: MyStyles.body),
                                const SizedBox(height: 24),
                                InkWell(
                                  onTap: () {
                                    context.go('/matches/');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.yellow,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 37,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      'Browse Matches',
                                      style: MyStyles.bodyBold.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            itemCount: filteredList.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = filteredList[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Slidable(
                                    key: Key(
                                      '${item.pick.matchId}_${item.pick.outcomeType}_${item.pick.stake}',
                                    ),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      extentRatio: 0.25,
                                      children: [
                                        CustomSlidableAction(
                                          padding: EdgeInsets.zero,
                                          onPressed: (context) async {
                                            final cubit = context
                                                .read<PicksCubit>();

                                            final shouldDelete =
                                                await showDialog<bool>(
                                                  context: context,
                                                  barrierColor: const Color(
                                                    0xFF505050,
                                                  ).withOpacity(0.6),
                                                  builder: (_) =>
                                                      const DeletePickDialog(),
                                                );

                                            if (shouldDelete == true) {
                                              cubit.deletePick(item);
                                            }
                                          },
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/icons/delete.png',
                                                width: 24,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Delete',
                                                style: MyStyles.bodyBold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: PickCard(pickWithMatch: item),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.grey1 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.grey1, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: MyStyles.body.copyWith(
              color: isSelected ? MyColors.yellow : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

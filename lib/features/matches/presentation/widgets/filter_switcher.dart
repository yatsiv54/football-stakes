import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/enums/league_filter.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';

class FilterSwitcher extends StatelessWidget {
  const FilterSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, MatchesCubitState>(
      builder: (context, state) {
        final cubit = context.read<MatchesCubit>();
        final currentFilter = cubit.currentLeagueFilter;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: LeagueFilter.values.map((filter) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: filter.label,
                  isSelected: currentFilter == filter,
                  onTap: () => cubit.changeLeagueFilter(filter),
                ),
              );
            }).toList(),
          ),
        );
      },
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.grey1 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.grey2, width: 0.8),
        ),
        child: Text(
          label,
          style: MyStyles.body.copyWith(
            color: isSelected ? MyColors.yellow : Colors.white,
          ),
        ),
      ),
    );
  }
}

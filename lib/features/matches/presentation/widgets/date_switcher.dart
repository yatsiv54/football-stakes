import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/enums/date_filter.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';

class DateSwitcher extends StatelessWidget {
  const DateSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, MatchesCubitState>(
      builder: (context, state) {
        final cubit = context.read<MatchesCubit>();
        final currentFilter = cubit.currentDateFilter;
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyColors.grey1,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              _DateButton(
                label: DateFilter.yesterday.label,
                isSelected: currentFilter == DateFilter.yesterday,
                onTap: () => cubit.changeDateFilter(DateFilter.yesterday),
              ),
              SizedBox(width: 8),
              _DateButton(
                label: DateFilter.today.label,
                isSelected: currentFilter == DateFilter.today,
                onTap: () => cubit.changeDateFilter(DateFilter.today),
              ),
              SizedBox(width: 8),
              _DateButton(
                label: DateFilter.tomorrow.label,
                isSelected: currentFilter == DateFilter.tomorrow,
                onTap: () => cubit.changeDateFilter(DateFilter.tomorrow),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? MyColors.grey2 : Colors.transparent,
            borderRadius: BorderRadius.circular(240),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: MyStyles.bodyBold.copyWith(
              color: isSelected ? MyColors.yellow : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

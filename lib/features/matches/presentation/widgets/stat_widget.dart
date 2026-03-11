import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart'; 

class StatWidget extends StatelessWidget {
  const StatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<PicksCubit, PicksState>(
      builder: (context, state) {
        
        String picksCount = '0';
        String openCount = '0';
        String hitRate = '0%';

        if (state is PicksLoaded) {
          picksCount = state.stats.total.toString();
          openCount = state.stats.open.toString();
          hitRate = state.stats.hitRate;
        }

        return SizedBox(
          height: 116,
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: _StatChip(
                  icon: 'assets/images/icons/doc.png',
                  title: 'Picks',
                  data: picksCount, 
                ),
              ),
              Expanded(
                child: _StatChip(
                  icon: 'assets/images/icons/clock.png',
                  title: 'Open',
                  data: openCount, 
                ),
              ),
              Expanded(
                child: _StatChip(
                  icon: 'assets/images/icons/graph.png',
                  title: 'Hit Rate',
                  data: hitRate, 
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.title,
    required this.data,
  });
  final String icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.yellow.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.yellow),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 24, height: 24, child: Image.asset(icon)),
          const SizedBox(height: 8),
          Text(
            title,
            style: MyStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          Text(data, style: MyStyles.bodyBold),
        ],
      ),
    );
  }
}
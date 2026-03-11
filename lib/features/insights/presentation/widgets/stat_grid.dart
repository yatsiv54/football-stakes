import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';

class StatGrid extends StatefulWidget {
  const StatGrid({super.key});

  @override
  State<StatGrid> createState() => _StatGridState();
}

class _StatGridState extends State<StatGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicksCubit, PicksState>(
      builder: (context, state) {
        String picksCount = '0';
        String settled = '0';
        String winrate = '0%';
        String avgOdds = '0';
        String roi = '0';

        if (state is PicksLoaded) {
          picksCount = state.stats.total.toString();
          settled = state.stats.settled.toString();
          winrate = state.stats.winRate.toString();
          avgOdds = state.stats.avgOdds.toString();
          roi = state.stats.roi.toString();
        }

        return Column(
          children: [
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 56,
              ),
              children: [
                StatContainer(title: 'Total Picks', data: picksCount),
                StatContainer(title: 'Settled', data: settled),
                StatContainer(title: 'Win Rate', data: winrate),
                StatContainer(title: 'Avg Odds', data: avgOdds),
              ],
            ),
            SizedBox(height: 12),
            StatContainer(title: 'ROI', data: roi),
          ],
        );
      },
    );
  }
}

class StatContainer extends StatelessWidget {
  final String title;
  final String data;
  const StatContainer({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.yellow.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: MyColors.yellow),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyStyles.body.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            Text(data, style: MyStyles.bodyBold),
          ],
        ),
      ),
    );
  }
}

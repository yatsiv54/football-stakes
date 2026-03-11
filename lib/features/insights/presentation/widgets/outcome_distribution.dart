import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';

class OutcomeDistributionChart extends StatelessWidget {
  const OutcomeDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicksCubit, PicksState>(
      builder: (context, state) {
        double home = 0;
        double draw = 0;
        double away = 0;

        if (state is PicksLoaded) {
          home = state.stats.homePercent;
          draw = state.stats.drawPercent;
          away = state.stats.awayPercent;
        }

        if (home == 0 && draw == 0 && away == 0) {
          home = 100;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.grey1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Outcome Distribution', style: MyStyles.h3),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 42,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                            color: MyColors.green,
                            value: home,
                            title: '',
                            radius: 34,
                          ),
                          PieChartSectionData(
                            color: MyColors.yellow,
                            value: draw,
                            title: '',
                            radius: 34,
                          ),
                          PieChartSectionData(
                            color: MyColors.red,
                            value: away,
                            title: '',
                            radius: 34,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _LegendItem(
                          color: MyColors.green,
                          label: 'Home',
                          percent: home,
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: MyColors.yellow,
                          label: 'Draw',
                          percent: draw,
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: MyColors.red,
                          label: 'Away',
                          percent: away,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final double percent;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: MyStyles.body),
            ],
          ),
          Text('${percent.toStringAsFixed(0)}%', style: MyStyles.bodyBold),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';

class ConfidenceChart extends StatelessWidget {
  const ConfidenceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicksCubit, PicksState>(
      builder: (context, state) {
        double lowPct = 0;
        double medPct = 0;
        double highPct = 0;

        String lowText = '0% wins';
        String medText = '0% wins';
        String highText = '0% wins';

        if (state is PicksLoaded) {
          lowPct = state.stats.lowConfPercent;
          medPct = state.stats.medConfPercent;
          highPct = state.stats.highConfPercent;

          lowText = state.stats.lowConfWinRate;
          medText = state.stats.medConfWinRate;
          highText = state.stats.highConfWinRate;
        }

        bool isEmpty = lowPct == 0 && medPct == 0 && highPct == 0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.grey1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Confidence vs Result', style: MyStyles.h3),
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
                        sections: isEmpty
                            ? [
                                PieChartSectionData(
                                  color: MyColors.grey3,
                                  value: 100,
                                  title: '',
                                  radius: 34,
                                ),
                              ]
                            : [
                                PieChartSectionData(
                                  color: MyColors.green,
                                  value: lowPct,
                                  title: '',
                                  radius: 34,
                                ),

                                PieChartSectionData(
                                  color: MyColors.yellow,
                                  value: medPct,
                                  title: '',
                                  radius: 34,
                                ),

                                PieChartSectionData(
                                  color: MyColors.red,
                                  value: highPct,
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
                          label: 'Confidence 1–2',
                          valueText: lowText,
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: MyColors.yellow,
                          label: 'Confidence 3',
                          valueText: medText,
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: MyColors.red,
                          label: 'Confidence 4–5',
                          valueText: highText,
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
  final String valueText;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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
          SizedBox(height: 4),
          Text(valueText, style: MyStyles.bodyBold),
        ],
      ),
    );
  }
}

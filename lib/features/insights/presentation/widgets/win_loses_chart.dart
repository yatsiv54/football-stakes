import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';

class WinsLossesChart extends StatelessWidget {
  const WinsLossesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicksCubit, PicksState>(
      builder: (context, state) {
        List<WeeklyStats> data = [];
        if (state is PicksLoaded) {
          data = state.stats.weeklyStats;
        }

        if (data.isEmpty) {
          data = List.generate(4, (index) => WeeklyStats(index + 1, 0, 0));
        }

        double maxY = 10;
        for (var w in data) {
          if (w.wins > maxY) maxY = w.wins.toDouble();
          if (w.losses > maxY) maxY = w.losses.toDouble();
        }
        

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: MyColors.grey1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Wins vs Losses', style: MyStyles.h3),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 1.4,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Week ${value.toInt()}',
                                style: MyStyles.body,
                              ),
                            );
                          },
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: MyStyles.body,
                            );
                          },
                          reservedSize: 28,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (value) => value % 2 == 0,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.white.withValues(alpha: 0.09),
                        strokeWidth: 1,
                      ),
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    barGroups: data.map((week) {
                      return BarChartGroupData(
                        x: week.weekNumber,
                        barRods: [
                          BarChartRodData(
                            toY: week.losses.toDouble(),
                            color: MyColors.red,
                            width: 16,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          BarChartRodData(
                            toY: week.wins.toDouble(),
                            color: MyColors.green,
                            width: 16,
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/insights/presentation/widgets/confidence_chart.dart';
import 'package:football/features/insights/presentation/widgets/outcome_distribution.dart';
import 'package:football/features/insights/presentation/widgets/stat_grid.dart';
import 'package:football/features/insights/presentation/widgets/win_loses_chart.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(
        tittle: Text(
          'INSIGHTS',
          style: MyStyles.h1.copyWith(color: MyColors.yellow),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const StatGrid(),
              const SizedBox(height: 16),
              const WinsLossesChart(),
              const SizedBox(height: 16),
              const OutcomeDistributionChart(),
              const SizedBox(height: 16),
              const ConfidenceChart(),
            ],
          ),
        ),
      ),
    );
  }
}

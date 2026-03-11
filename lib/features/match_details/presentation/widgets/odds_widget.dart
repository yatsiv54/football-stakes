import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';

class OddsWidget extends StatelessWidget {
  const OddsWidget({super.key, required this.match});
  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _OddColumn(odd: match.odd?.home, title: 'Home'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _OddColumn(odd: match.odd?.draw, title: 'Draw'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _OddColumn(odd: match.odd?.away, title: 'Away'),
          ),
        ],
      ),
    );
  }
}

class _OddColumn extends StatelessWidget {
  const _OddColumn({required this.odd, required this.title});
  final String title;
  final double? odd;

  String _calculateImpliedProbability(double? oddValue) {
    if (oddValue == null || oddValue <= 1.0) {
      return 'Implied: -';
    }

    final probability = (1 / oddValue) * 100;

    return 'Implied: ${probability.toStringAsFixed(1)}%';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(opacity: 0.5, child: Text(title, style: MyStyles.medium)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          decoration: BoxDecoration(
            color: MyColors.grey2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                odd != null ? odd.toString() : '-',
                style: MyStyles.bodyBold,
              ),
              const SizedBox(height: 4),

              Opacity(
                opacity: 0.6,
                child: Text(
                  _calculateImpliedProbability(odd),
                  style: MyStyles.medium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

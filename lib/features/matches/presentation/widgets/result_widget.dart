import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';

class ResultWidget extends StatelessWidget {
  final MatchEntity match;
  const ResultWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.grey4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Text(
          '${match.score.home} — ${match.score.away}',
          style: MyStyles.h1,
        ),
      ),
    );
  }
}

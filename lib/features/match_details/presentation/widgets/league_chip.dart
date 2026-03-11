import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';

class LeagueChip extends StatelessWidget {
  final MatchEntity match;
  const LeagueChip({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: SizedBox(
                width: 24,
                child: Image.network(
                  match.leagueLogo,
                  scale: 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(match.league, style: MyStyles.medium),
          ],
        ),
      ),
    );
  }
}

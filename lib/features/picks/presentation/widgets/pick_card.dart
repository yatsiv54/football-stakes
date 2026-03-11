
import 'package:flutter/material.dart';

import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/picks/data/entities/pick_entity.dart';
import 'package:football/features/picks/data/models/pick_with_match.dart';
import 'package:intl/intl.dart';

class PickCard extends StatelessWidget {
  final PickWithMatch pickWithMatch;
  const PickCard({required this.pickWithMatch});

  @override
  Widget build(BuildContext context) {
    final match = pickWithMatch.match;
    final pick = pickWithMatch.pick;
    final calculatedStatus = pickWithMatch.status;

    String statusText;
    Color statusColor;

    switch (calculatedStatus) {
      case CalculatedPickStatus.win:
        statusText = 'WIN';
        statusColor = MyColors.green;
        break;
      case CalculatedPickStatus.loss:
        statusText = 'LOSS';
        statusColor = MyColors.red;
        break;
      case CalculatedPickStatus.open:
        statusText = 'OPEN';
        statusColor = MyColors.yellow;
        break;
    }

    final dateStr = DateFormat('E MMM d | ${match.time}').format(match.date);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    match.leagueLogo,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(match.league, style: MyStyles.medium)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: MyColors.grey1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    dateStr,
                    style: MyStyles.medium.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                  Spacer(),
                  Text(
                    statusText,
                    style: MyStyles.bodyBold.copyWith(color: statusColor),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: MyColors.grey3,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 32,
                              child: Image.network(match.homeTeam.logo),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                match.homeTeam.name,
                                style: MyStyles.bodyBold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Image.network(match.awayTeam.logo),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                match.awayTeam.name,
                                style: MyStyles.bodyBold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 46,
                            decoration: BoxDecoration(
                              color: MyColors.grey4,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: match.status == 'Upcoming'
                                  ? Text(
                                      '—',
                                      style: MyStyles.h2.copyWith(
                                        color: MyColors.yellow.withAlpha(120),
                                      ),
                                    )
                                  : Text(
                                      '${match.score.home}–${match.score.away}',
                                      style: MyStyles.h2.copyWith(
                                        color: MyColors.yellow,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: MyColors.grey2,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _outcomeName(pick.outcomeType),
                                        style: MyStyles.bodyBold,
                                      ),
                                      TextSpan(text: ' '),
                                      TextSpan(
                                        text: pick.odd.toString(),
                                        style: MyStyles.body,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Stake: ${pick.stake} | Confidence: ${pick.confidence}/5',
                        style: MyStyles.medium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _outcomeName(OutcomeType type) {
    switch (type) {
      case OutcomeType.home:
        return "Home";
      case OutcomeType.draw:
        return "Draw";
      case OutcomeType.away:
        return "Away";
    }
  }
}

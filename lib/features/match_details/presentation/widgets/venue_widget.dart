import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';

class VenueWidget extends StatelessWidget {
  const VenueWidget({super.key, required this.match});
  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyColors.grey2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 19),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Image.asset('assets/images/icons/pin.png'),
                ),
                SizedBox(width: 8),
                Expanded(child: Text('Venue', style: MyStyles.h2)),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyColors.grey4,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.grey1,
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Country', style: MyStyles.body),
                        Text(match.country, style: MyStyles.bodyBold),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.grey1,
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stadium', style: MyStyles.body),
                        Text(
                          match.stadium == '' ? '—' : match.stadium,
                          style: MyStyles.bodyBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

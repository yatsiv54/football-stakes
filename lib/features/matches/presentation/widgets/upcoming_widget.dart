import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 48,
            decoration: BoxDecoration(
              color: MyColors.grey2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('1', style: MyStyles.bodyBold)),
          ),
          Container(
            width: 48,
            decoration: BoxDecoration(
              color: MyColors.grey2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('X', style: MyStyles.bodyBold)),
          ),
          Container(
            width: 48,
            decoration: BoxDecoration(
              color: MyColors.grey2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('2', style: MyStyles.bodyBold)),
          ),
        ],
      ),
    );
  }
}

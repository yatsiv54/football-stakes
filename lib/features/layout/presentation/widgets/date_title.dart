import 'package:flutter/material.dart';
import 'package:football/core/helpers/date_helper.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class DateTitle extends StatelessWidget {
  DateTitle({super.key});

  final parts = getDateForAppbar().split(', ');

  @override
  Widget build(BuildContext context) {
    return RichText(
      
      text: TextSpan(
        children: [
          TextSpan(
            text: '${parts[0]}, ',
            style: MyStyles.h1.copyWith(color: MyColors.yellow),
          ),
          TextSpan(text: parts[1], style: MyStyles.h1),
        ],
      ),
    );
  }
}

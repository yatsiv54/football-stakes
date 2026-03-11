import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class PicksTitle extends StatelessWidget {
  const PicksTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'MY',
            style: MyStyles.h1.copyWith(color: MyColors.yellow),
          ),
          TextSpan(text: ' PICKS', style: MyStyles.h1),
        ],
      ),
    );
  }
}

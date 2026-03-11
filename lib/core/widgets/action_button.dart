import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.yellow,
        ),
        child: Center(
          child: Text(
            title,
            style: MyStyles.bodyBold.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

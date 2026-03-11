import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';

class LayoutBackButton extends StatelessWidget {
  const LayoutBackButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.arrow_back_ios_new_sharp,
        color: MyColors.yellow,
        size: 20,
      ),
    );
  }
}

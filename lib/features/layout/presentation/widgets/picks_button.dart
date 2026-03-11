import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:go_router/go_router.dart';

class PicksButton extends StatelessWidget {
  const PicksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.push('/matches/watchlist');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.star, color: MyColors.yellow, size: 28),
      ),
    );
  }
}
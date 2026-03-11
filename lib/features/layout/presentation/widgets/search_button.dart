import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:go_router/go_router.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.grey1,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10),
          width: 44,
          child: SizedBox(child: Image.asset('assets/images/icons/search.png')),
        ),
      ),
      onTap: () {
        context.push('/matches/search');
      },
    );
  }
}

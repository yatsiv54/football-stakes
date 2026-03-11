import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> _categories = const [
    "All",
    "Getting Started",
    "Odds",
    "Process",
    "Bankroll",
    "Mindset",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: _ChipItem(label: category, isSelected: isSelected),
          );
        },
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _ChipItem({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.grey2 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : MyColors.grey2,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: MyStyles.body.copyWith(
          color: isSelected ? MyColors.yellow : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

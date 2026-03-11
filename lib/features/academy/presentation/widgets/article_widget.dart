import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';



class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? MyColors.grey2 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : MyColors.grey2,
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: MyStyles.medium.copyWith(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}



class ArticleHeader extends StatelessWidget {
  final String text;
  const ArticleHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: MyStyles.h2.copyWith(height: 1.2, color: Colors.white),
      ),
    );
  }
}



class ArticleSubHeader extends StatelessWidget {
  final String text;
  const ArticleSubHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: MyStyles.h3.copyWith(
          fontSize: 18, 
          height: 1.3,
        ),
      ),
    );
  }
}



class ArticleParagraph extends StatelessWidget {
  final String text;
  const ArticleParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        text,
        style: MyStyles.body.copyWith(color: Colors.white, height: 1.5),
      ),
    );
  }
}



class FormulaBox extends StatelessWidget {
  final String text;
  const FormulaBox(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: MyColors.grey2, 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: MyStyles.bodyBold.copyWith(color: MyColors.yellow, fontSize: 16),
      ),
    );
  }
}



class ArticleBulletList extends StatelessWidget {
  final List<String> items;
  const ArticleBulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "•",
                style: MyStyles.bodyBold.copyWith(color: Colors.white70),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: MyStyles.body.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

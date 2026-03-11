import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/academy/data/academy_data.dart';
import 'package:football/features/academy/presentation/widgets/academy_card.dart';
import 'package:football/features/academy/presentation/widgets/category_chips.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:go_router/go_router.dart';

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _selectedCategory == 'All'
        ? academyArticles
        : academyArticles
              .where((a) => a.category == _selectedCategory)
              .toList();

    return Scaffold(
      appBar: LayoutAppbar(
        tittle: Text(
          'ACADEMY',
          style: MyStyles.h1.copyWith(color: MyColors.yellow),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              context.push('/academy/search');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.grey1,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                width: 44,
                child: SizedBox(
                  child: Image.asset('assets/images/icons/search.png'),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          CategoryChips(
            selectedCategory: _selectedCategory,
            onCategorySelected: (newCategory) {
              setState(() {
                _selectedCategory = newCategory;
              });
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                children: filteredArticles.map((article) {
                  return AcademyCard(
                    onTap: () => context.push(article.route),
                    img: article.img,
                    title: article.title,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

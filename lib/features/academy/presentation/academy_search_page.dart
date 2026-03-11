import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

import 'package:football/features/academy/data/academy_data.dart';
import 'package:football/features/academy/presentation/widgets/academy_card.dart';
import 'package:go_router/go_router.dart';

class AcademySearchPage extends StatefulWidget {
  const AcademySearchPage({super.key});

  @override
  State<AcademySearchPage> createState() => _AcademySearchPageState();
}

class _AcademySearchPageState extends State<AcademySearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<AcademyArticle> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    _filteredArticles = academyArticles;
  }

  void _search(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredArticles = academyArticles;
      } else {
        _filteredArticles = academyArticles
            .where(
              (article) =>
                  article.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.grey1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: Image.asset('assets/images/icons/search.png'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            style: MyStyles.body,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Search academy...',
                              hintStyle: MyStyles.body,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: _search,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: MyStyles.bodyBold.copyWith(color: MyColors.yellow),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredArticles.isEmpty
                  ? Center(
                      child: Text(
                        'Nothing found',
                        style: MyStyles.body.copyWith(color: Colors.white54),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: _filteredArticles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final article = _filteredArticles[index];
                        return AcademyCard(
                          onTap: () => context.push(article.route),
                          img: article.img,
                          title: article.title,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

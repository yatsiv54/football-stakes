import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class BeyondContent extends StatelessWidget {
  const BeyondContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppbar(leading: LayoutBackButton(onTap: context.pop)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    fit: BoxFit.cover,

                    image: AssetImage('assets/images/academy/beyond.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const ArticleHeader('Form Beyond W-L: What to Look At'),

              const ArticleParagraph(
                'Looking only at wins and losses is one of the most common mistakes in football analysis. Results matter, but they often hide what’s really happening on the pitch. A team can win while playing poorly, or lose while showing strong underlying performance. To make better picks, you need to read form beneath the scoreline.',
              ),

              const ArticleSubHeader('Why win–loss form is misleading'),
              const ArticleParagraph(
                'Football is a low-scoring sport. A single goal, deflection, or referee decision can completely change the result. Over short periods:',
              ),
              const ArticleBulletList(
                items: [
                  'Bad teams can win matches',
                  'Strong teams can lose despite dominance',
                  'Variance can distort reality',
                ],
              ),
              const ArticleParagraph(
                'That’s why professional analysis focuses on process, not just outcomes.',
              ),

              const ArticleSubHeader('1) Chance creation and chance quality'),
              const ArticleParagraph('Instead of asking “Did they win?”, ask:'),
              const ArticleBulletList(
                items: [
                  'How many chances did they create?',
                  'How many chances did they allow?',
                  'Were those chances clear or low quality?',
                ],
              ),
              const ArticleParagraph('Key indicators to watch:'),
              const ArticleBulletList(
                items: [
                  'Shots inside the box',
                  'Big chances created',
                  'Expected goals (xG), if available',
                ],
              ),
              const ArticleParagraph(
                'A team consistently creating more and better chances than their opponents is usually in good form — even if recent results don’t show it yet.',
              ),

              const ArticleSubHeader('2) Game control and match flow'),
              const ArticleParagraph(
                'Some teams win by controlling games; others survive chaos.',
              ),
              const ArticleParagraph('Look for:'),
              const ArticleBulletList(
                items: [
                  'Possession with purpose (not just sideways passes)',
                  'Ability to control tempo after scoring',
                  'How teams respond after conceding',
                ],
              ),
              const ArticleParagraph('Warning signs:'),
              const ArticleBulletList(
                items: [
                  'Teams that score early but immediately sit deep',
                  'Constant last-ditch defending',
                  'Reliance on goalkeeper heroics',
                ],
              ),
              const ArticleParagraph(
                'If a team keeps losing control after taking the lead, their results are fragile.',
              ),

              const ArticleSubHeader('3) Home vs away form (separately)'),
              const ArticleParagraph(
                'Overall form hides important context. Always split:',
              ),
              const ArticleBulletList(items: ['Home form', 'Away form']),
              const ArticleParagraph('Some teams:'),
              const ArticleBulletList(
                items: [
                  'Press aggressively at home',
                  'Sit deep away',
                  'Struggle with travel or hostile environments',
                ],
              ),
              const ArticleParagraph(
                'A “good form” team may actually be strong only at home — which matters greatly when evaluating the next fixture.',
              ),

              const ArticleSubHeader('4) Defensive stability (or lack of it)'),
              const ArticleParagraph(
                'Defense isn’t just about goals conceded. Look deeper:',
              ),
              const ArticleBulletList(
                items: [
                  'Are they conceding early?',
                  'Are they vulnerable to set pieces?',
                  'Do they allow many shots from dangerous zones?',
                ],
              ),
              const ArticleParagraph(
                'Teams conceding few goals despite allowing many chances are often overperforming. That usually corrects itself over time.',
              ),

              const ArticleSubHeader('5) Opponent quality matters'),
              const ArticleParagraph(
                'A winning streak means little without context.',
              ),
              const ArticleParagraph('Ask:'),
              const ArticleBulletList(
                items: [
                  'Who did they beat?',
                  'Were those teams in good shape?',
                  'Were matches home or away?',
                ],
              ),
              const ArticleParagraph(
                'Three wins against bottom-table teams don’t equal one strong performance against a top side. Always adjust form based on opposition strength.',
              ),

              const ArticleSubHeader('6) Trends, not single matches'),
              const ArticleParagraph(
                'Form is about patterns, not one-off games.',
              ),
              const ArticleParagraph('Focus on:'),
              const ArticleBulletList(
                items: [
                  'Last 5–6 matches',
                  'Repeating strengths or weaknesses',
                  'Improvement or decline over time',
                ],
              ),
              const ArticleParagraph(
                'One bad match doesn’t mean bad form. Repeated issues do.',
              ),

              const ArticleSubHeader('Practical takeaway'),
              const ArticleParagraph(
                'Before saving a pick, summarize form in one sentence:',
              ),
              const ArticleBulletList(
                items: [
                  '“Creating chances but finishing poorly”',
                  '“Winning games but allowing too many shots”',
                  '“Strong at home, fragile away”',
                ],
              ),
              const FormulaBox(
                'This habit trains you to see football analytically — and helps avoid being fooled by surface-level results.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

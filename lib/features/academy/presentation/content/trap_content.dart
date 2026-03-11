import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class TrapContent extends StatelessWidget {
  const TrapContent({super.key});

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
                    
                    image: AssetImage('assets/images/academy/trap.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              
              const ArticleHeader('Why Favorites Lose: Spotting Trap Matches'),

              
              const ArticleParagraph(
                'Favorites lose more often than people expect because the “best team” isn’t always in the best situation. A trap match is usually priced like an easy win — but the conditions quietly increase volatility.\nHere’s how traps form and how to spot them.',
              ),

              
              const ArticleSubHeader(
                'Trap Signal #1 — Very short odds despite questionable form',
              ),
              const ArticleParagraph(
                'If a favorite is priced at 1.35–1.55 but looks unstable, ask why the market still trusts them.',
              ),
              const ArticleParagraph('Watch for:'),
              const ArticleBulletList(
                items: [
                  'Scraping wins vs weak sides',
                  'Conceding big chances regularly',
                  'Poor away performances',
                  'Negative body language / low intensity',
                ],
              ),
              const ArticleParagraph(
                'Short odds require a high win probability. If performance doesn’t match that probability, you may be paying too much.',
              ),

              
              const ArticleSubHeader(
                'Trap Signal #2 — Key players missing, but price barely changes',
              ),
              const ArticleParagraph(
                'This is a classic. People assume “they’re deep enough,” but certain absences matter more than others.',
              ),
              const ArticleParagraph('High-impact absences:'),
              const ArticleBulletList(
                items: [
                  'Goalkeeper',
                  'Center backs (especially both)',
                  'Main striker (if finishing relies on one player)',
                  'A system-defining midfielder (tempo/control)',
                ],
              ),
              const ArticleParagraph('If the line doesn’t move, either:'),
              const ArticleBulletList(
                items: [
                  'The market knows something you don’t',
                  'The public is blindly backing the favorite',
                ],
              ),
              const ArticleParagraph('Both are reasons to be cautious.'),

              
              const ArticleSubHeader(
                'Trap Signal #3 — Heavy schedule and hidden fatigue',
              ),
              const ArticleParagraph(
                'Favorites in Europe often trap people on weekends.',
              ),
              const ArticleParagraph('Common setup:'),
              const ArticleBulletList(
                items: [
                  'Midweek European away match',
                  'Weekend league match vs “small” opponent',
                  'Favorite rotates or plays at 80% intensity',
                  'Underdog treats it like their biggest game',
                ],
              ),
              const ArticleParagraph(
                'Fatigue increases randomness: slower transitions, late mistakes, fewer clear chances.',
              ),

              
              const ArticleSubHeader(
                'Trap Signal #4 — Underdog strong at home with a low-risk plan',
              ),
              const ArticleParagraph(
                'Some underdogs are built for “spoiling”:',
              ),
              const ArticleBulletList(
                items: [
                  'Organized low block',
                  'Strong aerial defense',
                  'Physical midfield',
                  'Dangerous counters or set pieces',
                ],
              ),
              const ArticleParagraph(
                'If the underdog can keep the match close for 60–70 minutes, the pressure shifts to the favorite. That’s where draws and upsets are born.',
              ),

              
              const ArticleSubHeader('Bonus trap signal — “Narrative odds”'),
              const ArticleParagraph(
                'Sometimes odds are shaped by reputation, not the current reality:',
              ),
              const ArticleBulletList(
                items: [
                  '“They must win”',
                  '“They’re too good”',
                  '“They always beat teams like this”',
                ],
              ),
              const FormulaBox('Narratives feel safe. Prices punish safety.'),

              
              const ArticleSubHeader('What to do when you suspect a trap'),
              const ArticleParagraph('You have three smart options:'),
              const ArticleBulletList(
                items: [
                  'Pass (often the best decision)',
                  'Lower confidence / stake',
                  'Change perspective: instead of “favorite wins,” consider whether the price is simply not worth it',
                ],
              ),
              const ArticleParagraph(
                'Even if you don’t bet alternative markets, you can still use this thinking to avoid overpaying.',
              ),

              
              const ArticleSubHeader(
                'A powerful habit: write one sentence against your pick',
              ),
              const ArticleParagraph(
                'Before saving the pick, write the best argument against it.',
              ),
              const ArticleParagraph('Example:'),
              const ArticleBulletList(
                items: [
                  '“Home is tired after midweek travel, key CB out, Away strong at home.”',
                ],
              ),
              const ArticleParagraph(
                'If you can’t produce a strong “against” sentence, you might be biased. If you can, you’re thinking like an analyst, not a fan.',
              ),

              
              const ArticleSubHeader('Remember: avoiding bad bets is winning'),
              const ArticleParagraph(
                'A lot of long-term profit is simply not stepping into overpriced favorites.',
              ),
              const FormulaBox(
                'The goal isn’t to predict every upset — it’s to avoid consistently paying the wrong price.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

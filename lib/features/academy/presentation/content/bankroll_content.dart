import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class BankrollContent extends StatelessWidget {
  const BankrollContent({super.key});

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

                    image: AssetImage('assets/images/academy/bankroll.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const ArticleHeader('Bankroll Rules for Real People'),

              const ArticleParagraph(
                'You don’t need a huge bankroll to bet responsibly — you need rules. Most bettors don’t lose because their predictions are terrible. They lose because emotions take control of money management. Good bankroll rules protect you from yourself.',
              ),

              const ArticleSubHeader('What bankroll management really is'),
              const ArticleParagraph(
                'Your bankroll is simply the money you’ve decided you can afford to lose. Nothing more.',
              ),
              const ArticleParagraph('Key mindset shift:'),
              const ArticleBulletList(
                items: [
                  'Betting is not a way to solve financial problems.',
                  'It’s a long-term decision-making game with short-term variance.',
                ],
              ),
              const ArticleParagraph(
                'If losing your bankroll would stress you, it’s too big.',
              ),

              const ArticleSubHeader('Rule 1 — Set a fixed bankroll'),
              const ArticleParagraph('Before placing a single pick:'),
              const ArticleBulletList(
                items: [
                  'Decide on a fixed amount',
                  'Separate it from daily finances',
                  'Accept that it may go to zero',
                ],
              ),
              const ArticleParagraph('Once set:'),
              const ArticleBulletList(
                items: [
                  'Do not add money impulsively',
                  'Do not “reload” after bad runs',
                ],
              ),
              const ArticleParagraph('A fixed bankroll creates discipline.'),

              const ArticleSubHeader('Rule 2 — Use a consistent stake size'),
              const ArticleParagraph(
                'The simplest and safest approach is a fixed percentage per pick.',
              ),
              const ArticleParagraph('Common guideline:'),
              const ArticleBulletList(
                items: [
                  '1–3% of bankroll per pick',
                  'Conservative bettors: closer to 1%',
                  'Higher confidence, not higher emotion',
                ],
              ),
              const ArticleParagraph('Example:'),
              const ArticleBulletList(
                items: ['Bankroll: 500', 'Stake: 10 (2%)'],
              ),
              const ArticleParagraph(
                'No matter how confident you feel, the stake stays the same.',
              ),

              const ArticleSubHeader('Rule 3 — Never chase losses'),
              const ArticleParagraph(
                'Chasing losses is the fastest way to destroy a bankroll.',
              ),
              const ArticleParagraph('Typical trap:'),
              const ArticleBulletList(
                items: [
                  'Lose one bet',
                  'Increase stake to “get it back”',
                  'Make rushed picks',
                  'Lose again',
                ],
              ),
              const ArticleParagraph(
                'Losses are normal. They don’t require action — only patience. A good rule: Your next bet should look exactly the same whether you won or lost the previous one.',
              ),

              const ArticleSubHeader('Rule 4 — Track everything'),
              const ArticleParagraph(
                'If you don’t track, you’re guessing. At minimum, track:',
              ),
              const ArticleBulletList(
                items: ['Date', 'Match', 'Odds', 'Stake', 'Result'],
              ),
              const ArticleParagraph('Tracking reveals:'),
              const ArticleBulletList(
                items: [
                  'Which leagues you understand best',
                  'Whether favorites or underdogs work better for you',
                  'If confidence levels match results',
                ],
              ),
              const ArticleParagraph(
                'Often, bettors discover they’re profitable in specific situations — and losing everywhere else.',
              ),

              const ArticleSubHeader(
                'Rule 5 — Withdraw profits (mentally or literally)',
              ),
              const ArticleParagraph(
                'When profits accumulate, two risks appear:',
              ),
              const ArticleBulletList(
                items: ['Overconfidence', 'Stake inflation'],
              ),
              const ArticleParagraph(
                'Withdrawing profits — even symbolically — helps reset discipline. It reminds you that gains are real, not just numbers on a screen.',
              ),

              const ArticleSubHeader('Rule 6 — Limit volume, not just money'),
              const ArticleParagraph(
                'Too many picks create fatigue and mistakes.',
              ),
              const ArticleParagraph('Helpful limits:'),
              const ArticleBulletList(
                items: [
                  'Maximum picks per day',
                  'Maximum picks per league',
                  'One or two “main” leagues to focus on',
                ],
              ),
              const ArticleParagraph(
                'More bets ≠ more profit. Often it’s the opposite.',
              ),

              const ArticleSubHeader(
                'Long-term thinking beats short-term results',
              ),
              const ArticleParagraph(
                'A single week means nothing. A month means little. Meaningful patterns appear over hundreds of bets.',
              ),
              const ArticleParagraph('Good bankroll management ensures:'),
              const ArticleBulletList(
                items: [
                  'You survive variance',
                  'You learn from data',
                  'You stay calm during losing streaks',
                ],
              ),

              const ArticleSubHeader('Final reminder'),
              const ArticleParagraph(
                'Your goal isn’t to win every bet. It’s to:',
              ),
              const ArticleBulletList(
                items: [
                  'Make good decisions',
                  'Protect your bankroll',
                  'Improve gradually',
                ],
              ),
              const FormulaBox(
                'If your process is solid, results follow — not the other way around.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

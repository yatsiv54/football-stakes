import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class OddsContent extends StatelessWidget {
  const OddsContent({super.key});

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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/academy/odds.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ArticleHeader('Odds Made Simple: Implied Probability & Value'),
              ArticleParagraph(
                'Football odds aren’t just numbers — they’re a shortcut to probability. When you see decimal odds, you’re seeing two things at once: how much you’ll get back if you win, and what the market “thinks” the chance of that outcome is (plus a bookmaker margin)',
              ),
              ArticleSubHeader(
                'Implied probability (the fastest way to read odds)',
              ),
              ArticleParagraph('A simple conversion helps you think clearly:'),
              FormulaBox('Implied Probability = 1 / Odds'),
              ArticleParagraph('Examples:'),
              ArticleBulletList(
                items: [
                  'Odds 2.00 → 1 / 2.00 = 0.50 → 50%',
                  'Odds 1.50 → 1 / 1.50 = 0.666… → 66.7%,',
                  'Odds 3.40 → 1 / 3.40 = 0.294… → 29.4%',
                ],
              ),
              ArticleSubHeader(
                'Why implied probability isn’t “true probability”',
              ),
              ArticleParagraph(
                'Bookmakers and markets include a built-in edge called the margin (also called overround). If you convert all three 1X2 outcomes (Home/Draw/Away) into implied probabilities and add them up, you’ll often get more than 100%. That extra percentage is the margin. \nSo don’t treat implied probability as truth. Treat it as the market’s price — then decide whether it’s fair.',
              ),
              ArticleSubHeader('The key concept: Value'),
              ArticleParagraph(
                'Value is when you believe the real chance of an outcome is higher than the odds imply. \nExample:',
              ),
              ArticleBulletList(
                items: [
                  'Book offers Home @ 2.40',
                  'Implied probability is 1 / 2.40 = 41.7%',
                  'You believe Home wins about 48% of the time',
                ],
              ),
              ArticleParagraph(
                'That’s value. Not because you’ll win today — you might lose — but because over many similar bets, you’re getting paid more than you “should” for the risk you’re taking\nA quick value check:',
              ),
              ArticleBulletList(
                items: [
                  ' If your estimated probability P is greater than the implied probability, you may have value.',
                  'If your P is lower, you’re probably overpaying.',
                ],
              ),
              ArticleSubHeader('Expected value (EV) in plain English'),
              ArticleParagraph(
                'You don’t need complex math, but this idea matters:',
              ),
              ArticleBulletList(
                items: [
                  'Good bets are bets that are profitable on average over time.',
                  'Bad bets can win sometimes, but lose you money over many bets.',
                ],
              ),
              ArticleParagraph('A simple EV intuition:'),
              ArticleBulletList(
                items: [
                  'Higher odds don’t automatically mean better.',
                  'Better prices (odds) for the same probability are always better.',
                ],
              ),
              ArticleSubHeader('Common mistakes with odds'),
              ArticleBulletList(
                items: [
                  'Thinking short odds = safe\nOdds 1.30 still loses fairly often. Implied probability is ~76.9% — meaning about 1 in 4 fails.',
                  'Ignoring the drawIn 1X2,\nthe draw isn’t “the boring option” — it’s part of the probability pie. If you ignore it, you’ll misread match pricing.',
                  'Falling in love with a number\n“2.00feels like good odds” is emotional. Convert it to probability first, then decide.',
                ],
              ),
              ArticleSubHeader('Practical habits (what to do inside your app)'),
              ArticleBulletList(
                items: [
                  'Always convert odds to probability before saving a pick.',
                  'Add a short note: “Why is this value?” (injuries, schedule, motivation, matchup).',
                  'Track outcomes. Over 50–200 picks you’ll learn:\n– which leagues you read best\n– whether you overrate favorites\n– if your confidence aligns with results',
                ],
              ),
              ArticleSubHeader('Keep it simple at the beginning'),
              ArticleParagraph(
                'Start with 1X2 markets until you’re consistent. Complex markets can be great, but they punish shaky fundamentals. If you can’t explain why your price is value in one ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

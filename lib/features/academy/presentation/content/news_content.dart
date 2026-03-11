import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

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

                    image: AssetImage('assets/images/academy/news.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const ArticleHeader(
                'News That Matters: Lineups, Motivation, and Weather',
              ),

              const ArticleParagraph(
                'Not all football news has equal value. Some headlines move odds for good reason, while others create noise without changing the real probabilities. Learning to separate signal from noise is a major step toward smarter picks.\nThis article focuses on three types of news that truly matter: lineups, motivation, and weather.',
              ),

              const ArticleSubHeader(
                '1) Lineups: who plays matters more than reputation',
              ),
              const ArticleParagraph(
                'Team news is the fastest way probabilities change — and often the most misunderstood.',
              ),
              const ArticleParagraph('High-impact positions:'),
              const ArticleBulletList(
                items: [
                  'Goalkeeper: errors, distribution, and confidence directly affect results.',
                  'Center backs: defensive structure collapses when partnerships change.',
                  'Striker: especially if goals rely on one main scorer.',
                  'Playmaker / holding midfielder: tempo, control, and buildup suffer without them.',
                ],
              ),
              const ArticleParagraph('Low-impact changes:'),
              const ArticleBulletList(
                items: [
                  'Fullback rotation (in many systems)',
                  'Like-for-like winger swaps',
                  'Bench players starting without tactical change',
                ],
              ),
              const ArticleParagraph('Key questions to ask:'),
              const ArticleBulletList(
                items: [
                  'Is the absence tactical or forced?',
                  'Is the replacement experienced or out of position?',
                  'Does this change the team’s style or just the names?',
                ],
              ),
              const ArticleParagraph(
                'A lineup change that alters how a team plays is far more important than one that simply changes who plays.',
              ),

              const ArticleSubHeader(
                '2) Late lineup information and market timing',
              ),
              const ArticleParagraph(
                'Odds often move after official lineups are released. This creates two common situations:',
              ),
              const ArticleBulletList(
                items: [
                  'You acted early and got a good price',
                  'You acted early and missed key information',
                ],
              ),
              const ArticleParagraph('Smart habits:'),
              const ArticleBulletList(
                items: [
                  'Avoid placing final picks too early if lineups are uncertain',
                  'Re-check lineups 60–90 minutes before kickoff',
                  'If odds move sharply against you after lineups, ask why — don’t ignore it',
                ],
              ),
              const ArticleParagraph(
                'Late news doesn’t always mean you were wrong, but it always deserves review.',
              ),

              const ArticleSubHeader('3) Motivation: invisible but powerful'),
              const ArticleParagraph(
                'Motivation isn’t shown in statistics, but it shapes effort and risk-taking.',
              ),
              const ArticleParagraph(
                'Situations with strong motivational impact:',
              ),
              const ArticleBulletList(
                items: [
                  'Relegation battles',
                  'Title or European qualification races',
                  'Local derbies',
                  '“Must-win” final group matches',
                ],
              ),
              const ArticleParagraph('Low-motivation scenarios:'),
              const ArticleBulletList(
                items: [
                  'Teams with nothing left to play for',
                  'Safe mid-table sides late in the season',
                  'Heavy favorites between two more important matches',
                ],
              ),
              const ArticleParagraph(
                'Motivation doesn’t guarantee quality — but it often increases intensity, which increases variance.',
              ),

              const ArticleSubHeader(
                '4) Contextual motivation (not just standings)',
              ),
              const ArticleParagraph('Look beyond the table.'),
              const ArticleParagraph('Ask:'),
              const ArticleBulletList(
                items: [
                  'Is the coach under pressure?',
                  'Is this the first home match after a bad loss?',
                  'Is there revenge from a recent defeat?',
                  'Is the club celebrating an anniversary or milestone?',
                ],
              ),
              const ArticleParagraph(
                'These factors don’t override form or quality, but they can tilt close matches.',
              ),

              const ArticleSubHeader(
                '5) Weather: when conditions change the game',
              ),
              const ArticleParagraph(
                'Weather rarely matters in perfect conditions — but when it’s extreme, it changes probabilities.',
              ),
              const ArticleParagraph('High-impact conditions:'),
              const ArticleBulletList(
                items: [
                  'Heavy rain → slower tempo, more mistakes, fewer clean chances',
                  'Strong wind → long balls and crosses become unpredictable',
                  'Extreme heat → lower intensity, fewer late goals',
                  'Snow / frozen pitch → technical teams suffer',
                ],
              ),
              const ArticleParagraph('Who benefits?'),
              const ArticleBulletList(
                items: [
                  'Physical, direct teams',
                  'Strong set-piece sides',
                  'Deep defensive blocks',
                ],
              ),
              const ArticleParagraph(
                'Technical, possession-based teams often lose their edge in bad conditions.',
              ),

              const ArticleSubHeader('6) When weather and style collide'),
              const ArticleParagraph(
                'Weather matters most when it clashes with a team’s identity.',
              ),
              const ArticleParagraph('Examples:'),
              const ArticleBulletList(
                items: [
                  'High-press teams in extreme heat',
                  'Possession-heavy teams on poor pitches',
                  'Crossing teams in strong wind',
                ],
              ),
              const ArticleParagraph(
                'In these cases, even a small weather edge can justify caution — or a pass.',
              ),

              const ArticleSubHeader('Practical takeaway'),
              const ArticleParagraph('Before saving a pick, ask:'),
              const ArticleBulletList(
                items: [
                  'Did lineups change the way this team plays?',
                  'Is motivation higher or lower than usual?',
                  'Do conditions favor one style over another?',
                ],
              ),
              const FormulaBox(
                'If none of these factors shift the balance, news may be just noise.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class MentalContent extends StatelessWidget {
  const MentalContent({super.key});

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

                    image: AssetImage('assets/images/academy/mental.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const ArticleHeader(
                'Mental Discipline: How to Stop “Revenge Picks”',
              ),

              const ArticleParagraph(
                'Most betting losses don’t come from bad analysis — they come from bad timing and emotional speed. A “revenge pick” is a bet placed to recover losses, not because it’s a good opportunity. Learning to control this impulse is one of the biggest edges a bettor can develop.',
              ),

              const ArticleSubHeader('What is a revenge pick?'),
              const ArticleParagraph('A revenge pick happens when:'),
              const ArticleBulletList(
                items: [
                  'You lose a bet',
                  'Feel frustration, anger, or urgency',
                  'Place another bet quickly to “get it back”',
                ],
              ),
              const ArticleParagraph(
                'The problem isn’t the next bet itself — it’s the reason it exists.',
              ),

              const ArticleSubHeader('Why revenge picks are dangerous'),
              const ArticleParagraph('Revenge picks usually involve:'),
              const ArticleBulletList(
                items: [
                  'Less research',
                  'Higher stakes',
                  'Forced selection',
                  'Ignoring price and value',
                ],
              ),
              const ArticleParagraph('They’re often placed:'),
              const ArticleBulletList(
                items: [
                  'Late at night',
                  'After a bad beat',
                  'On leagues you don’t follow',
                  'On matches you normally wouldn’t touch',
                ],
              ),
              const ArticleParagraph('That’s not strategy — that’s emotion.'),

              const ArticleSubHeader(
                'Step 1 — Recognize the emotional trigger',
              ),
              const ArticleParagraph(
                'The first defense is awareness. Common triggers:',
              ),
              const ArticleBulletList(
                items: [
                  '“I can’t end the day like this”',
                  '“This one looks safe”',
                  '“I just need one win”',
                  '“I know this team, they won’t lose”',
                ],
              ),
              const ArticleParagraph(
                'When you hear these thoughts, stop. They’re signals, not insights.',
              ),

              const ArticleSubHeader('Step 2 — Slow the process down'),
              const ArticleParagraph(
                'Speed is the enemy of discipline. Simple rules that help:',
              ),
              const ArticleBulletList(
                items: [
                  'Wait 10 minutes after a loss before opening odds',
                  'No new bets in the same competition immediately after a loss',
                  'Set a fixed daily cut-off time',
                ],
              ),
              const ArticleParagraph(
                'If a bet is good now, it will still be good in 10 minutes.',
              ),

              const ArticleSubHeader(
                'Step 3 — Separate confidence from emotion',
              ),
              const ArticleParagraph(
                'Confidence comes from preparation. Emotion comes from outcome. Ask before every pick:',
              ),
              const ArticleBulletList(
                items: [
                  'Would I make this bet if my last one had won?',
                  'Does this fit my usual leagues and strategy?',
                  'Can I explain the value in one sentence?',
                ],
              ),
              const ArticleParagraph('If the answer is no, don’t place it.'),

              const ArticleSubHeader('Step 4 — Use rules, not willpower'),
              const ArticleParagraph(
                'Willpower fades. Rules don’t. Effective rules:',
              ),
              const ArticleBulletList(
                items: [
                  'Fixed stake (never increase after a loss)',
                  'Maximum number of picks per day',
                  '“One loss = break” rule',
                ],
              ),
              const ArticleParagraph(
                'Rules remove decisions — and that’s exactly what you want under stress.',
              ),

              const ArticleSubHeader('Step 5 — Reframe losses correctly'),
              const ArticleParagraph(
                'Losses don’t require action. They require acceptance.',
              ),
              const ArticleParagraph('A good loss:'),
              const ArticleBulletList(
                items: [
                  'Followed your process',
                  'Had logical reasoning',
                  'Lost due to variance',
                ],
              ),
              const ArticleParagraph('A bad loss:'),
              const ArticleBulletList(
                items: [
                  'Ignored your rules',
                  'Was rushed or emotional',
                  'Had no clear value',
                ],
              ),
              const ArticleParagraph(
                'Judge your bets by process, not outcome.',
              ),

              const ArticleSubHeader('Step 6 — Build a post-loss routine'),
              const ArticleParagraph(
                'Instead of reacting emotionally, create a habit. Example routine:',
              ),
              const ArticleBulletList(
                items: [
                  '1. Close the app',
                  '2. Write one sentence: “Why did this lose?”',
                  '3. Step away for 15–30 minutes',
                ],
              ),
              const ArticleParagraph(
                'This turns frustration into learning — and breaks the revenge cycle.',
              ),

              const ArticleSubHeader('Final reminder'),
              const ArticleParagraph(
                'You don’t need to bet often to bet well. The best bettors:',
              ),
              const ArticleBulletList(
                items: [
                  'Miss many matches',
                  'Pass often',
                  'Stay emotionally boring',
                ],
              ),
              const FormulaBox(
                'In betting, boredom is usually a sign of discipline — and discipline is where long-term results come from.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

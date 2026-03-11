import 'package:flutter/material.dart';
import 'package:football/features/academy/presentation/widgets/article_widget.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/layout/presentation/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class StepsContent extends StatelessWidget {
  const StepsContent({super.key});

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
                    image: AssetImage('assets/images/academy/steps.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 12),
              const ArticleHeader('A 5-Step Match Checklist Before You Pick'),

              const ArticleParagraph(
                'Most bad picks aren’t caused by “bad luck.” They happen because we skip fundamentals: we choose a side first, then search for reasons to justify it. A checklist flips the process — it forces you to earn the pick.\nHere’s a simple 5-step routine you can use in under 5 minutes.',
              ),

              const ArticleSubHeader(
                'Step 1 — Motivation: Who needs this more?',
              ),
              const ArticleParagraph(
                'Motivation doesn’t guarantee a result, but it changes effort, risk level, and game plan.',
              ),
              const ArticleParagraph('Ask:'),
              const ArticleBulletList(
                items: [
                  'Is one team fighting relegation or chasing a title/Europe?',
                  'Is a draw “good enough” for either side?',
                  'Is this a derby (extra intensity) or a dead rubber?',
                ],
              ),
              const ArticleParagraph('Red flags:'),
              const ArticleBulletList(
                items: [
                  'Big favorite already secured their objective → rotation risk.',
                  'Underdog must win → may play more open than usual (more chaos).',
                ],
              ),

              const ArticleSubHeader(
                'Step 2 — Team news: injuries, suspensions, rotation',
              ),
              const ArticleParagraph(
                'This is the most expensive mistake: picking without checking availability.',
              ),
              const ArticleParagraph('Ask:'),
              const ArticleBulletList(
                items: [
                  'Is the goalkeeper missing?',
                  'Are central defenders missing (shape collapses)?',
                  'Is the main striker missing (goal expectation drops)?',
                  'Any late fitness doubts?',
                ],
              ),
              const ArticleParagraph('Rotation risk checklist:'),
              const ArticleBulletList(
                items: [
                  'European match midweek',
                  'Cup match recently',
                  'Manager known for heavy rotation',
                ],
              ),
              const ArticleParagraph(
                'If you can’t confirm basic team news, you’re betting blind.',
              ),

              const ArticleSubHeader(
                'Step 3 — Style matchup: how do they win?',
              ),
              const ArticleParagraph(
                'Teams don’t just “have quality.” They have styles. Some styles punish others.',
              ),
              const ArticleParagraph('Look for:'),
              const ArticleBulletList(
                items: [
                  'High press vs weak build-up teams (forced mistakes)',
                  'Strong set-piece team vs poor set-piece defending',
                  'Fast wingers vs slow fullbacks',
                  'Low block vs teams that can’t create chances',
                ],
              ),
              const ArticleParagraph('Simple questions:'),
              const ArticleBulletList(
                items: [
                  'How will the underdog score?',
                  'How will the favorite break them down?',
                ],
              ),
              const ArticleParagraph(
                'If you can’t explain the goals pathway, pass or lower confidence.',
              ),

              const ArticleSubHeader(
                'Step 4 — Schedule: fatigue, travel, congestion',
              ),
              const ArticleParagraph(
                'Even good teams look average under fatigue.',
              ),
              const ArticleParagraph('Ask:'),
              const ArticleBulletList(
                items: [
                  'How many matches in the last 10–14 days?',
                  'Long travel recently?',
                  'Early kickoff after late midweek match?',
                  'Key players played full minutes repeatedly?',
                ],
              ),
              const ArticleParagraph('Fatigue signs:'),
              const ArticleBulletList(
                items: [
                  'Late conceded goals recently',
                  'Drop in pressing intensity',
                  'Fewer shots created in second halves',
                ],
              ),

              const ArticleSubHeader(
                'Step 5 — Price check: is the odds move logical?',
              ),
              const ArticleParagraph(
                'Before you commit, ask: does the price make sense?',
              ),
              const ArticleParagraph('Do:'),
              const ArticleBulletList(
                items: [
                  'Compare odds to your own rough estimate.',
                  'Check whether the move is based on real information (injury/news) or just hype.',
                  'If odds are extremely short, ask: “What has to go right for this to win?”',
                ],
              ),
              const ArticleParagraph(
                'If the odds are moving against your pick and you have no explanation, that’s a warning. Markets aren’t always correct, but they’re rarely random.',
              ),

              const ArticleSubHeader('A simple “Pass Rule”'),
              const FormulaBox(
                'If you can’t confidently answer at least 3 out of 5 steps, it’s usually better to pass.',
              ),
              const ArticleParagraph(
                'Passing is a skill. Good bettors don’t bet more — they bet better.',
              ),

              const ArticleSubHeader('Mini-template for your pick note (fast)'),
              const ArticleParagraph('Use one line:'),
              const ArticleBulletList(items: ['“Motivation + News + Matchup”']),
              const ArticleParagraph('Example:'),
              const ArticleBulletList(
                items: [
                  '“Home needs points, Away missing CB, Home strong on set pieces.”',
                ],
              ),
              const ArticleParagraph(
                'This helps you audit your decisions later. When you review results, you learn from the process instead of just the score.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

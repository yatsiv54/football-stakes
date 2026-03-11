class AcademyArticle {
  final String title;
  final String img;
  final String route;
  final String category;

  AcademyArticle({
    required this.title,
    required this.img,
    required this.route,
    required this.category,
  });
}

final List<AcademyArticle> academyArticles = [
  AcademyArticle(
    title: 'Odds Made Simple: Implied Probability & Value',
    img: 'assets/images/academy/odds.jpg',
    route: '/academy/odds',
    category: 'Odds',
  ),
  AcademyArticle(
    title: 'A 5-Step Match Checklist Before You Pick',
    img: 'assets/images/academy/steps.jpg',
    route: '/academy/steps',
    category: 'Process',
  ),
  AcademyArticle(
    title: 'Why Favorites Lose: Spotting Trap Matches',
    img: 'assets/images/academy/trap.jpg',
    route: '/academy/trap',
    category: 'Getting Started',
  ),
  AcademyArticle(
    title: 'Form Beyond W-L: What to Look At',
    img: 'assets/images/academy/beyond.jpg',
    route: '/academy/beyond',
    category: 'Process',
  ),
  AcademyArticle(
    title: 'Bankroll Rules for Real People',
    img: 'assets/images/academy/bankroll.jpg',
    route: '/academy/bankroll',
    category: 'Bankroll',
  ),
  AcademyArticle(
    title: 'News That Matters: Lineups, Motivation, and Weather',
    img: 'assets/images/academy/news.jpg',
    route: '/academy/news',
    category: 'Getting Started',
  ),
  AcademyArticle(
    title: 'Mental Discipline: How to Stop `Revenge Picks`',
    img: 'assets/images/academy/mental.jpg',
    route: '/academy/mental',
    category: 'Mindset',
  ),
];
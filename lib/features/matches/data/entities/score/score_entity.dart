class Score {
  final int home;
  final int away;

  Score({required this.home, required this.away});

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        home: int.tryParse(json['home']?.toString() ?? '') ?? 0,
        away: int.tryParse(json['away']?.toString() ?? '') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'home': home,
        'away': away,
      };
}
class Odd {
  final double home;
  final double away;
  final double draw;

  Odd({required this.home, required this.away, required this.draw});

  factory Odd.fromJson(Map<String, dynamic> json) => Odd(
        home: _stringToDouble(json['odd_1'] ?? json['home']),
        away: _stringToDouble(json['odd_2'] ?? json['away']),
        draw: _stringToDouble(json['odd_x'] ?? json['draw']),
      );

  Map<String, dynamic> toJson() => {
        'home': home,
        'away': away,
        'draw': draw,
      };

  static double _stringToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      if (value.trim().isEmpty) return 0.0;
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
}
class Team {
  final String name;
  final String logo;

  Team({required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json['name'] as String? ?? '',
        logo: json['logo'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'logo': logo,
      };
}
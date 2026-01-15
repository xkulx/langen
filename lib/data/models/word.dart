class Word {
  final String id;
  final String en;
  final List<String> ru;
  final List<String> examples;

  Word({
    required this.id,
    required this.en,
    required this.ru,
    required this.examples,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      en: json['en'],
      ru: List<String>.from(json['ru']),
      examples: List<String>.from(json['examples']),
    );
  }
}

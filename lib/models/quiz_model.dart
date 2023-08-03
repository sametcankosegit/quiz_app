class Quiz {
  final String category;
  final String question;
  final List<String> options;
  final int correctOption;
  final int points;

  Quiz({
    required this.category,
    required this.question,
    required this.options,
    required this.correctOption,
    required this.points,
  });
}

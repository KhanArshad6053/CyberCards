/// The three supported flashcard types.
enum CardType { definition, scenario, quiz }

class FlashCardModel {
  final String id;
  final String categoryId;
  final CardType type;
  final String question;
  final String answer;
  final String? example;
  final String? tip;

  /// Only used when [type] is [CardType.quiz] or a scenario with choices.
  final List<String>? options;

  /// Index into [options] that is correct.
  final int? correctOptionIndex;

  /// Mutable learning-state flags (kept simple; driven by AppState).
  bool learned;
  bool stillLearning;

  FlashCardModel({
    required this.id,
    required this.categoryId,
    required this.type,
    required this.question,
    required this.answer,
    this.example,
    this.tip,
    this.options,
    this.correctOptionIndex,
    this.learned = false,
    this.stillLearning = false,
  });
}

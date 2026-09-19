import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/flashcard_model.dart';

/// Single source of truth for learning progress, theme and settings.
/// Kept deliberately simple (in-memory) — swap the storage calls for
/// shared_preferences / a database when wiring up persistence.
class AppState extends ChangeNotifier {
  final List<FlashCardModel> _cards = SampleData.cards;

  ThemeMode themeMode = ThemeMode.dark;
  bool dailyRemindersEnabled = true;
  int dailyGoal = 10;
  int streakDays = 5;

  List<FlashCardModel> get allCards => _cards;

  List<FlashCardModel> cardsFor(String categoryId) =>
      _cards.where((c) => c.categoryId == categoryId).toList();

  int get totalCards => _cards.length;

  int get learnedCount => _cards.where((c) => c.learned).length;

  int get stillLearningCount =>
      _cards.where((c) => c.stillLearning && !c.learned).length;

  int get remainingCount => totalCards - learnedCount;

  double get overallProgress =>
      totalCards == 0 ? 0 : learnedCount / totalCards;

  double progressForCategory(String categoryId) {
    final list = cardsFor(categoryId);
    if (list.isEmpty) return 0;
    final learned = list.where((c) => c.learned).length;
    return learned / list.length;
  }

  int learnedForCategory(String categoryId) =>
      cardsFor(categoryId).where((c) => c.learned).length;

  /// Returns the first not-yet-learned card for "Continue Learning",
  /// or null if everything is learned.
  FlashCardModel? get continueCard {
    for (final c in _cards) {
      if (!c.learned) return c;
    }
    return null;
  }

  void markKnown(FlashCardModel card) {
    card.learned = true;
    card.stillLearning = false;
    notifyListeners();
  }

  void markStillLearning(FlashCardModel card) {
    card.learned = false;
    card.stillLearning = true;
    notifyListeners();
  }

  void toggleThemeMode(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setDailyReminders(bool value) {
    dailyRemindersEnabled = value;
    notifyListeners();
  }

  void setDailyGoal(int value) {
    dailyGoal = value;
    notifyListeners();
  }

  void resetProgress() {
    for (final c in _cards) {
      c.learned = false;
      c.stillLearning = false;
    }
    streakDays = 0;
    notifyListeners();
  }
}

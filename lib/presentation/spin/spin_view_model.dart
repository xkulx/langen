import 'package:flutter/material.dart';
import '../../data/models/word.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/state/user_word_state.dart';

class SpinViewModel extends ChangeNotifier {
  final WordRepository repo;

  List<Word> _words = [];
  Word? current;

  bool isChecked = false;
  bool? isCorrect;

  final UserWordState userState;

  SpinViewModel(this.repo, this.userState);

  Future<void> load(String level, String theme) async {
    await userState.load();
    _words = await repo.getWords(level, theme);
    _words.shuffle();
    next();
  }

  void check(String input) {
    final normalized = input.toLowerCase().trim();
    isCorrect = current!.ru.any((r) => r == normalized);

    if (isCorrect == true) {
      userState.markKnown(current!.id);
    }

    isChecked = true;
    notifyListeners();
  }

  void next() {
    if (_words.isEmpty) return;

    current = _words.removeLast();
    isChecked = false;
    isCorrect = null;
    notifyListeners();
  }
}

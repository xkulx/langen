import '../sources/telegram_storage.dart';

class UserWordState {
  final TelegramStorage storage;

  Set<String> knownWords = {};

  UserWordState(this.storage);

  Future<void> load() async {
    final raw = await storage.get('known_words');
    if (raw == null || raw.isEmpty) return;

    knownWords = raw.split(',').toSet();
  }

  void markKnown(String wordId) {
    knownWords.add(wordId);
    storage.set('known_words', knownWords.join(','));
  }

  bool isKnown(String wordId) {
    return knownWords.contains(wordId);
  }
}

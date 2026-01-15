import '../models/word.dart';
import '../sources/json_word_source.dart';

class WordRepository {
  final JsonWordSource source;

  WordRepository(this.source);

  Future<List<Word>> getWords(String level, String theme) {
    return source.loadWords(level: level, theme: theme);
  }
}

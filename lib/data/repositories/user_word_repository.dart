import 'package:sqflite/sqflite.dart';

import '../sources/local_db.dart';
import '../../domain/word_status.dart';

class UserWordRepository {
  final LocalDb db;

  UserWordRepository(this.db);

  Future<void> save(String wordId, WordStatus status) async {
    final database = await db.db;
    await database.insert(
      'user_words',
      {
        'word_id': wordId,
        'status': status.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<WordStatus?> get(String wordId) async {
    final database = await db.db;
    final res = await database.query(
      'user_words',
      where: 'word_id = ?',
      whereArgs: [wordId],
    );

    if (res.isEmpty) return null;
    return WordStatus.values
        .firstWhere((e) => e.name == res.first['status']);
  }
}

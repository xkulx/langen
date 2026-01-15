import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDb {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'langen.db'),
      version: 1,
      onCreate: (db, _) {
        return db.execute(
          '''
          CREATE TABLE user_words(
            word_id TEXT PRIMARY KEY,
            status TEXT
          )
          ''',
        );
      },
    );
    return _db!;
  }
}

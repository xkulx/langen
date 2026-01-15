import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word.dart';

class JsonWordSource {
  Future<List<Word>> loadWords({
    required String level,
    required String theme,
  }) async {
    final path = 'assets/data/$level/$theme.json';
    final raw = await rootBundle.loadString(path);
    final List decoded = json.decode(raw);

    return decoded.map((e) => Word.fromJson(e)).toList();
  }
}

import 'package:flutter/foundation.dart';
import 'dart:js' as js;

class TelegramStorage {
  Future<String?> get(String key) async {
    if (!kIsWeb) return null;

    final result = js.context.callMethod('tgGet', [key]);
    return await result;
  }

  void set(String key, String value) {
    if (!kIsWeb) return;
    js.context.callMethod('tgSet', [key, value]);
  }
}

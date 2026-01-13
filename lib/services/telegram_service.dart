import 'dart:js' as js;

class TelegramService {
  static int? get userId {
    try {
      final user = js.context['Telegram']
      ?['WebApp']
      ?['initDataUnsafe']
      ?['user'];

      if (user == null) return null;

      return user['id'] as int?;
    } catch (e) {
      return null;
    }
  }
}
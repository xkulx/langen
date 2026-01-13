import 'package:flutter/material.dart';
import 'services/telegram_service.dart';

void main() {
  runApp(const MiniApp());
}

class MiniApp extends StatelessWidget {
  const MiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = TelegramService.userId;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            userId != null
                ? 'Telegram user_id: $userId'
                : 'Not running inside Telegram',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

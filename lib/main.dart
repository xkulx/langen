import 'package:flutter/material.dart';
import 'package:langen/presentation/spin/spin_view_model.dart';
import 'package:provider/provider.dart';
import 'data/repositories/word_repository.dart';
import 'data/sources/json_word_source.dart';
import 'data/sources/telegram_storage.dart';
import 'data/state/user_word_state.dart';
import 'services/telegram_service.dart';

void main() {
  final repo = WordRepository(JsonWordSource());
  final storage = TelegramStorage();
  final userState = UserWordState(storage);

  runApp(
    ChangeNotifierProvider(
      create: (_) => SpinViewModel(repo, userState)..load('A1', 'food'),
      child: const LangenApp(),
    ),
  );
}



class LangenApp extends StatelessWidget {
  const LangenApp({super.key});

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

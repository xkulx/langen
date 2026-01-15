import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'spin_view_model.dart';

class SpinScreen extends StatefulWidget {
  const SpinScreen({super.key});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();
  late final AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SpinViewModel>();
    final word = vm.current;

    if (word == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isKnown = vm.userState.isKnown(word.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Langen')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(word.id),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isKnown ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RotationTransition(
                  turns: Tween(begin: 0.95, end: 1.0)
                      .animate(animController),
                  child: Text(
                    word.en,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: controller,
              enabled: !vm.isChecked,
              decoration: const InputDecoration(
                labelText: 'Перевод',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            if (!vm.isChecked)
              ElevatedButton(
                onPressed: () {
                  vm.check(controller.text);
                },
                child: const Text('CHECK'),
              ),

            if (vm.isChecked) ...[
              const SizedBox(height: 8),
              Text(
                vm.isCorrect! ? '✔ Correct' : '✖ Incorrect',
                style: TextStyle(
                  color: vm.isCorrect! ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),
              const Text('Examples:'),

              const SizedBox(height: 4),
              ...word.examples.map((e) => Text('• $e')),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  controller.clear();
                  animController.forward(from: 0);
                  vm.next();
                },
                child: const Text('NEXT'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

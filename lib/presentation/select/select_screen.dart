import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../spin/spin_view_model.dart';
import '../../domain/levels.dart';
import '../../domain/themes.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  String level = 'A1';
  String theme = 'food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButton<String>(
              value: level,
              items: levels
                  .map((l) =>
                  DropdownMenuItem(value: l, child: Text(l)))
                  .toList(),
              onChanged: (v) => setState(() => level = v!),
            ),
            DropdownButton<String>(
              value: theme,
              items: themes
                  .map((t) =>
                  DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => theme = v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await context
                    .read<SpinViewModel>()
                    .load(level, theme);
                Navigator.pushNamed(context, '/spin');
              },
              child: const Text('START'),
            ),
          ],
        ),
      ),
    );
  }
}

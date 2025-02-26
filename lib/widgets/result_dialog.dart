import 'package:flutter/material.dart';
import 'package:reto5ios/models/character.dart';

class ResultDialog extends StatelessWidget {
  final Character character;

  const ResultDialog({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("¡Eres un ${character.name}!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(character.imagePath, height: 150),
          const SizedBox(height: 20),
          Text(character.description),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Que la Fuerza te acompañe'),
        ),
      ],
    );
  }
}

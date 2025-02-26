import 'package:flutter/material.dart';
import 'package:reto5ios/models/character.dart';
import 'package:reto5ios/screens/welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final Character character;
  final Map<String, int> scores;

  const ResultScreen({
    super.key,
    required this.character,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    final sortedScores =
        scores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_stars.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  "Tu Resultado",
                  style: TextStyle(color: Colors.amber),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.amber, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(character.imagePath),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "¡Eres un ${character.name}!",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          character.description,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "Tu compatibilidad con cada facción:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...sortedScores.map((entry) {
                          final percentage =
                              (entry.value / sortedScores[0].value) * 100;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: TextStyle(
                                    color:
                                        entry.key == character.name
                                            ? Colors.amber
                                            : Colors.white,
                                    fontWeight:
                                        entry.key == character.name
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: percentage / 100,
                                  backgroundColor: Colors.grey[800],
                                  color:
                                      entry.key == character.name
                                          ? Colors.amber
                                          : Colors.blueGrey,
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${percentage.toInt()}%",
                                  style: TextStyle(
                                    color:
                                        entry.key == character.name
                                            ? Colors.amber
                                            : Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "VOLVER A EMPEZAR",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

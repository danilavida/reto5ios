import 'package:flutter/material.dart';

void main() => runApp(CharacterQuizApp());

class CharacterQuizApp extends StatelessWidget {
  const CharacterQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¿Qué Personaje Eres?',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizScreen(),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final Map<String, int> scores;

  Question({required this.text, required this.options, required this.scores});
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<String, int> _totalScores = {};
  String? _selectedAnswer;

  final List<Question> _questions = [
    Question(
      text: "¿Cómo prefieres pasar tu tiempo libre?",
      options: ["Leyendo", "Ejercicio", "Videojuegos", "Socializar"],
      scores: {"Sherlock": 5, "Thor": 3, "Mario": 4, "Phoebe": 2},
    ),
    Question(
      text: "Tu comida favorita es...",
      options: ["Pizza", "Asgardian Feast", "Sushi", "Café"],
      scores: {"Mario": 5, "Thor": 4, "Sherlock": 3, "Phoebe": 2},
    ),
    // Agregar 3 preguntas más con misma estructura
  ];

  void _answerQuestion(String selectedOption) {
    setState(() {
      _selectedAnswer = selectedOption;
      _questions[_currentQuestionIndex].scores.forEach((character, score) {
        _totalScores.update(
          character,
          (value) => value + score,
          ifAbsent: () => score,
        );
      });
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    String result = "Phoebe"; // Default
    int maxScore = 0;

    _totalScores.forEach((character, score) {
      if (score > maxScore) {
        maxScore = score;
        result = character;
      }
    });

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text("¡Eres... $result!"),
            content: Text(_getCharacterDescription(result)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  String _getCharacterDescription(String character) {
    const descriptions = {
      "Sherlock": "Genio observador con habilidades deductivas sobresalientes",
      "Thor": "Poderoso guerrero con corazón noble y sentido del humor único",
      "Mario": "Héroe perseverante que siempre salva el día con entusiasmo",
      "Phoebe":
          "Espíritu libre con una visión única del mundo y gran creatividad",
    };
    return descriptions[character] ??
        "Personaje único con características especiales";
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Pregunta ${_currentQuestionIndex + 1}")),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(currentQuestion.text, style: TextStyle(fontSize: 24)),
          ),
          ...currentQuestion.options.map(
            (option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedAnswer,
              onChanged: (value) => _answerQuestion(value!),
            ),
          ),
          ElevatedButton(
            onPressed: _selectedAnswer != null ? _nextQuestion : null,
            child: Text(
              _currentQuestionIndex == _questions.length - 1
                  ? "Ver Resultado"
                  : "Siguiente",
            ),
          ),
        ],
      ),
    );
  }
}

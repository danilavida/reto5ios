import 'package:flutter/material.dart';
import 'package:reto5ios/data/questions_repository.dart';
import 'package:reto5ios/models/question.dart';
import 'package:reto5ios/widgets/option_card.dart';
import 'package:reto5ios/widgets/result_dialog.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<String, int> _totalScores = {};
  String? _selectedAnswer;

  late final List<Question> _questions = QuestionsRepository.getQuestions();

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

  void _showResult() {
    String result =
        _totalScores.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    final character = QuestionsRepository.characters.firstWhere(
      (c) => c.name == result,
    );

    showDialog(
      context: context,
      builder: (context) => ResultDialog(character: character),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pregunta ${_currentQuestionIndex + 1}"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/star_wars_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                currentQuestion.text,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: currentQuestion.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder:
                      (context, index) => OptionCard(
                        option: currentQuestion.options[index],
                        isSelected:
                            _selectedAnswer == currentQuestion.options[index],
                        onTap:
                            () =>
                                _answerQuestion(currentQuestion.options[index]),
                      ),
                ),
              ),
              ElevatedButton(
                onPressed:
                    _selectedAnswer != null
                        ? () =>
                            _currentQuestionIndex < _questions.length - 1
                                ? setState(() {
                                  _currentQuestionIndex++;
                                  _selectedAnswer = null;
                                })
                                : _showResult()
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  _currentQuestionIndex < _questions.length - 1
                      ? 'Siguiente'
                      : 'Ver Resultado',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

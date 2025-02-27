import 'package:flutter/material.dart';
import 'package:reto5ios/data/questions_repository.dart';
import 'package:reto5ios/models/question.dart';
import 'package:reto5ios/screens/result_screen.dart';
import 'package:reto5ios/widgets/option_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  final Map<String, int> _scores = {
    'Sith': 0,
    'Jedi': 0,
    'Mandaloriano': 0,
    'Soldado República': 0,
    'Soldado Imperio': 0,
  };
  String? _selectedOption;
  late final List<Question> _questions = QuestionsRepository.getQuestions();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _answerQuestion(String selectedOption) {
    setState(() {
      _selectedOption = selectedOption;
    });
  }

  void _calculateScore() {
    final currentQuestion = _questions[_currentQuestionIndex];
    final optionIndex = currentQuestion.options.indexOf(_selectedOption!);

    // Distribución de puntos según la opción seleccionada
    final characterKeys =
        QuestionsRepository.characters.map((c) => c.name).toList();
    for (int i = 0; i < characterKeys.length; i++) {
      // Puntuación inversamente proporcional a la distancia de la opción preferida
      int score = 5 - ((i - optionIndex).abs() % 5);
      _scores[characterKeys[i]] = (_scores[characterKeys[i]] ?? 0) + score;
    }
  }

  void _nextQuestion() {
    if (_selectedOption == null) return;

    _calculateScore();

    if (_currentQuestionIndex < _questions.length - 1) {
      _animationController.reverse().then((_) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOption = null;
        });
        _animationController.forward();
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    // Encontrar el personaje con mayor puntuación
    final highestScoreEntry = _scores.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );

    final character = QuestionsRepository.characters.firstWhere(
      (c) => c.name == highestScoreEntry.key,
    );

    // Navegar a la pantalla de resultados
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) =>
                ResultScreen(character: character, scores: Map.from(_scores)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}",
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_stars.jpg'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[800],
                color: Colors.amber,
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  currentQuestion.text,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ListView.separated(
                    itemCount: currentQuestion.options.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder:
                        (context, index) => OptionCard(
                          option: currentQuestion.options[index],
                          isSelected:
                              _selectedOption == currentQuestion.options[index],
                          onTap:
                              () => _answerQuestion(
                                currentQuestion.options[index],
                              ),
                        ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _selectedOption != null ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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

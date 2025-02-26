import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

void main() => runApp(const StarWarsQuizApp());

class StarWarsQuizApp extends StatelessWidget {
  const StarWarsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz de Star Wars',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      home: const QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

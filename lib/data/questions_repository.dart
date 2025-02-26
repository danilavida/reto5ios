import 'package:reto5ios/main.dart';
import 'package:reto5ios/models/character.dart';

class QuestionsRepository {
  static const List<Character> characters = [
    Character(
      name: 'Sith',
      description:
          'Maestro del lado oscuro, busca poder absoluto mediante la pasión y la fuerza',
      imagePath: '/assets/images/sith.png',
    ),
    Character(
      name: 'Jedi',
      description:
          'Guardián de la paz, utiliza la Fuerza para conocimiento y defensa',
      imagePath: '/assets/images/jedi.png',
    ),
    Character(
      name: 'Mandaloriano',
      description:
          'Guerreo honorable, sigue estrictamente el código de armadura',
      imagePath: 'assets/mandalorian.png',
    ),
    Character(
      name: 'Soldado República',
      description: 'Soldado disciplinado que lucha por la democracia galáctica',
      imagePath: 'assets/republic.png',
    ),
    Character(
      name: 'Soldado Imperio',
      description: 'Leal ejecutor de la voluntad del Imperio Galáctico',
      imagePath: 'assets/empire.png',
    ),
  ];

  static List<Question> getQuestions() => [
    Question(
      text: "¿Cuál es tu filosofía de combate?",
      options: [
        "Vencer a cualquier costo",
        "Proteger a los débiles",
        "Honor antes que victoria",
        "Seguir órdenes al pie de la letra",
        "Eficiencia sobre todo",
      ],
      scores: {
        'Sith': 5,
        'Jedi': 4,
        'Mandaloriano': 3,
        'Soldado República': 2,
        'Soldado Imperio': 1,
      },
    ),
    // Agregar más preguntas aquí
  ];
}

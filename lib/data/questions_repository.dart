import 'package:reto5ios/models/character.dart';
import 'package:reto5ios/models/question.dart';

class QuestionsRepository {
  static const List<Character> characters = [
    Character(
      name: 'Sith',
      description:
          'Maestro del lado oscuro, busca poder absoluto mediante la pasión y la fuerza. Tu ambición y determinación te hacen un líder formidable, aunque a veces puedes ser implacable en la búsqueda de tus objetivos.',
      imagePath: '/assets/images/sith.jpg',
    ),
    Character(
      name: 'Jedi',
      description:
          'Guardián de la paz, utilizas la Fuerza para conocimiento y defensa. Tu sabiduría y paciencia te permiten ver más allá de lo evidente, siempre buscando soluciones pacíficas a los conflictos.',
      imagePath: 'assets/images/jedi.png',
    ),
    Character(
      name: 'Mandaloriano',
      description:
          'Guerrero honorable, sigues estrictamente el código de la armadura. Valoras la lealtad por encima de todo y nunca rompes una promesa. Tu pragmatismo y habilidades de combate te convierten en un aliado valioso.',
      imagePath: 'assets/images/mandalorian.png',
    ),
    Character(
      name: 'Soldado República',
      description:
          'Soldado disciplinado que lucha por la democracia galáctica. Crees en el orden y la justicia, siguiendo un código moral estricto. Tu dedicación a la causa común te hace un pilar fundamental para la sociedad.',
      imagePath: 'assets/images/republic.png',
    ),
    Character(
      name: 'Soldado Imperio',
      description:
          'Leal ejecutor de la voluntad del Imperio Galáctico. Valoras el orden y la eficiencia por encima de todo, dispuesto a hacer sacrificios por un bien mayor. Tu disciplina y determinación son admirables.',
      imagePath: 'assets/images/empire.png',
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
    Question(
      text: "¿Cómo reaccionas ante un enemigo derrotado?",
      options: [
        "Lo elimino sin contemplaciones",
        "Le ofrezco una segunda oportunidad",
        "Respeto su valentía pero cumplo mi deber",
        "Sigo el protocolo establecido",
        "Lo capturo para obtener información",
      ],
      scores: {
        'Sith': 5,
        'Jedi': 1,
        'Mandaloriano': 3,
        'Soldado República': 2,
        'Soldado Imperio': 4,
      },
    ),
    Question(
      text: "¿Qué es más importante para ti?",
      options: [
        "El poder personal",
        "La armonía y el equilibrio",
        "El honor y la tradición",
        "La libertad y la justicia",
        "El orden y la estabilidad",
      ],
      scores: {
        'Sith': 5,
        'Jedi': 4,
        'Mandaloriano': 3,
        'Soldado República': 2,
        'Soldado Imperio': 1,
      },
    ),
    Question(
      text: "Ante una situación de crisis, prefieres:",
      options: [
        "Tomar el control de inmediato",
        "Buscar una solución pacífica",
        "Proteger a tu clan o familia",
        "Establecer un plan democrático",
        "Seguir la cadena de mando",
      ],
      scores: {
        'Sith': 5,
        'Jedi': 3,
        'Mandaloriano': 4,
        'Soldado República': 2,
        'Soldado Imperio': 1,
      },
    ),
    Question(
      text: "¿Qué valoras más en un líder?",
      options: [
        "Su fuerza y determinación",
        "Su sabiduría y compasión",
        "Su habilidad y respeto al código",
        "Su capacidad para escuchar a todos",
        "Su capacidad para mantener el orden",
      ],
      scores: {
        'Sith': 5,
        'Jedi': 4,
        'Mandaloriano': 3,
        'Soldado República': 2,
        'Soldado Imperio': 1,
      },
    ),
  ];
}

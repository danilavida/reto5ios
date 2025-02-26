import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¿Qué Personaje Eres?',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _preguntaActual = 0;
  List<String> _respuestas = [
    '',
    '',
    '',
    '',
    '',
  ]; // Lista para guardar las respuestas del usuario
  String _personajeResultante = '';

  // Colección: Lista de Mapas para las preguntas y respuestas
  final List<Map<String, dynamic>> _preguntas = [
    {
      'pregunta': '¿Cuál es tu color favorito?',
      'respuestas': ['Rojo', 'Azul', 'Verde', 'Amarillo'],
    },
    {
      'pregunta': '¿Qué tipo de aventura prefieres?',
      'respuestas': ['Misterio', 'Acción', 'Comedia', 'Romance'],
    },
    {
      'pregunta': '¿Cuál es tu mayor cualidad?',
      'respuestas': ['Inteligencia', 'Valentía', 'Humor', 'Lealtad'],
    },
    {
      'pregunta': '¿Qué elemento te representa mejor?',
      'respuestas': ['Fuego', 'Agua', 'Tierra', 'Aire'],
    },
    {
      'pregunta': '¿Cuál es tu mayor defecto?',
      'respuestas': ['Impaciencia', 'Indecisión', 'Sarcasmo', 'Terquedad'],
    },
  ];

  // Colección: Mapa para relacionar respuestas (simplificado) con personajes
  final Map<String, String> _personajes = {
    'RojoMisterioInteligenciaFuegoImpaciencia': 'Sherlock Holmes',
    'AzulAcciónValentíaAguaIndecisión': 'Indiana Jones',
    'VerdeComediaHumorTierraSarcasmo': 'Deadpool',
    'AmarilloRomanceLealtadAireTerquedad': 'Princesa Leia',
  };

  void _responderPregunta(int indexRespuesta) {
    setState(() {
      _respuestas[_preguntaActual] =
          _preguntas[_preguntaActual]['respuestas'][indexRespuesta];
      if (_preguntaActual < _preguntas.length - 1) {
        _preguntaActual++;
      } else {
        _determinarPersonaje();
      }
    });
  }

  void _determinarPersonaje() {
    // Operadores de Concatenación y acceso a Map
    String claveRespuestas = '';
    for (String respuesta in _respuestas) {
      // Estructura Iterativa: for loop
      claveRespuestas += respuesta;
    }
    // Operador de acceso a Map con clave
    _personajeResultante =
        _personajes[claveRespuestas] ??
        'Personaje Desconocido'; // Operador ?? (if null)
  }

  void _resetQuiz() {
    setState(() {
      _preguntaActual = 0;
      _respuestas = ['', '', '', '', ''];
      _personajeResultante = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('¿Qué Personaje Eres?')),
      body:
          _preguntaActual < _preguntas.length
              ? _buildQuizPregunta()
              : _buildResultado(),
    );
  }

  Widget _buildQuizPregunta() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            // Acceso a datos de la colección (lista de mapas)
            _preguntas[_preguntaActual]['pregunta'] as String,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Estructura Iterativa: for loop para las opciones de respuesta
          ...(_preguntas[_preguntaActual]['respuestas'] as List<String>).map((
            respuesta,
          ) {
            int indexRespuesta = (_preguntas[_preguntaActual]['respuestas']
                    as List<String>)
                .indexOf(respuesta);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed:
                    () => _responderPregunta(
                      indexRespuesta,
                    ), // Operador de Asignación y Llamada a función
                child: Text(respuesta),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResultado() {
    String descripcionPersonaje = '';
    String nombrePersonaje = _personajeResultante;

    if (nombrePersonaje == 'Sherlock Holmes') {
      descripcionPersonaje = 'Detective brillante y deductivo.';
      // [Image of Sherlock Holmes]
    } else if (nombrePersonaje == 'Indiana Jones') {
      descripcionPersonaje = 'Arqueólogo aventurero en busca de reliquias.';
      // [Image of Indiana Jones]
    } else if (nombrePersonaje == 'Deadpool') {
      descripcionPersonaje = 'Antihéroe sarcástico y regenerativo.';
      // [Image of Deadpool]
    } else if (nombrePersonaje == 'Princesa Leia') {
      descripcionPersonaje = 'Líder rebelde y valiente.';
      // [Image of Princesa Leia]
    } else {
      descripcionPersonaje =
          'No pudimos determinar tu personaje exactamente, ¡quizás eres único!';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Tu personaje es!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              nombrePersonaje,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              descripcionPersonaje,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _resetQuiz,
              child: const Text('Volver a Intentar'),
            ),
          ],
        ),
      ),
    );
  }
}

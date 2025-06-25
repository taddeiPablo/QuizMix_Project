import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quizmix/src/screens/Victory_screen.dart';

class Question {
  final String text;
  final String answer;
  Question(this.text, this.answer);
}

class InsertedWord {
  final String word;
  final List<Point<int>> positions;
  InsertedWord({required this.word, required this.positions});
}

class GameScreen extends StatefulWidget {
  final String category;
  const GameScreen({super.key, required this.category});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int gridSize = 13;
  int score = 0;
  final int baseWordPoints = 10;
  final int helpPenalty = 5;
  List<List<String>> grid = [];
  List<List<bool>> selectedPositions = [];
  List<Point<int>> selectedPath = [];
  Set<Point<int>> hintPositions = {};
  final Random _random = Random();
  bool helpUsed = false;
  int questionLen = 0;

  Map<String, List<Question>> questionCategories = {
    'Historia': [
      Question('¿En qué año comenzó la Segunda Guerra Mundial?', '1939'),
      Question(
        '¿Quién fue el primer presidente de EE.UU?',
        'George Washington',
      ),
    ],
    'Deportes': [
      Question('¿Cuántos jugadores hay en un equipo de fútbol?', '11'),
      Question('¿En qué país se originó el judo?', 'Japón'),
      Question('¿En que pais se origino el futbol?', 'Inglaterra'),
      Question('¿Ultimo muldial que gano Argentina ?', '2022'),
      Question('¿Primer mundial de la Historia ?', '1930'),
      Question('¿En que equipo de Italia jugo MARADONA?', 'NAPOLI'),
      Question('¿Enn que equipo de España jugo Messi?', 'Barcelona'),
      Question('¿En qué país se originó el judo?', 'Japón'),
    ],
    'Geografía': [
      Question('¿Cuál es el río más largo del mundo?', 'Nilo'),
      Question('¿Dónde se encuentra el monte Everest?', 'Nepal'),
      Question("Cual es el continente Helado?", "ANTARTIDA"),
      Question("En que continente queda China ?", "ASIA"),
      Question("en que continente queda el rio Danuvio ?", "EUROPA"),
      Question('¿Cual es la provincia argentina mas pequeña?', 'Tucuman'),
      Question('¿En qué continente esta el rio nilo?', 'Africa'),
      Question('¿En qué pais se encuentra el amazonas?', 'Brasil'),
      Question('¿cual es el continente mas grande del mundo?', 'America'),
      Question(
        '¿Que ciudad esta consstruida sobre dos continentes ?',
        'Estanbul',
      ),
    ],
    'Paises': [
      Question("Capital de Francia", "PARIS"),
      Question("Capital de Argentina", "BUENOS AIRES"),
      Question("Capital de España", "MADRID"),
      Question('Capital de Noruega', 'Oslok'),
      Question('Capital de Rusia', 'Moscu'),
      Question('Capital de Alemania', 'Berlin'),
      Question('Capital de Uruguay', 'Montevideo'),
      Question('Capital de Brasil', 'Brasilia'),
      Question('Capital de china', 'Pekin'),
      Question('Capital de Italia', 'Roma'),
    ],
    'Ciencia': [
      Question("El hidrogeno es un Elemento del ?", "AGUA"),
      Question('¿Planeta mas grande del sistema solar ?', 'Jupiter'),
      Question('¿La Atmosfera de cuantas capas esta formada ?', 'cinco'),
      Question('¿En qué país se originó el judo?', 'Japón'),
    ],
  };

  List<Question> questions = [];
  List<InsertedWord> insertedWords = [];
  List<String> foundWords = [];
  int currentQuestionIndex = 0;

  // 🎧 Aquí lo colocás
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();

  void _playSound(String sound) async {
    await _audioPlayer.play(AssetSource('sounds/$sound'));
  }

  void _playBackGroundMusic() async {
    await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    await _backgroundPlayer.play(AssetSource('sounds/background.mp3'));
  }

  final List<Color> wordColors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  // Temporizador
  Timer? timer;
  int timeRemaining = 40;
  final int maxTime = 40;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startNewGame();
    _playBackGroundMusic();
  }

  void _onCorrectAnswer(String word) {
    setState(() {
      if (foundWords.contains(word)) {
        //foundWords.add(word);
        score += baseWordPoints;
      }
    });
  }

  void _showHints() {
    setState(() {
      if (!helpUsed) {
        if (score > 0) {
          score -= helpPenalty;
        }
      }
      hintPositions.clear();
      for (var inserted in insertedWords) {
        if (!foundWords.contains(inserted.word)) {
          if (inserted.positions.isNotEmpty) {
            hintPositions.add(inserted.positions.first);
          }
          break;
        }
      }
      helpUsed = true;
    });
  }

  void _initializeGame() {
    // aqui aplicando modificaciones
    //_randomLetter()
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => ''));

    selectedPositions = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => false),
    );

    selectedPath = [];
    insertedWords.clear();
    foundWords.clear();
    currentQuestionIndex = 0;
    // aqui modificar el insertword
    questions = questionCategories[widget.category]!;
    for (var question in questions) {
      _insertWord(question.answer.toUpperCase());
    }

    //Rellenar celdas vacías con letras aleatorias
    _fillEmptyCells();

    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timeRemaining = maxTime;

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        _moveToNextQuestion();
      }
    });
  }

  void _moveToNextQuestion() {
    timer?.cancel();
    hintPositions.clear();
    helpUsed = false;
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedPath.clear();
        _clearSelection();
        _startTimer();
      });
    } else {
      // Fin del juego
      setState(() {
        timeRemaining = 0;
      });
      _backgroundPlayer.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VictoryScreen(score: foundWords.length),
        ),
      );
    }
  }

  /*void _moveToNextQuestion() {
    timer?.cancel();
    hintPositions.clear();
    helpUsed = false;
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedPath.clear();
        _clearSelection();
        _startTimer();
      });
    } else {
      // Fin del juego
      setState(() {
        timeRemaining = 0;
      });
      _backgroundPlayer.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VictoryScreen(score: foundWords.length),
        ),
      );
    }
  }*/

  void _startNewGame() {
    setState(() {
      score = 0;
      foundWords.clear();
      helpUsed = false;
      // etc...
    });
  }

  void _insertWord(String word) {
    const directions = [
      Point(0, 1), // derecha
      Point(1, 0), // abajo
      Point(1, 1), // diagonal ↘
      Point(-1, 1), // diagonal ↗
      Point(0, -1), // izquierda
      Point(-1, 0), // arriba
      Point(-1, -1), // diagonal ↖
      Point(1, -1), // diagonal ↙
    ];

    int attempts = 0;
    const maxAttempts = 100;

    while (attempts < maxAttempts) {
      attempts++;

      Point<int> dir = directions[_random.nextInt(directions.length)];
      bool reversed = _random.nextBool();
      String actualWord = reversed ? word.split('').reversed.join() : word;

      int row = _random.nextInt(gridSize);
      int col = _random.nextInt(gridSize);

      List<Point<int>> positions = [];

      int endRow = row + dir.x * (actualWord.length - 1);
      int endCol = col + dir.y * (actualWord.length - 1);

      // Asegurarse de que la palabra encaje
      if (endRow < 0 ||
          endRow >= gridSize ||
          endCol < 0 ||
          endCol >= gridSize) {
        continue;
      }

      bool canPlace = true;

      for (int i = 0; i < actualWord.length; i++) {
        int newRow = row + dir.x * i;
        int newCol = col + dir.y * i;
        String currentLetter = grid[newRow][newCol];

        if (currentLetter != '' && currentLetter != actualWord[i]) {
          canPlace = false;
          break;
        }

        positions.add(Point(newRow, newCol));
      }

      if (canPlace) {
        for (int i = 0; i < actualWord.length; i++) {
          int newRow = row + dir.x * i;
          int newCol = col + dir.y * i;
          grid[newRow][newCol] = actualWord[i];
        }

        insertedWords.add(InsertedWord(word: word, positions: positions));
        return;
      }
    }

    debugPrint('❌ No se pudo insertar la palabra: $word');
  }

  void _fillEmptyCells() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (grid[row][col] == '') {
          grid[row][col] = letters[_random.nextInt(letters.length)];
        }
      }
    }
  }

  void _onCellTap(int row, int col) {
    setState(() {
      selectedPath.add(Point(row, col));
      selectedPositions[row][col] = true;
    });

    String selectedWord = _buildWordFromPath();

    if (selectedWord == questions[currentQuestionIndex].answer.toUpperCase()) {
      _playSound('success.mp3');
      foundWords.add(selectedWord);
      _onCorrectAnswer(selectedWord);
      selectedPath.clear();
      _clearSelection();
      hintPositions.clear();
      _moveToNextQuestion();
    } else if (selectedWord.length >=
        questions[currentQuestionIndex].answer.length) {
      _playSound('wrong1.mp3');
      selectedPath.clear();
      _clearSelection();
    }
  }

  String _buildWordFromPath() {
    return selectedPath.map((p) => grid[p.x][p.y]).join();
  }

  void _clearSelection() {
    selectedPositions = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => false),
    );
  }

  Color _getCellColor(int row, int col) {
    final point = Point(row, col);

    if (hintPositions.contains(point)) {
      return Colors.grey[300]!;
    }

    for (int i = 0; i < foundWords.length; i++) {
      final word = foundWords[i];
      final inserted = insertedWords.firstWhere(
        (w) => w.word == word,
        orElse: () => InsertedWord(word: '', positions: []),
      );
      if (inserted.positions.any((p) => p.x == row && p.y == col)) {
        return wordColors[i % wordColors.length].withOpacity(0.5);
      }
    }

    return selectedPositions[row][col] ? Colors.yellow : Colors.white;
  }

  @override
  void dispose() {
    timer?.cancel();
    _backgroundPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressPercent = (currentQuestionIndex + 1) / questions.length;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Trivia + Sopa de Letras"),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  widget.category,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Puntaje: $score',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Tiempo restante: $timeRemaining s",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 8),
            Text(
              questions[currentQuestionIndex].text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            // 🧠 Pregunta actual / total
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Pregunta ${currentQuestionIndex + 1} de ${questions.length}",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            // 🟢 Barra de progreso animada debajo de la pregunta
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progressPercent),
                duration: Duration(milliseconds: 500),
                builder: (context, value, child) {
                  // Interpolación del color según progreso
                  Color progressColor;
                  if (value < 0.33) {
                    progressColor = Colors.red;
                  } else if (value < 0.66) {
                    progressColor = Colors.orange;
                  } else {
                    progressColor = Colors.green;
                  }

                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey[300],
                    color: progressColor,
                    minHeight: 8,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: _showHints,
                icon: Icon(Icons.help_outline),
                label: Text("Ayuda"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(12),
                itemCount: gridSize * gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ gridSize;
                  int col = index % gridSize;
                  return GestureDetector(
                    onTap: () => _onCellTap(row, col),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: _getCellColor(row, col),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(
                        grid[row][col],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

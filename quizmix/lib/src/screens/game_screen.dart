import 'dart:math';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
      ),
    );
  }
}

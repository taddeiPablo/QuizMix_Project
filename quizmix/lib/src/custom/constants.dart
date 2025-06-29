import 'package:flutter/material.dart';

class Constants {
  static String quizLogosrc = 'assets/images/quiz_logo.png';

  // TIPOS DE LETRAS A UTILIZAR
  static TextStyle fontTitle = TextStyle(
    color: const Color.fromARGB(255, 102, 3, 81),
    fontSize: 35,
    fontFamily: 'baloo',
    fontWeight: FontWeight.bold,
  );

  static TextStyle fontGame = TextStyle(
    color: const Color.fromARGB(255, 255, 255, 255),
    fontSize: 35,
    fontFamily: 'baloo',
    fontWeight: FontWeight.bold,
  );

  static TextStyle fontCategory = TextStyle(
    color: const Color.fromARGB(255, 255, 255, 255),
    fontSize: 35,
    fontFamily: 'baloo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle fontScore = TextStyle(
    color: const Color.fromARGB(255, 255, 255, 255),
    fontSize: 22,
    fontFamily: 'baloo',
    fontWeight: FontWeight.bold,
  );

  static TextStyle fontQuestions = TextStyle(
    color: Colors.amber,
    fontSize: 25,
    fontFamily: 'baloo',
    fontWeight: FontWeight.bold,
  );
}

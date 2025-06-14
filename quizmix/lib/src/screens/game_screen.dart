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

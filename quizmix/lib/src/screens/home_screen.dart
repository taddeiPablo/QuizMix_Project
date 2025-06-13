// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quizmix/src/custom/constants.dart';
import 'package:quizmix/src/screens/categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //, backgroundColor: Colors.deepPurple
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
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/title_logo.png', width: 325),
              SizedBox(height: 20),
              Image.asset('assets/images/answer_logo.png', width: 205),
              //Text('QuizMix', style: Constants.fontTitle),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen()),
                  );
                },
                child: Text('Individual'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen()),
                  );
                },
                child: Text('Cronometrado'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen()),
                  );
                },
                child: Text('Desafio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

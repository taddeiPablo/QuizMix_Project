// ignore: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizmix/src/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Text('QuizMix', style: Constants.fontTitle),
              // Puedes cambiar esto por un logo o imagen temática
              SizedBox(height: 20),
              Image.asset('assets/images/title_logo_nuevo.png', width: 340),
              Image.asset('assets/images/answer_logo.png', width: 220),
              SizedBox(height: 10),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

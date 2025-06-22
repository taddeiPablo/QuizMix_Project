// ignore: file_names
import 'package:flutter/material.dart';
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
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/title_logo_nuevo.png', width: 325),
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
                child: SizedBox(
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 25, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        'Individual',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen()),
                  );
                },
                child: SizedBox(
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, size: 25, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        'Timer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen()),
                  );
                },
                child: SizedBox(
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 20, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        'Desafio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

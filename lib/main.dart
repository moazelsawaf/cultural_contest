import 'package:cultural_contest/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: QuizScreen(),
    );
  }
}


import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>QuizProvider()),
      ],
      child: const MyApp(),
    ),);

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        fontFamily: 'Cairo',
        backgroundColor: Colors.white,
      ),
      home: QuizScreen(),
    );
  }
}

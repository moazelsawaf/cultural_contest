import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/quiz_screen.dart';
import 'package:cultural_contest/screens/result_screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizWrapper extends StatelessWidget {
  const QuizWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _quizProvider = context.read<QuizProvider>();
    return FutureBuilder(
        future: _quizProvider.loadQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          print(_quizProvider.questions.length);
          return _quizProvider.currentQuestion == _quizProvider.questions.length
              ? const ResultScreen()
              : const QuizScreen();
        });
  }
}

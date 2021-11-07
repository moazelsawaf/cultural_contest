import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_setup_screen/quiz_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<QuizProvider>().loadQuestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return QuizSetupScreen();
      },
    );
  }
}

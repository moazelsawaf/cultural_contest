import 'package:cultural_contest/models/question_model.dart';
import 'package:flutter/material.dart';

enum Team{firstTeam,secondTeam}

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = const [
    Question(
      id: 0,
      question: 'What is your name?',
      answer: 'Ahmed Nasser',
    ),
    Question(
      id: 1,
      question: 'What is your country?',
      answer: 'Egypt',
    ),
    Question(
      id: 2,
      question: 'What is your GPA?',
      answer: '3.5',
    ),
  ];

  List<Question> get questions => [..._questions];
  int currentQuestion = 0;
  int questionTime = 30;
  int questionScore = 3;

  String firstTeamName = 'Team 1';
  String secondTeamName = 'Team 2';

  double firstTeamScore = 0;
  double secondTeamScore = 0;

  void updateScore({Team team}) {
    if (team == Team.firstTeam) {
      firstTeamScore += questionScore;
    } else {
      secondTeamScore += questionScore;
    }
    notifyListeners();
  }
}

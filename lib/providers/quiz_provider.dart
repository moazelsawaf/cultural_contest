import 'dart:async';

import 'package:cultural_contest/models/question_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

enum Team { firstTeam, secondTeam }

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = const [
    // Question(
    //   id: 0,
    //   question: 'What is your name?',
    //   answer: 'Ahmed Nasser',
    // ),
    // Question(
    //   id: 1,
    //   question: 'What is your country?',
    //   answer: 'Egypt',
    // ),
    // Question(
    //   id: 2,
    //   question: 'What is your GPA?',
    //   answer: '3.5',
    // ),
  ];

  List<Question> get questions => [..._questions];
  int currentQuestion = 0;
  int questionTime = 5;
  int questionScore = 3;

  String firstTeamName = 'Team 1';
  String secondTeamName = 'Team 2';

  double firstTeamScore = 0;
  double secondTeamScore = 0;

  bool firstTeamAnswered = false;
  bool secondTeamAnswered = false;

  int currentTime = 0;

  bool get showAnswer => firstTeamAnswered && secondTeamAnswered;

  Timer _timer;

  void getAnswer({Team team, bool correct}) {
    if (team == Team.firstTeam) {
      if (correct) {
        firstTeamScore += questionScore;
      }
      firstTeamAnswered = true;
    } else {
      if (correct) {
        secondTeamScore += questionScore;
      }
      secondTeamAnswered = true;
    }

    notifyListeners();
  }

  void nextQuestion() {
    currentQuestion++;
    firstTeamAnswered = false;
    secondTeamAnswered = false;
    currentTime = 0;
    startTimer();

    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (currentTime < questionTime) {
          currentTime++;
          notifyListeners();
        } else {
          _timer.cancel();
        }
      },
    );
  }

  Future<void> loadQuestions() async {
    ByteData data = await rootBundle.load("xlsx/questions.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        final question = Question(
          id: row[0],
          question: row[2],
          answer: row[3],
        );
        print(row);
        // _questions.add(question);
      }
    }
  }
}

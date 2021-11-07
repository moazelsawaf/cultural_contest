import 'dart:async';

import 'package:cultural_contest/models/question_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

enum Team { firstTeam, secondTeam }

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = [];
  List<Question> get questions => [..._questions];

  final List<Question> _filteredQuestions = [];
  List<Question> get filteredQuestions => [..._filteredQuestions];

  int currentQuestion = 0;
  int currentTime = 0;

  int questionTime;
  double questionScore;
  int quizQuestions;
  String firstTeamName;
  String secondTeamName;

  double firstTeamScore = 0;
  double secondTeamScore = 0;

  bool firstTeamAnswered = false;
  bool secondTeamAnswered = false;

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
    try {
      ByteData data = await rootBundle.load("xlsx/questions.xlsx");
      var bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      var excel = Excel.decodeBytes(bytes);

      for (int i = 0; i < excel.tables.keys.length; i++) {
        final table = excel.tables.keys.elementAt(i);
        for (int j = 1; j < excel.tables[table].rows.length; j++) {
          final row = excel.tables[table].rows[j];

          final question = Question(
            id: row[0],
            category: row[1].toString(),
            question: row[2].toString(),
            answer: row[3].toString(),
          );

          _questions.add(question);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void filterQuestions() {
    _questions.shuffle();

    print('testtest: ${_questions.length}');

    final categories = [
      'العلمي',
      'المعلومات العامة',
      'الرياضيه',
      'الفنيه',
      'التاريخيه'
    ];

    for (String category in categories) {
      var temporaryQuestion = _questions
          .where((question) => question.category == category)
          .take(quizQuestions ~/ 5)
          .toList();

      _filteredQuestions.addAll(temporaryQuestion);

      for (Question question in temporaryQuestion) {
        _questions.removeWhere((gq) => gq.id == question.id);
      }
    }

    _filteredQuestions.shuffle();
  }

  void resetQuiz() {
    firstTeamScore = 0;
    secondTeamScore = 0;
    currentQuestion = 0;
    currentTime = 0;
    firstTeamAnswered = false;
    secondTeamAnswered = false;
    _filteredQuestions.clear();
  }
}

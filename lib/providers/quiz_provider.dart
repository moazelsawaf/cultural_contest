import 'dart:async';
import 'dart:convert';

import 'package:cultural_contest/models/category.dart';
import 'package:cultural_contest/models/question.dart';
import 'package:cultural_contest/questions.dart';
import 'package:flutter/material.dart';

enum Team { firstTeam, secondTeam }

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = [];
  List<Question> get questions => [..._questions];

  final List<Question> _filteredQuestions = [];
  List<Question> get filteredQuestions => [..._filteredQuestions];

  final List<Category> categories = [
    Category(
      name: 'العلمية',
      color: Colors.blue,
      questionsCount: 0,
    ),
    Category(
      name: 'العامة',
      color: Colors.orange,
      questionsCount: 0,
    ),
    Category(
      name: 'الرياضية',
      color: Colors.green,
      questionsCount: 0,
    ),
    Category(
      name: 'الفنية',
      color: Colors.red,
      questionsCount: 0,
    ),
    Category(
      name: 'التاريخية',
      color: Colors.brown,
      questionsCount: 0,
    ),
    Category(
      name: 'الإضافية',
      color: Colors.deepOrange,
      questionsCount: 0,
    ),
  ];

  int currentQuestion = 0;

  int get currentCategoryQuestion =>
      (currentQuestion % _categoryQuestionsCount) + 1;

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

  int get _categoryQuestionsCount => quizQuestions ~/ 5;

  bool get showNextQuestion => firstTeamAnswered && secondTeamAnswered;

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

      if (currentQuestion == _filteredQuestions.length - 1 &&
          firstTeamScore == secondTeamScore) {
        _filteredQuestions.add(_getAdditionalQuestion());
      }
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

  Question _getAdditionalQuestion() {
    final question =
        _questions.firstWhere((q) => q.category.name == 'الإضافية');
    _questions.removeWhere((q) => q.id == question.id);
    categories
        .firstWhere((category) => category.name == 'الإضافية')
        .questionsCount++;
    return question;
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
    final decodedQuestions = json.decode(questionsAsJson) as List<dynamic>;

    for (var fetchedQuestion in decodedQuestions) {
      final question = Question(
        id: fetchedQuestion['id'],
        category: categories.firstWhere((category) =>
            category.name == fetchedQuestion['category'].toString()),
        question: fetchedQuestion['question'].toString(),
        answer: fetchedQuestion['answer'].toString(),
      );

      _questions.add(question);
    }
  }

  void filterQuestions() {
    // _questions.shuffle();

    for (Category category in categories) {
      if (category.name == 'الإضافية') {
        return;
      }

      var temporaryQuestion = _questions
          .where((question) {
            if (question.category == category) {
              question.category.questionsCount = _categoryQuestionsCount;
              return true;
            }
            return false;
          })
          .take(_categoryQuestionsCount)
          .toList();

      _filteredQuestions.addAll(temporaryQuestion);

      for (Question question in temporaryQuestion) {
        _questions.removeWhere((gq) => gq.id == question.id);
      }
    }

    // _filteredQuestions.shuffle();
  }

  void resetQuiz() {
    firstTeamScore = 0;
    secondTeamScore = 0;
    currentQuestion = 0;
    currentTime = 0;
    firstTeamAnswered = false;
    secondTeamAnswered = false;
    _filteredQuestions.clear();
    for (var category in categories) {
      category.questionsCount = 0;
    }
  }
}

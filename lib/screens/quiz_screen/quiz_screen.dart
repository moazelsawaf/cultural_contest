import 'dart:async';

import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/result_screen/result_screen.dart';
import 'package:cultural_contest/widgets/credits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/primary_button.dart';
import 'local_widgets/team_answer_buttons.dart';
import 'local_widgets/team_info.dart';
import 'local_widgets/time_progress.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key key,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer _timer;
  bool _isInit = false;
  QuizProvider _quizProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _quizProvider = context.watch<QuizProvider>();
      _quizProvider.startTimer();
      _isInit = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _nextQuestion() {
    if (_quizProvider.currentQuestion <
        _quizProvider.filteredQuestions.length - 1) {
      _quizProvider.nextQuestion();
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return const ResultScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TimeProgress(
            totalTime: _quizProvider.questionTime,
            currentTime: _quizProvider.currentTime,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      TeamInfo(
                        teamName: _quizProvider.secondTeamName,
                        score: _quizProvider.secondTeamScore,
                        winner: _quizProvider.secondTeamScore >
                            _quizProvider.firstTeamScore,
                      ),
                      const Spacer(),
                      TeamInfo(
                        teamName: _quizProvider.firstTeamName,
                        score: _quizProvider.firstTeamScore,
                        winner: _quizProvider.firstTeamScore >
                            _quizProvider.secondTeamScore,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'سؤال ${_quizProvider.currentQuestion + 1}/${_quizProvider.filteredQuestions.length}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _quizProvider
                        .filteredQuestions[_quizProvider.currentQuestion]
                        .question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (_quizProvider.currentTime == _quizProvider.questionTime &&
                      !_quizProvider.showAnswer) ...[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TeamAnswerButtons(
                          teamName: _quizProvider.secondTeamName,
                          trueHandler: _quizProvider.firstTeamAnswered
                              ? () => _quizProvider.getAnswer(
                                  team: Team.secondTeam, correct: true)
                              : null,
                          falseHandler: _quizProvider.firstTeamAnswered
                              ? () => _quizProvider.getAnswer(
                                  team: Team.secondTeam, correct: false)
                              : null,
                        ),
                        const SizedBox(width: 100),
                        TeamAnswerButtons(
                          teamName: _quizProvider.firstTeamName,
                          trueHandler: _quizProvider.firstTeamAnswered
                              ? null
                              : () => _quizProvider.getAnswer(
                                  team: Team.firstTeam, correct: true),
                          falseHandler: _quizProvider.firstTeamAnswered
                              ? null
                              : () => _quizProvider.getAnswer(
                                  team: Team.firstTeam, correct: false),
                        ),
                      ],
                    ),
                  ],
                  if (_quizProvider.showAnswer) ...[
                    const Spacer(),
                    const Text(
                      ':الاجابة الصحيحة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _quizProvider
                          .filteredQuestions[_quizProvider.currentQuestion]
                          .answer,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          color: Colors.blue,
                          label: _quizProvider.currentQuestion ==
                                  _quizProvider.filteredQuestions.length - 1
                              ? 'إظهار النتيجة'
                              : 'السؤال التالي',
                          icon: Icons.arrow_back,
                          onPressed: _nextQuestion,
                        ),
                      ],
                    ),
                  ],
                  const Spacer(),
                   const Credits()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

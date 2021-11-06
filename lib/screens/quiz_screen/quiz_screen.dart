import 'dart:async';

import 'package:cultural_contest/providers/quiz_provider.dart';
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
  int _currentTime = 25;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _startTimer();
      _isInit = true;
    }
  }

  void _startTimer() {
    final questionTime = context.read<QuizProvider>().questionTime;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_currentTime < questionTime) {
          setState(() {
            _currentTime++;
          });
        } else {
          _timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _quizProvider = context.watch<QuizProvider>();
    return Scaffold(
      body: Column(
        children: [
          TimeProgress(
            totalTime: _quizProvider.questionTime,
            currentTime: _currentTime,
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
                        teamName: _quizProvider.firstTeamName,
                        score: _quizProvider.firstTeamScore,
                        winner: false,
                      ),
                      const Spacer(),
                      TeamInfo(
                        teamName: _quizProvider.secondTeamName,
                        score: _quizProvider.secondTeamScore,
                        winner: true,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'سؤال ${_quizProvider.currentQuestion + 1}/${_quizProvider.questions.length}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _quizProvider
                        .questions[_quizProvider.currentQuestion].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (_currentTime == _quizProvider.questionTime) ...[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TeamAnswerButtons(
                          teamName: _quizProvider.firstTeamName,
                          trueHandler: () =>
                              _quizProvider.updateScore(team: Team.firstTeam),
                        ),
                        const SizedBox(width: 100),
                        TeamAnswerButtons(
                          teamName: _quizProvider.secondTeamName,
                          trueHandler: () =>
                              _quizProvider.updateScore(team: Team.secondTeam),
                        ),
                      ],
                    ),
                  ],
                  if (false) ...[
                    const Text(
                      'الاجابة الصحيحه',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const Text(
                      'نعم للضحك والضحكاوية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    PrimaryButton(
                      color: Colors.blue,
                      label: 'السؤال التالي',
                      icon: Icons.arrow_back,
                      onPressed: () {},
                    ),
                  ],
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/fiscs_su_logo.png',
                        width: 120,
                        height: 120,
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/fiscs_colleage_logo.png',
                        width: 120,
                        height: 120,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

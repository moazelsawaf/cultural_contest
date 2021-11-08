import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/local_widgets/primary_button.dart';
import 'package:cultural_contest/screens/quiz_screen/local_widgets/team_info.dart';
import 'package:cultural_contest/screens/quiz_setup_screen/quiz_setup_screen.dart';
import 'package:cultural_contest/widgets/credits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _quizProvider = context.read<QuizProvider>();
    return Scaffold(
      body: Column(
        children: [
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
                        winner: false,
                      ),
                      const Spacer(),
                      TeamInfo(
                        teamName: _quizProvider.firstTeamName,
                        score: _quizProvider.firstTeamScore,
                        winner: false,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'الفائز هو:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/images/cup.png',
                    height: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _quizProvider.firstTeamScore > _quizProvider.secondTeamScore
                        ? _quizProvider.firstTeamName
                        : _quizProvider.secondTeamName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        color: Colors.blue,
                        label: 'القائمة الرئيسية',
                        icon: Icons.keyboard_arrow_left_sharp,
                        onPressed: () {
                          _quizProvider.resetQuiz();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return QuizSetupScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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

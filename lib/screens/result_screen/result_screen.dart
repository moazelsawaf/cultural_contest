import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/local_widgets/team_info.dart';
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
                    ':الفائز هو',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
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

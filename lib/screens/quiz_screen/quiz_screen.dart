import 'dart:async';

import 'package:flutter/material.dart';

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
  int _currentTime = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_currentTime < 60) {
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
    return Scaffold(
      body: Column(
        children: [
          TimeProgress(
            totalTime: 60,
            currentTime: _currentTime,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: const [
                    TeamInfo(
                      teamName: 'فريق المضحكين',
                      score: 10,
                      winner: false,
                    ),
                    Spacer(),
                    TeamInfo(
                      teamName: 'ضحكني ضحكني',
                      score: 20,
                      winner: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'سؤال 1/10',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'هل لقاحات كوفيد-19 آمنة للأشخاص المصابين بفيروس العوز المناعي البشري؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // Spacer(),
                Row( 
                  children: [
                    Image.asset(
                      'assets/images/fiscs_su_logo.png',
                      width: 150,
                      height: 150,
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/fiscs_colleage_logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TeamInfo extends StatelessWidget {
  final String teamName;
  final int score;
  final bool winner;

  const TeamInfo({
    Key key,
    this.teamName,
    this.score,
    this.winner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              teamName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (winner) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.sports_score_outlined,
                color: Colors.amber,
              ),
            ],
          ],
        ),
        Row(
          children: [
            Text(
              score.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.confirmation_num_rounded,
              color: Colors.amber,
            ),
          ],
        ),
      ],
    );
  }
}

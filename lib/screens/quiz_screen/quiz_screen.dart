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
        ],
      ),
    );
  }
}

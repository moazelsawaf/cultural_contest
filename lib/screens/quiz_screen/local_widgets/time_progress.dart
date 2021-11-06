import 'package:flutter/material.dart';

class TimeProgress extends StatelessWidget {
  final int totalTime;
  final int currentTime;
  final double width;

  const TimeProgress({
    Key key,
    this.totalTime,
    this.currentTime,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _timerColor;
    if (currentTime / totalTime < 0.25) {
      _timerColor = Colors.green;
    } else if (currentTime / totalTime < 0.75) {
      _timerColor = Colors.yellow;
    } else {
      _timerColor = Colors.red;
    }

    return SizedBox(
      height: 60,
      width: width,
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade200,
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: (currentTime / totalTime) * width,
            height: 60,
            color: _timerColor,
          ),
        ],
      ),
    );
  }
}

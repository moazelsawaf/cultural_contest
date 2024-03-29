import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
  final String teamName;
  final double score;
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
            if (winner) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.sports_score_outlined,
                color: Colors.amber,
              ),
            ],
            Text(
              teamName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.confirmation_num_rounded,
              color: Colors.amber,
            ),
            const SizedBox(width: 8),
            Text(
              score.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

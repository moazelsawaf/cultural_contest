import 'package:flutter/material.dart';

import 'primary_button.dart';

class TeamAnswerButtons extends StatelessWidget {
  final String teamName;
  final Function trueHandler;
  final Function falseHandler;

  const TeamAnswerButtons({
    Key key,
    this.teamName,
    this.trueHandler,
    this.falseHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          teamName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              color: Colors.green,
              icon: Icons.check_circle_outline,
              onPressed: trueHandler,
            ),
            const SizedBox(width: 32),
            PrimaryButton(
              color: Colors.red,
              icon: Icons.cancel_outlined,
              onPressed: falseHandler,
            ),
          ],
        ),
      ],
    );
  }
}

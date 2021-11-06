import 'package:flutter/material.dart';

import 'primary_button.dart';

class TeamAnswerButtons extends StatelessWidget {
  final String teamName;

  const TeamAnswerButtons({
    this.teamName,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          teamName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              buttonColor: Colors.red.withOpacity(0.3),
              borderButtonColor: Colors.red,
              isHaveText: false,
              icon: const Icon(
                Icons.cancel_outlined,
                size: 24,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            PrimaryButton(
              buttonColor: Colors.green.withOpacity(0.3),
              borderButtonColor: Colors.green,
              isHaveText: false,
              icon: const Icon(
                Icons.check_circle_outline,
                size: 24,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

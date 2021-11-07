import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/fiscs_su_logo.png',
          width: 120,
          height: 120,
        ),
        const Spacer(),
        const Text(
          'تحت إشراف رائد شباب الكلية: الدكتور أحمد عماد الدين\nعميد الكلية: أستاذ دكتور موسى ابراهيم موسى',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Image.asset(
          'assets/images/fiscs_colleage_logo.png',
          width: 120,
          height: 120,
        ),
      ],
    );
  }
}

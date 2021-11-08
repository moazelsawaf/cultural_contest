import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  final Color textColor;
  
  const Credits({
    Key key, this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/fiscs_colleage_logo.png',
          width: 120,
          height: 120,
        ),
        const Spacer(),
         Text(
          'تحت إشراف رائد شباب الكلية: الدكتور أحمد عماد الدين\nعميد الكلية: أستاذ دكتور موسى ابراهيم موسى',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Image.asset(
          'assets/images/fiscs_su_logo.png',
          width: 120,
          height: 120,
        ),
      ],
    );
  }
}

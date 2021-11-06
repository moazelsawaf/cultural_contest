import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final Color borderButtonColor;
  final Icon icon;
  final bool isHaveText;
  final String textButton;

  const PrimaryButton({
    this.buttonColor,
    this.borderButtonColor,
    this.icon,
    this.isHaveText = false,
    this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHaveText ? 120 : 90,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          onSurface: borderButtonColor,
        ),
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: isHaveText
              ? Row(
                  children: [
                    icon,
                    SizedBox(width: 4,),
                    Text(
                      textButton,
                      style: TextStyle(color: borderButtonColor, fontSize: 18),
                    )
                  ],
                )
              : icon,
        ),
      ),
    );
  }
}

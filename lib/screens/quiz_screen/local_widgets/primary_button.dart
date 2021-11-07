import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Function onPressed;

  const PrimaryButton({
    Key key,
    this.color = Colors.blue,
    this.icon,
    this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        primary: color,
        side: BorderSide(
          width: 0.5,
          color: color,
        ),
        minimumSize: const Size(150, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
            ),
          ],
          const SizedBox(width: 12),
          if (label != null)
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}

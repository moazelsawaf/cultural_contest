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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: color,
        onPrimary: Colors.white,
        minimumSize: const Size(150, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (label != null) ...[
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 12),
          ],
          if (icon != null)
            Icon(
              icon,
              size: 20,
            ),
        ],
      ),
    );
  }
}

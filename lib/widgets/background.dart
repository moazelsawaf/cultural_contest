import 'dart:async';

import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final Widget child;
  const Background({Key key, this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  Timer _timer;
  int _currentImage = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        setState(() {
          if (_currentImage == 2) {
            _currentImage = 1;
          } else {
            _currentImage++;
          }
        });
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.65), BlendMode.srcOver),
          image: AssetImage('assets/images/wallpapers/$_currentImage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: widget.child,
    );
  }
}

//

import 'package:flutter/material.dart';

import 'flashingCursor.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final Duration duration;
  const AnimatedText(this.text, this.duration, {Key? key}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      builder: (context, int value, child) {
        return Row(
          children: [
            Text(
              widget.text.substring(0, value),
              style: TextStyle(color: Colors.cyan),
            ),
            FlashingCursor()
          ],
        );
      },
      duration: Duration(seconds: 3),
      tween: IntTween(begin: 0, end: widget.text.length),
    );
  }
}

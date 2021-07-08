//

import 'package:flutter/material.dart';

import 'flashing_cursor.dart';

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
              style: const TextStyle(color: Colors.cyan),
            ),
            const FlashingCursor()
          ],
        );
      },
      duration: const Duration(seconds: 3),
      tween: IntTween(begin: 0, end: widget.text.length),
    );
  }
}

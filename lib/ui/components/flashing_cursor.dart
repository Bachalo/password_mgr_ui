//

import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';

class FlashingCursor extends StatefulWidget {
  const FlashingCursor({Key? key}) : super(key: key);

  @override
  _FlashingCursorState createState() => _FlashingCursorState();
}

class _FlashingCursorState extends State<FlashingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity:
            _animationController.drive(CurveTween(curve: Curves.easeInOut)),
        child: const Text(
          "_",
          style: TextStyle(color: kSecondaryFontColor),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

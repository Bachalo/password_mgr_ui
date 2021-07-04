import 'package:flutter/material.dart';

class FlashingCursor extends StatefulWidget {
  @override
  _FlashingCursorState createState() => _FlashingCursorState();
}

class _FlashingCursorState extends State<FlashingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity:
            _animationController.drive(CurveTween(curve: Curves.easeInOut)),
        child: Text(
          "_",
          style: TextStyle(color: Colors.cyan),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

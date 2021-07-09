//

import 'package:flutter/material.dart';

import '../scheme.dart';

class AnimatedBottomButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AnimatedBottomButton(this.buttonText, this.onPressed, {Key? key})
      : super(key: key);

  @override
  _AnimatedBottomButtonState createState() => _AnimatedBottomButtonState();
}

class _AnimatedBottomButtonState extends State<AnimatedBottomButton> {
  var _hovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      child: Center(
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              _hovering = true;
            });
          },
          onExit: (event) {
            setState(() {
              _hovering = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.ease,
              height: _hovering ? 100 * 1.1 : 100,
              width: _hovering ? 291 * 1.1 : 291,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: _hovering ? kPrimaryLight : kPrimaryDark,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.ease,
                  style: _hovering
                      ? kMainFont(
                          const TextStyle(
                            color: Colors.black,
                            fontSize: 24 * 1.4,
                            fontWeight: kFontBold,
                          ),
                        )
                      : kMainFont(
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: kFontBold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                  child: Text(widget.buttonText),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

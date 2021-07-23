//

import 'package:flutter/material.dart';

import '../scheme.dart';

class AnimatedBottomButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool loading;
  final Color staticColor;
  final Color hoveringColor;
  const AnimatedBottomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.loading = false,
    this.staticColor = kPrimaryDark,
    this.hoveringColor = kPrimaryLight,
  }) : super(key: key);

  @override
  _AnimatedBottomButtonState createState() => _AnimatedBottomButtonState();
}

class _AnimatedBottomButtonState extends State<AnimatedBottomButton> {
  var _hovering = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height / 8.12,
      width: screenSize.width / 1.28,
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
              height: _hovering
                  ? screenSize.height / 8.12 * 1.1
                  : screenSize.height / 8.12,
              width: _hovering
                  ? screenSize.width / 1.28 * 1.1
                  : screenSize.width / 1.28,
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
                color: _hovering ? widget.hoveringColor : widget.staticColor,
              ),
              child: Center(
                child: widget.loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.ease,
                        style: _hovering
                            ? const TextStyle(
                                color: Colors.black,
                                fontSize: 24 * 1.4,
                                fontWeight: kFontBold,
                              )
                            : const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: kFontBold,
                                fontStyle: FontStyle.italic,
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

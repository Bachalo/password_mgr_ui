//

import 'package:flutter/material.dart';

import '../scheme.dart';

class AnimatedFormTextFlied extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String fieldTitlte;
  final bool obscureText;
  final IconData prefixIcon;
  const AnimatedFormTextFlied(
      {required this.controller,
      required this.validator,
      required this.fieldTitlte,
      required this.obscureText,
      required this.prefixIcon,
      Key? key})
      : super(key: key);

  @override
  _AnimatedFormTextFieldState createState() => _AnimatedFormTextFieldState();
}

class _AnimatedFormTextFieldState extends State<AnimatedFormTextFlied> {
  final FocusNode _focusNode = FocusNode();
  bool _inFocus = false;

  // final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  _onFocusChange() {
    setState(() {
      _inFocus = !_inFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      width: screenSize.width * 0.733333333,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: AnimatedContainer(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 100),
                child: TextFormField(
                    validator: widget.validator,
                    cursorColor: kPrimaryDark,
                    style: const TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 16,
                      fontWeight: kFontBold,
                      fontStyle: FontStyle.italic,
                    ),
                    obscureText: widget.obscureText,
                    controller: widget.controller,
                    focusNode: _focusNode,
                    decoration: kInputDecoration(widget.prefixIcon)),
              ),
            ),
            Positioned(
              top: 0,
              left: 8,
              child: AnimatedDefaultTextStyle(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  style: _inFocus
                      ? TextStyle(
                          color: kPrimaryDark,
                          fontWeight: kFontBold,
                          fontSize: 24,
                          shadows: kFontShadow,
                          fontStyle: FontStyle.italic,
                        )
                      : TextStyle(
                          color: Colors.black,
                          fontWeight: kFontBold,
                          fontSize: 24,
                          shadows: kFontShadow,
                          fontStyle: FontStyle.italic,
                        ),
                  child: Text(widget.fieldTitlte)),
            ),
          ],
        ),
      ),
    );
  }
}

//

import 'package:flutter/material.dart';

import '../scheme.dart';

class AnimatedFormTextFlied extends StatefulWidget {
  final TextEditingController controller;
  final String fieldTitlte;
  final bool obscureText;
  const AnimatedFormTextFlied(
      {required this.controller,
      required this.fieldTitlte,
      required this.obscureText,
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

  _onFocusChange() {
    setState(() {
      _inFocus = !_inFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 275,
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
                  cursorColor: kPrimaryDark,
                  style: kMainFont(
                    const TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 16,
                      fontWeight: kFontBold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  obscureText: widget.obscureText,
                  controller: widget.controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: kPrimaryDark,
                    fillColor: kSecondaryAccent,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: kTextFieldBorderSide),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: kTextFieldBorderSide),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: kTextFieldBorderSide),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 8,
              child: AnimatedDefaultTextStyle(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  style: _inFocus
                      ? kMainFont(
                          TextStyle(
                            color: kPrimaryDark,
                            fontWeight: kFontBold,
                            fontSize: 24,
                            shadows: kFontShadow,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : kMainFont(
                          TextStyle(
                            color: Colors.black,
                            fontWeight: kFontBold,
                            fontSize: 24,
                            shadows: kFontShadow,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                  child: Text(widget.fieldTitlte)),
            ),
          ],
        ),
      ),
    );
  }
}

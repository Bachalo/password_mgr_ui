//

import 'package:flutter/material.dart';

import '../scheme.dart';

class AnimatedFormTextFlied extends StatefulWidget {
  const AnimatedFormTextFlied({Key? key}) : super(key: key);

  @override
  _AnimatedFormTextFieldState createState() => _AnimatedFormTextFieldState();
}

class _AnimatedFormTextFieldState extends State<AnimatedFormTextFlied> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  _onFocusChange() {
    print("You've locked onto textfield ");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            child: TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                filled: true,
                focusColor: kPrimaryDark,
                fillColor: kSecondaryAccent,
                border: OutlineInputBorder(gapPadding: 0.0),
              ),
            ),
          ),
          const Text("JGIFDGJDIFGJIDJFGDIJGFgd"),
        ],
      ),
    );
  }
}

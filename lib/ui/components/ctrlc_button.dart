//

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class CtrlCButton extends StatefulWidget {
  final String text;
  const CtrlCButton(this.text, {Key? key}) : super(key: key);

  @override
  _CtrlCButtonState createState() => _CtrlCButtonState();
}

class _CtrlCButtonState extends State<CtrlCButton> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (checked) {
            FlutterClipboard.copy(widget.text).then((value) => print("copied"));
          } else {
            setState(() {
              checked = !checked;
            });
            FlutterClipboard.copy(widget.text).then((value) => print("copied"));
          }
        },
        child: checked ? const Icon(Icons.check) : const Text("CTRL-C"));
  }
}

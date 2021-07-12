//

import 'package:flutter/material.dart';

import '../scheme.dart';

class CheckBoxField extends StatefulWidget {
  final String text;
  const CheckBoxField(this.text, {Key? key}) : super(key: key);

  @override
  _CheckBoxFieldState createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
  var _checked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.2,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: kSecondaryAccent,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Checkbox(
                activeColor: Colors.transparent,
                checkColor: Colors.black,
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = !_checked;
                  });
                }),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Keep me loged in",
          style: kMainFont(
            TextStyle(
                fontSize: 18,
                fontWeight: kFontBold,
                shadows: kFontShadow,
                fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }
}

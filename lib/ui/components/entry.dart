//

import 'package:flutter/material.dart';

import 'animatedText.dart';
import 'ctrlcButton.dart';

class Entry extends StatelessWidget {
  final String login;
  final String password;
  const Entry(this.login, this.password, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   width: 50,
        // ),
        Container(
          child: AnimatedText(
            login,
            Duration(microseconds: 300),
          ),
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CtrlCButton(login),
        ),
        // SizedBox(
        //   width: 50,
        // ),
        Container(
          child: AnimatedText(
            password,
            Duration(microseconds: 300),
          ),
          width: 100,
        ),
        // SizedBox(
        //   width: 50,
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CtrlCButton(password),
        ),
      ],
    );
  }
}

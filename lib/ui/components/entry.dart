//

import 'package:flutter/material.dart';

import 'animated_text.dart';
import 'ctrlc_button.dart';

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
        SizedBox(
          width: 100,
          child: AnimatedText(
            login,
            const Duration(microseconds: 300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CtrlCButton(login),
        ),
        SizedBox(
          width: 100,
          child: AnimatedText(
            password,
            const Duration(microseconds: 300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CtrlCButton(password),
        ),
      ],
    );
  }
}

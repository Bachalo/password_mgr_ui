//

import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Size screenSize;
  const LoginForm({required this.screenSize, Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const AnimatedFormTextFlied(),
          const AnimatedFormTextFlied(),

          // Container(
          //   decoration: const BoxDecoration(),
          //   child: const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: TextField(
          // decoration: InputDecoration(
          //   focusedBorder: OutlineInputBorder(),
          //   filled: true,
          //   focusColor: kPrimaryDark,
          //   fillColor: kSecondaryAccent,
          //   border: OutlineInputBorder(gapPadding: 0.0),
          // ),
          //     ),
          //   ),
          // ),
          // const TextField(
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     focusColor: Colors.cyan,
          //     fillColor: kSecondaryDark,
          //     filled: true,
          //     border: OutlineInputBorder(),
          //     labelText: 'password',
          //     labelStyle: TextStyle(color: Colors.cyan),
          //   ),
          // ),

          // BOTTOM BUTTON
          AnimatedBottomButton("LOGIN", () {
            print("lolo");
          }),
          SizedBox(
            height: widget.screenSize.height / 10,
          )
        ],
      ),
    );
  }
}

//

import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/components/checkbox_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: emailTextController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your username";
              }
              return null;
            },
            fieldTitlte: "email",
            obscureText: false,
          ),
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: passwordTextController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your username";
              }
              return null;
            },
            fieldTitlte: "password",
            obscureText: true,
          ),
          const CheckBoxField("Keep me logged in"),
          AnimatedBottomButton("LOGIN", () {
            print(emailTextController.text + passwordTextController.text);
          }),
          SizedBox(
            height: screenSize.height / 10,
          )
        ],
      ),
    );
  }
}

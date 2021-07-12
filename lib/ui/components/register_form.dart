//

import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/components/checkbox_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Size screenSize;
  const RegisterForm({required this.screenSize, Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController usernameTextController = TextEditingController();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFormTextFlied(
            controller: usernameTextController,
            fieldTitlte: "username",
            obscureText: false,
          ),
          AnimatedFormTextFlied(
            controller: emailTextController,
            fieldTitlte: "email",
            obscureText: false,
          ),
          AnimatedFormTextFlied(
            controller: passwordTextController,
            fieldTitlte: "password",
            obscureText: true,
          ),
          const CheckBoxField("I agree to the terms of service"),
          AnimatedBottomButton("REGISTER", () {
            print(emailTextController.text + passwordTextController.text);
          }),
          SizedBox(
            height: widget.screenSize.height / 10,
          )
        ],
      ),
    );
  }
}

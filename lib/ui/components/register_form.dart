//

import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/components/checkbox_field.dart';
import 'package:email_validator/email_validator.dart';
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
    var screenSize = MediaQuery.of(context).size;
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: usernameTextController,
            validator: (value) {
              if (value!.length <= 7) {
                return "Please enter a username";
              }
              return null;
            },
            fieldTitlte: "username",
            obscureText: false,
          ),
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: emailTextController,
            fieldTitlte: "email",
            validator: (value) => EmailValidator.validate(value!)
                ? null
                : "Please enter a valid email",
            obscureText: false,
          ),
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: passwordTextController,
            fieldTitlte: "password",
            validator: (value) {
              if (value!.length <= 7) {
                return "Please enter a password";
              }
              return null;
            },
            obscureText: true,
          ),
          const CheckBoxField("I agree to the terms of service"),
          AnimatedBottomButton("REGISTER", () async {
            if (_formKey.currentState!.validate()) {
              print(emailTextController.text + passwordTextController.text);
            }
          }),
          SizedBox(
            height: widget.screenSize.height / 10,
          )
        ],
      ),
    );
  }
}

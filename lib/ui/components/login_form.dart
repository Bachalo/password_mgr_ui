//

import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/provider.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/pages/index.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../scheme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  var approved = false;
  var loading = false;
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: emailTextController,
            validator: (value) => EmailValidator.validate(value!)
                ? null
                : "Please enter a valid email",
            fieldTitlte: "email",
            obscureText: false,
            prefixIcon: Icons.email,
          ),
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: passwordTextController,
            validator: (value) {
              if (value!.length <= 7) {
                return "Please enter a password";
              }
              return null;
            },
            fieldTitlte: "password",
            obscureText: true,
            prefixIcon: Icons.password,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Checkbox(
                    value: approved,
                    onChanged: (value) {
                      setState(() {
                        approved = !approved;
                      });
                    }),
              ),
              Text(
                "Keep me logged in",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: kFontBold,
                    shadows: kFontShadow,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Expanded(
            child: Consumer<SplashScreenProvider>(
              builder: (context, splashScreenProvider, child) =>
                  AnimatedBottomButton("LOGIN", () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  final ResponseMessage message = await Services.login(
                      emailTextController.text, passwordTextController.text);
                  setState(() {
                    loading = false;
                  });
                  if (message.response == "succesful" ||
                      message.response == "You are already logged in") {
                    approved ? SharedPrefs.setPref("isLoggedIn", true) : null;
                    splashScreenProvider.goHome();
                    await Future.delayed(const Duration(milliseconds: 250));
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: const Index()),
                    );
                  }
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message.response)));
                }
              }, loading),
            ),
          )
        ],
      ),
    );
  }
}

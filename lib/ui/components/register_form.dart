//

import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/provider.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:chrome_extension/ui/components/checkbox_form_field.dart';
import 'package:chrome_extension/ui/pages/index.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../scheme.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController usernameTextController = TextEditingController();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var loading = false;

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
        mainAxisAlignment: MainAxisAlignment.start,
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
            prefixIcon: Icons.supervised_user_circle,
          ),
          AnimatedFormTextFlied(
            screenSize: screenSize,
            controller: emailTextController,
            fieldTitlte: "email",
            validator: (value) => EmailValidator.validate(value!)
                ? null
                : "Please enter a valid email",
            obscureText: false,
            prefixIcon: Icons.email,
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
            prefixIcon: Icons.password,
          ),
          CheckboxFormField(
              title: Row(
                children: [
                  Text(
                    "I agree to the",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: kFontBold,
                        shadows: kFontShadow,
                        fontStyle: FontStyle.italic),
                  ),
                  TextButton(
                    onPressed: () {
                      launchTOS();
                    },
                    child: Text(
                      " terms of service",
                      style: TextStyle(
                          color: kPrimaryDark,
                          fontSize: 18,
                          fontWeight: kFontBold,
                          shadows: kFontShadow,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
              onSavedd: (value) {
                print(value);
              },
              validatorr: (value) {
                if (value == true) {
                  return null;
                } else {
                  return "* Required";
                }
              }),
          // const CheckBoxField("I agree to the", " terms of service "),
          Expanded(
            child: Consumer<SplashScreenProvider>(
              builder: (context, splashScreenProvider, child) =>
                  AnimatedBottomButton("REGISTER", () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  final ResponseMessage message = await Services.register(
                      usernameTextController.text,
                      emailTextController.text,
                      passwordTextController.text);
                  setState(() {
                    loading = false;
                  });
                  if (message.response == "succesful") {
                    await Services.login(
                        emailTextController.text, passwordTextController.text);
                    SharedPrefs.setPref("isLoggedIn", true);
                    splashScreenProvider.goHome();
                    // await Future.delayed(const Duration(milliseconds: 200));
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
          ),
        ],
      ),
    );
  }
}

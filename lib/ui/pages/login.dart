//

import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/services/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  // Global key for form
  final _formKey = GlobalKey<FormState>();
  final String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Password_mgr",
            style: TextStyle(fontSize: 45, color: Colors.cyan),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Login",
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 450,
                    child: TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      controller: emailTextController,
                      style: const TextStyle(
                        color: Colors.cyan,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.cyan,
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.cyan),
                        hoverColor: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 450,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length <= 7) {
                          return "Please enter a password";
                        }
                        return null;
                      },
                      controller: passwordTextController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.cyan,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.cyan,
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.cyan),
                        hoverColor: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, routeName)
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "FORGOT YOUR PASSWORD?",
                  style: TextStyle(color: Colors.cyan),
                ),
              )),
          const SizedBox(
            height: 150,
          ),
          CupertinoButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final ResponseMessage message = await Services.login(
                    emailTextController.text, passwordTextController.text);
                if (message.response == "succesful" ||
                    message.response == "You are already logged in") {
                  SharedPrefs.setPref("isLoggedIn", true);
                  final status = await SharedPrefs.getPref("isLoggedIn");
                  print(status);
                  Navigator.pushReplacementNamed(context, "/home");
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.response)));
              }
            },
            color: Colors.cyan,
            child: const Text("LOGIN"),
          ),
          Text(_message),
        ],
      ),
    );
  }
}

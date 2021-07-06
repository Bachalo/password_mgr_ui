//

import 'package:chrome_extension/services/Services.dart';
import 'package:chrome_extension/services/models/responseModel.dart';
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
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Password_mgr",
            style: TextStyle(fontSize: 45, color: Colors.cyan),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 450,
                    child: TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      controller: emailTextController,
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.cyan,
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.cyan),
                        hoverColor: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.cyan,
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.cyan),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "FORGOT YOUR PASSWORD?",
                  style: TextStyle(color: Colors.cyan),
                ),
              )),
          SizedBox(
            height: 150,
          ),
          CupertinoButton(
            child: Text("LOGIN"),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                ResponseMessage message = await Services.login(
                    emailTextController.text, passwordTextController.text);
                if (message.response == "succesful" ||
                    message.response == "You are already logged in") {
                  SharedPrefs.setPref("isLoggedIn", true);
                  var status = await SharedPrefs.getPref("isLoggedIn");
                  print(status);
                  Navigator.pushReplacementNamed(context, "/home");
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.response)));
              }
            },
            color: Colors.cyan,
          ),
          Text(_message),
        ],
      ),
    );
  }
}

//

import 'package:chrome_extension/services/Services.dart';
import 'package:chrome_extension/services/models/responseModel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Password_mgr",
              style: TextStyle(fontSize: 45),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Register",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 400,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 0) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: nameTextController,
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.cyan,
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Username',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Please same password";
                          if (value != passwordTextController.text) {
                            return "Please enter same password";
                          }
                          return null;
                        },
                        controller: confirmPasswordTextController,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.cyan,
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(color: Colors.cyan),
                          hoverColor: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoButton(
            child: Text("REGISTER"),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                ResponseMessage message = await Services.register(
                    nameTextController.text,
                    emailTextController.text,
                    passwordTextController.text);
                if (message.response == "succesful") {
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
        ],
      ),
    );
  }
}

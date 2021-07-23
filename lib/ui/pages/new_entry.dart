import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:flutter/material.dart';

import '../scheme.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({Key? key}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final TextEditingController appNameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  final TextEditingController urlTextEditingController =
      TextEditingController();

  final TextEditingController appTagtextEditingController =
      TextEditingController();

  var loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(36.0),
                child: Text(
                  "ADD NEW PASSWORD",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryDark),
                ),
              ),
              Container(
                width: screenSize.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: kSecondaryDark,
                  boxShadow: [
                    BoxShadow(
                      color: kShadowColor,
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        AnimatedFormTextFlied(
                          controller: appNameTextEditingController,
                          validator: (value) {
                            if (value!.length <= 3) {
                              return "App name is required";
                            }
                            return null;
                          },
                          fieldTitlte: "app Name",
                          obscureText: false,
                          prefixIcon: Icons.apps,
                        ),
                        AnimatedFormTextFlied(
                          controller: emailTextEditingController,
                          validator: (value) {
                            if (value!.length <= 3) {
                              return "username or email is required";
                            }
                            return null;
                          },
                          fieldTitlte: "username/Email",
                          obscureText: false,
                          prefixIcon: Icons.email,
                        ),
                        AnimatedFormTextFlied(
                          controller: passwordTextEditingController,
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
                        AnimatedFormTextFlied(
                          controller: urlTextEditingController,
                          validator: (value) {
                            if (value!.length <= 9) {
                              return "Valid url is required";
                            }
                            return null;
                          },
                          fieldTitlte: "url",
                          obscureText: false,
                          prefixIcon: Icons.link,
                        ),
                        AnimatedFormTextFlied(
                          controller: appTagtextEditingController,
                          validator: (value) {},
                          fieldTitlte: "app tag",
                          obscureText: false,
                          prefixIcon: Icons.tag,
                        ),
                        AnimatedBottomButton(
                            buttonText: "ADD NEW PASSWORD",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final ResponseMessage message =
                                    await Services.addNew(
                                  appNameTextEditingController.text,
                                  passwordTextEditingController.text,
                                  emailTextEditingController.text,
                                  urlTextEditingController.text,
                                  appTagtextEditingController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message.response)));
                                Navigator.pop(context);
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

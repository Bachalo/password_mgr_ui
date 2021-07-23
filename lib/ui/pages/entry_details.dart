import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../scheme.dart';

class EntryDetailsPage extends StatefulWidget {
  const EntryDetailsPage(
      {required this.id,
      required this.email,
      required this.password,
      required this.url,
      Key? key})
      : super(key: key);

  final int id;
  final String email;
  final String password;
  final String url;

  @override
  _EntryDetailsPageState createState() => _EntryDetailsPageState();
}

class _EntryDetailsPageState extends State<EntryDetailsPage> {
  TextEditingController appNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController appTagTextController = TextEditingController();
  TextEditingController urlTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var loading = false;
  @override
  void initState() {
    super.initState();
    emailTextController.text = widget.email;
    passwordTextController.text = widget.password;
  }

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
                  "Edit entry",
                  style: TextStyle(
                    fontSize: 32,
                    color: kPrimaryDark,
                    fontWeight: kFontBold,
                  ),
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
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        AnimatedFormTextFlied(
                          controller: appNameTextController,
                          fieldTitlte: "App name",
                          validator: (value) {
                            return value!.isEmpty
                                ? "You can't leave this field empty"
                                : null;
                          },
                          obscureText: false,
                          prefixIcon: Icons.apps,
                        ),
                        AnimatedFormTextFlied(
                          controller: emailTextController,
                          fieldTitlte: "email",
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                          obscureText: false,
                          prefixIcon: Icons.email,
                        ),
                        AnimatedFormTextFlied(
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
                        AnimatedFormTextFlied(
                          controller: appTagTextController,
                          fieldTitlte: "App Tag",
                          validator: (value) {
                            if (value!.length <= 2) {
                              return "Please enter app tag";
                            }
                            return null;
                          },
                          obscureText: false,
                          prefixIcon: Icons.tag,
                        ),
                        AnimatedFormTextFlied(
                          controller: urlTextController,
                          fieldTitlte: "url",
                          validator: (value) {
                            if (value!.length <= 5) {
                              return "Please enter a valid url";
                            }
                            return null;
                          },
                          obscureText: false,
                          prefixIcon: Icons.link,
                        ),
                        AnimatedBottomButton(
                          buttonText: "SAVE",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          loading: loading,
                        ),
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

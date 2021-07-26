import 'package:chrome_extension/services/models/details_model.dart';
import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/components/animated_textfield.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:flutter/cupertino.dart';
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
    _updateTextFields();
  }

  void _updateTextFields() async {
    var data = await Services.getDetails(widget.id);
    setState(() {
      appNameTextController.text = data.appNAme;
      emailTextController.text = data.email;
      passwordTextController.text = data.password;
      appTagTextController.text = data.appTag;
      urlTextController.text = data.urlAddress;
    });
  }

  @override
  void dispose() {
    appNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    appTagTextController.dispose();
    urlTextController.dispose();
    super.dispose();
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
                          fieldTitlte: "username/Email",
                          validator: (value) {
                            if (value!.length <= 3) {
                              return "username or email is required";
                            }
                            return null;
                          },
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              DetailsModel data =
                                  await Services.getDetails(widget.id);
                              print(widget.id);
                              print(data.appNAme);
                              print(data.password);
                              print(data.email);

                              print(data.urlAddress);

                              print(data.appTag);

                              print(emailTextController.text);
                              ResponseMessage message = await Services.edit(
                                  widget.id,
                                  data.appNAme,
                                  data.password,
                                  data.email,
                                  data.urlAddress,
                                  data.appTag,
                                  appNameTextController.text,
                                  passwordTextController.text,
                                  emailTextController.text,
                                  urlTextController.text,
                                  appTagTextController.text);
                              print(message);
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context);
                            }
                          },
                          loading: loading,
                        ),
                        const SizedBox(height: 20),
                        AnimatedBottomButton(
                          staticColor: const Color(0xFFfc584c),
                          hoveringColor: const Color(0xFFff756b),
                          buttonText: "DELETE PASSOWRD",
                          onPressed: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Are you sure ?"),
                                    content: const Text(
                                        "Do you really want to delete this password"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("NO"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          DetailsModel data =
                                              await Services.getDetails(
                                                  widget.id);
                                          await Services.remove(
                                              data.appNAme,
                                              data.password,
                                              data.email,
                                              data.urlAddress,
                                              data.appTag);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("YES"),
                                      ),
                                    ],
                                  );
                                });
                          },
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

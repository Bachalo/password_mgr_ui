//

import 'dart:js' as js;
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/models/search_model.dart';
import 'package:chrome_extension/ui/components/animated_text.dart';
import 'package:chrome_extension/ui/components/ctrlc_button.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String text = "CTRL-C";
  dynamic url = js.JsObject.fromBrowserObject(js.context['state']);

  late Future _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getFuture();
  }

  Future<List<SearchResult>> _getFuture() async {
    return Services.search(url["currentURL"]);
  }

  @override
  Widget build(BuildContext context) {
    final url = js.JsObject.fromBrowserObject(js.context['state']);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: AnimatedText(
            "${url["currentURL"]}", const Duration(microseconds: 300)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _userFuture = _getFuture();
                });
              },
              icon: const Icon(Icons.update)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.1),
        hoverColor: Colors.grey.withOpacity(0.2),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => _showPopupInput(context, url));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: _userFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final List<SearchResult> _futureList = snapshot.data;
              return ListView.builder(
                itemCount: _futureList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 20,
                    shadowColor: Colors.black,
                    color: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              child: Icon(Icons.password_sharp,
                                  size: 34, color: Colors.grey[800]),
                            ),
                            const Text(
                              "Facebook",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(_futureList[index].email),
                              const Spacer(),
                              CtrlCButton(_futureList[index].email)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(_futureList[index]
                                  .password
                                  .replaceAll(RegExp("."), "*"))
                              // Text(,_futureList[index].password),
                              ,
                              const Spacer(),
                              CtrlCButton(_futureList[index].password)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.short_text,
                                    color: Colors.grey[800]),
                              ),
                              const Text("Social Media"),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.update,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const Text("24 hours ago")
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

Widget _showPopupInput(BuildContext context, url) {
  final TextEditingController newEmailTextController = TextEditingController();
  final TextEditingController newPasswordTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return AlertDialog(
    backgroundColor: Colors.grey[900],
    title: const Text(
      "Add new password",
      style: TextStyle(color: Colors.cyan),
    ),
    content: SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 1) {
                            return "Please enter a email";
                          }
                          return null;
                        },
                        controller: newEmailTextController,
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
                        controller: newPasswordTextController,
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
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  TextButton(
                      onPressed: () async {
                        final ResponseMessage message = await Services.addNew(
                            newPasswordTextController.text,
                            newEmailTextController.text,
                            url["currentURL"]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message.response)));
                      },
                      child: const Icon(Icons.add))
                ],
              ))
        ],
      ),
    ),
  );
}

//

import 'dart:js' as js;
import 'package:chrome_extension/services/Services.dart';
import 'package:chrome_extension/services/models/responseModel.dart';
import 'package:chrome_extension/services/models/searchModel.dart';
import 'package:chrome_extension/ui/components/animatedText.dart';
import 'package:chrome_extension/ui/components/ctrlcButton.dart';
import 'package:chrome_extension/ui/components/entry.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var text = "CTRL-C";
  var url = js.JsObject.fromBrowserObject(js.context['state']);

  late Future _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getFuture();
  }

  _getFuture() async {
    // return await Services.search(url["currentURL"]);
    return await Services.search(url["currentURL"]);
  }

  @override
  Widget build(BuildContext context) {
    var url = js.JsObject.fromBrowserObject(js.context['state']);
    // print(url["currentURL"]);
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:
              AnimatedText("${url["currentURL"]}", Duration(microseconds: 300)),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _userFuture = _getFuture();
                  });
                },
                icon: Icon(Icons.update)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/settings");
                },
                icon: Icon(Icons.settings))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.withOpacity(0.1),
          hoverColor: Colors.grey.withOpacity(0.2),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _showPopupInput(context, url));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: FutureBuilder(
              future: _userFuture,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<SearchResult> _futureList = snapshot.data;
                  return Container(
                    child: ListView.builder(
                      itemCount: _futureList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 20,
                          shadowColor: Colors.black,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10.0),
                                    child: Icon(Icons.password_sharp,
                                        size: 34, color: Colors.grey[800]),
                                  ),
                                  Text(
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
                                    Spacer(),
                                    CtrlCButton(_futureList[index].email)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                        '${_futureList[index].password.replaceAll(RegExp(r"."), "*")}')
                                    // Text(,_futureList[index].password),
                                    ,
                                    Spacer(),
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
                                    Text("Social Media"),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.update,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Text("24 hours ago")
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                        // return Entry(_futureList[index].email,
                        //     _futureList[index].password);
                      },
                    ),
                  );
                }
              }),
        ));
  }
}

Widget _showPopupInput(BuildContext context, url) {
  TextEditingController newEmailTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  return new AlertDialog(
    backgroundColor: Colors.grey[900],
    title: const Text(
      "Add new password",
      style: TextStyle(color: Colors.cyan),
    ),
    content: Container(
      height: 400,
      child: new Column(
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
                    child: Container(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 1) {
                            return "Please enter a email";
                          }
                          return null;
                        },
                        controller: newEmailTextController,
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
                        controller: newPasswordTextController,
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
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                  TextButton(
                      onPressed: () async {
                        print(url["currentURL"]);
                        ResponseMessage message = await Services.addNew(
                            newPasswordTextController.text,
                            newEmailTextController.text,
                            url["currentURL"]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message.response)));
                      },
                      child: Icon(Icons.add))
                ],
              ))
        ],
      ),
    ),
  );
}

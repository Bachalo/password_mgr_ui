//

import 'dart:js' as js;
import 'package:chrome_extension/ui/components/animatedText.dart';
import 'package:chrome_extension/ui/components/entry.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var text = "CTRL-C";

  @override
  Widget build(BuildContext context) {
    var url = js.JsObject.fromBrowserObject(js.context['state']);
    print(url["currentURL"]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            AnimatedText("${url["currentURL"]}", Duration(microseconds: 300)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

//

import 'package:chrome_extension/services/Services.dart';
import 'package:chrome_extension/ui/components/animatedText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: AnimatedText(
          "Seetings",
          Duration(seconds: 1),
        ),
      ),
      body: Column(
        children: [
          Spacer(),
          Center(
            child: CupertinoButton(
                child: Text("LOGOUT"),
                color: Colors.red,
                onPressed: () async {
                  final message = await Services.logout();
                  if (message.response == "succesful") {
                    SharedPrefs.setPref("isLoggedIn", false);
                    Navigator.pushNamedAndRemoveUntil(context, "/splashScreen",
                        ModalRoute.withName("/splashScreen"));
                  }
                  print(message.response);
                }),
          )
        ],
      ),
    );
  }
}

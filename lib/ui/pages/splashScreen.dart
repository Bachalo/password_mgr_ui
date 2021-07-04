//

import 'package:chrome_extension/ui/components/animatedText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final string = "PASSWORD_MGR";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedText(string, Duration(seconds: 3)),
          ),
          SizedBox(height: 400),
          TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/home");
              },
              child: Text("Continue offline")),
          CupertinoButton(
            child: Text("LOGIN"),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            color: Colors.cyan,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DON'T HAVE AN ACCOUNT ? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.cyan),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

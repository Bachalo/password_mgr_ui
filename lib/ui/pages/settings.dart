//

import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/components/animted_bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../scheme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(36.0),
                  child: Text(
                    "SETTINGS",
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
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.4),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: AnimatedBottomButton(
                          buttonText: "LOGOUT",
                          onPressed: () async {
                            final message = await Services.logout();
                            if (message.response == "succesful") {
                              SharedPrefs.setPref("isLoggedIn", false);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/splashScreen",
                                  ModalRoute.withName("/splashScreen"));
                            }
                            print(message.response);
                          },
                          staticColor: const Color(0xFFfc584c),
                          hoveringColor: const Color(0xFFff756b),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

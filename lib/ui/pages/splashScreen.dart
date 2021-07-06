//

import 'package:chrome_extension/ui/components/animatedText.dart';
import 'package:chrome_extension/ui/scheme.dart';
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
      backgroundColor: kBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 340,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 139,
                    child: Text(
                      "Your password manager",
                      textAlign: TextAlign.center,
                      style: kMainFont(
                        TextStyle(
                          fontSize: 13,
                          color: kPrimary_light,
                          fontWeight: kFontRegular,
                          shadows: kFontShadow,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("PASSWORD_MGR",
                      style: kMainFont(
                        TextStyle(
                          fontSize: 18,
                          color: kPrimary_dark,
                          fontWeight: kFontBold,
                        ),
                      )),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 112,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: kSecondary_dark,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "LOGIN",
                    style: kMainFont(
                      TextStyle(
                          fontSize: 24,
                          color: kPrimary_dark,
                          fontWeight: kFontBold,
                          shadows: kFontShadow),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: kMainFont(
                        TextStyle(
                          fontSize: 14,
                          color: kPrimary_light,
                          fontWeight: kFontMedium,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        "REGISTER",
                        style: kMainFont(
                          TextStyle(
                            fontSize: 24,
                            color: kPrimary_dark,
                            fontWeight: kFontBold,
                            shadows: kFontShadow,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

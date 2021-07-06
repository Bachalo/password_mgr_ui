//

import 'package:chrome_extension/services/Services.dart';
import 'package:chrome_extension/ui/pages/index.dart';
import 'package:chrome_extension/ui/pages/login.dart';
import 'package:chrome_extension/ui/pages/register.dart';
import 'package:chrome_extension/ui/pages/splashScreen.dart';
import 'package:chrome_extension/ui/pages/settings.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  var status = await SharedPrefs.getPref("isLoggedIn");
  print(status);
  runApp(
    MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: kMainFont_color,
        displayColor: kSecondaryFont_color,
      )),
      // home: RegisterScreen(),
      home: status == true ? Index() : SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splashScreen': (ctx) => SplashScreen(),
        '/home': (ctx) => Index(),
        '/settings': (ctx) => SettingsPage(),
        '/login': (ctx) => LoginScreen(),
        '/register': (ctx) => RegisterScreen()
      },
    ),
  );
}

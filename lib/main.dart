//

import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/ui/pages/index.dart';
import 'package:chrome_extension/ui/pages/login.dart';
import 'package:chrome_extension/ui/pages/register.dart';
import 'package:chrome_extension/ui/pages/splash_screen.dart';
import 'package:chrome_extension/ui/pages/settings.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  final status = await SharedPrefs.getPref("isLoggedIn");
  runApp(
    MaterialApp(
      onGenerateRoute: (settings) {},
      theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: kPrimaryDark,
                onSecondary: kPrimaryDark,
              ),
          accentColor: kPrimaryDark,
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: kMainFontColor,
            displayColor: kSecondaryFontColor,
          )),
      // home: RegisterScreen(),
      home: status == true ? const Index() : const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splashScreen': (ctx) => const SplashScreen(),
        '/home': (ctx) => const Index(),
        '/settings': (ctx) => const SettingsPage(),
        '/login': (ctx) => const LoginScreen(),
        '/register': (ctx) => const RegisterScreen()
      },
    ),
  );
}

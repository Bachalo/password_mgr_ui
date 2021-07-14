//

import 'package:chrome_extension/ui/components/login_form.dart';
import 'package:chrome_extension/ui/components/register_form.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var _registering = false;
  var _logging = false;
  var _complete = false;

  void _showRegisterForm(screenSize) {
    setState(() {
      _registering = true;
      _logging = false;
    });
  }

  void _showLoginForm() {
    setState(() {
      _registering = false;
      _logging = true;
    });
  }

  void _goBack() {
    setState(() {
      _registering = false;
      _logging = false;
    });
  }

  Widget _screenToShow(screenSize) {
    if (_registering == true && _logging == false && _complete == true) {
      return RegisterForm(screenSize: screenSize);
    } else if (_registering == false && _logging == true && _complete == true) {
      return const LoginForm();
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  child: (_registering == true || _logging == true)
                      ? IconButton(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 32.0,
                          ),
                          onPressed: () {
                            _goBack();
                          },
                        )
                      : const SizedBox()),
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 139,
                    child: Text(
                      "Your password manager",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: kPrimaryLight,
                        fontWeight: kFontRegular,
                        shadows: kFontShadow,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "PASSWORD_MGR",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryDark,
                      fontWeight: kFontBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AnimatedContainer(
            onEnd: () {
              setState(() {
                _complete = !_complete;
              });
            },
            height: (_registering == true || _logging == true)
                ? screenSize.height * 0.7
                : 112,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutCubic,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                AnimatedSwitcher(
                  duration: kAnimationDuration,
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(child: child, scale: animation),
                  child: !_registering
                      ? AnimatedSwitcher(
                          duration: kAnimationDuration,
                          switchInCurve: Curves.easeInOutCubic,
                          switchOutCurve: Curves.easeInOutCubic,
                          transitionBuilder: (Widget child,
                                  Animation<double> animation) =>
                              ScaleTransition(child: child, scale: animation),
                          child: !_logging
                              ? TextButton(
                                  onPressed: () {
                                    _showLoginForm();
                                  },
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: kPrimaryDark,
                                          fontWeight: kFontBold,
                                          shadows: kFontShadow)),
                                )
                              : const Text("LOGIN",
                                  style: TextStyle(
                                    fontSize: 48,
                                    color: Colors.black,
                                    fontWeight: kFontBold,
                                  )),
                        )
                      : const SizedBox(),
                ),
                AnimatedSwitcher(
                  duration: kAnimationDuration,
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(child: child, scale: animation),
                  child: !_logging
                      ? AnimatedSwitcher(
                          duration: kAnimationDuration,
                          switchInCurve: Curves.easeInOutCubic,
                          switchOutCurve: Curves.easeInOutCubic,
                          transitionBuilder: (Widget child,
                                  Animation<double> animation) =>
                              ScaleTransition(child: child, scale: animation),
                          child: !_registering
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      const Text(
                                        "Don't have an account ?",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: kPrimaryLight,
                                          fontWeight: kFontMedium,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      TextButton(
                                        onPressed: () {
                                          _showRegisterForm(screenSize);
                                        },
                                        child: Text("REGISTER",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: kPrimaryDark,
                                                fontWeight: kFontBold,
                                                shadows: kFontShadow)),
                                      ),
                                    ])
                              : Text("REGISTER",
                                  style: TextStyle(
                                      fontSize: 48,
                                      color: Colors.black,
                                      fontWeight: kFontBold,
                                      shadows: kFontShadow)),
                        )
                      : const SizedBox(),
                ),
                Expanded(
                  child: SizedBox(
                    width: screenSize.width,
                    child: AnimatedSwitcher(
                      duration: kAnimationDuration,
                      switchInCurve: Curves.easeInOutCubic,
                      switchOutCurve: Curves.easeInOutCubic,
                      child: _screenToShow(screenSize),
                    ),
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

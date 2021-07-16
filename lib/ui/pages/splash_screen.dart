//

import 'dart:js' as js;
import 'package:chrome_extension/services/provider.dart';
import 'package:chrome_extension/ui/components/login_form.dart';
import 'package:chrome_extension/ui/components/register_form.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var _complete = false;
  dynamic url = js.JsObject.fromBrowserObject(js.context['state']);

  Widget _screenToShow(registering, logging, transition) {
    if (registering == true &&
        logging == false &&
        _complete == true &&
        transition == false) {
      return const RegisterForm();
    } else if (registering == false &&
        logging == true &&
        _complete == true &&
        transition == false) {
      return const LoginForm();
    } else {
      return const SizedBox();
    }
  }

  double _height(registering, logging, transition, screenSize) {
    if (registering || logging && transition == false) {
      return screenSize.height * 0.7;
    } else if (registering == false &&
        logging == false &&
        transition == false) {
      return 112;
    } else if (registering == false && logging == false && transition == true) {
      return screenSize.height * 0.92;
    } else {
      return 112;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackground,
      body: ChangeNotifierProvider<SplashScreenProvider>(
        create: (context) => SplashScreenProvider(),
        child: Consumer<SplashScreenProvider>(
          builder: (context, provider, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      child: (provider.registering == true ||
                              provider.logging == true &&
                                  provider.transition == false)
                          ? IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 32.0,
                              ),
                              onPressed: () => provider.goBack(),
                            )
                          : const SizedBox()),
                ),
              ),
              const Spacer(),
              Center(
                child: AnimatedSwitcher(
                    duration: kAnimationDuration,
                    child: !provider.transition
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 139,
                                  child: Text(
                                    url["currentURL"],
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
                          )
                        : const SizedBox()),
              ),
              const Spacer(),
              AnimatedContainer(
                onEnd: () {
                  setState(() {
                    _complete = !_complete;
                  });
                },
                height: _height(provider.registering, provider.logging,
                    provider.transition, screenSize),
                // (provider.registering == true || provider.logging == true)
                //     ? screenSize.height * 0.7
                //     : 112,
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
                child: AnimatedSwitcher(
                    duration: kAnimationDuration,
                    child: !provider.transition
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              AnimatedSwitcher(
                                duration: kAnimationDuration,
                                switchInCurve: Curves.easeInOutCubic,
                                switchOutCurve: Curves.easeInOutCubic,
                                transitionBuilder: (Widget child,
                                        Animation<double> animation) =>
                                    ScaleTransition(
                                        child: child, scale: animation),
                                child: !provider.registering
                                    ? AnimatedSwitcher(
                                        duration: kAnimationDuration,
                                        switchInCurve: Curves.easeInOutCubic,
                                        switchOutCurve: Curves.easeInOutCubic,
                                        transitionBuilder: (Widget child,
                                                Animation<double> animation) =>
                                            ScaleTransition(
                                                child: child, scale: animation),
                                        child: !provider.logging
                                            ? TextButton(
                                                onPressed: () =>
                                                    provider.showLoginForm(),
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
                                transitionBuilder: (Widget child,
                                        Animation<double> animation) =>
                                    ScaleTransition(
                                        child: child, scale: animation),
                                child: !provider.logging
                                    ? AnimatedSwitcher(
                                        duration: kAnimationDuration,
                                        switchInCurve: Curves.easeInOutCubic,
                                        switchOutCurve: Curves.easeInOutCubic,
                                        transitionBuilder: (Widget child,
                                                Animation<double> animation) =>
                                            ScaleTransition(
                                                child: child, scale: animation),
                                        child: !provider.registering
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      onPressed: () => provider
                                                          .showRegisterForm(),
                                                      child: Text("REGISTER",
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color:
                                                                  kPrimaryDark,
                                                              fontWeight:
                                                                  kFontBold,
                                                              shadows:
                                                                  kFontShadow)),
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
                                    child: _screenToShow(provider.registering,
                                        provider.logging, provider.transition),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: screenSize.width,
                            height: 300,
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

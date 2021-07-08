//

import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final string = "PASSWORD_MGR";
  var _expanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backArrowAnimationTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: FadeTransition(
                opacity: backArrowAnimationTween,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = false;
                      controller.reverse();
                    });
                  },
                ),
              ),
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
                      style: kMainFont(
                        TextStyle(
                          fontSize: 13,
                          color: kPrimaryLight,
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
                        const TextStyle(
                          fontSize: 18,
                          color: kPrimaryDark,
                          fontWeight: kFontBold,
                        ),
                      )),
                ),
              ],
            ),
          ),
          const Spacer(),
          // AnimatedContainer(
          //   height: _expanded ? 200.0 : 274.0,
          //   duration: const Duration(milliseconds: 300),
          // ),
          AnimatedContainer(
            height: _expanded ? 582 : 112,
            duration: const Duration(milliseconds: 300),
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
              // color: kSecondaryDark,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      controller.forward();
                      _expanded = true;
                    });
                    // Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "LOGIN",
                    style: kMainFont(
                      TextStyle(
                          fontSize: 24,
                          color: kPrimaryDark,
                          fontWeight: kFontBold,
                          shadows: kFontShadow),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: kMainFont(
                        const TextStyle(
                          fontSize: 14,
                          color: kPrimaryLight,
                          fontWeight: kFontMedium,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        "REGISTER",
                        style: kMainFont(
                          TextStyle(
                            fontSize: 24,
                            color: kPrimaryDark,
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

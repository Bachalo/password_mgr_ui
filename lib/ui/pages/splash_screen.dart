//

import 'package:chrome_extension/ui/components/login_form.dart';
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
  late final AnimationController _backArrowController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late final AnimationController _bottomTextController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  late final Animation<double> _backArrowAnimation =
      CurvedAnimation(parent: _backArrowController, curve: Curves.easeIn);

  final string = "PASSWORD_MGR";
  var _expanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _backArrowController.dispose();
    _bottomTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final bottomTextAnimationTween = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_bottomTextController);

    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: FadeTransition(
                opacity: _backArrowAnimation,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = false;
                      _backArrowController.reverse();
                      _bottomTextController.reverse();
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
          AnimatedContainer(
            height: _expanded ? screenSize.height * 0.7 : 112,
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
                TextButton(
                  onPressed: () async {
                    _bottomTextController.forward();

                    // await Future.delayed(
                    //     const Duration(milliseconds: 100), () {});
                    _expanded = true;
                    setState(() {
                      _backArrowController.forward();
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    curve: Curves.easeInOutQuad,
                    style: _expanded
                        ? kMainFont(TextStyle(
                            fontSize: 48,
                            color: Colors.black,
                            fontWeight: kFontBold,
                            shadows: kFontShadow))
                        : kMainFont(TextStyle(
                            fontSize: 24,
                            color: kPrimaryDark,
                            fontWeight: kFontBold,
                            shadows: kFontShadow)),
                    duration: const Duration(
                      milliseconds: 450,
                    ),
                    child: const Text("LOGIN"),
                  ),
                ),

                // const SizedBox(
                //   height: 12,
                // ),
                FadeTransition(
                  opacity: bottomTextAnimationTween,
                  child: Row(
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
                            onPressed: () async {
                              _backArrowController.forward();

                              setState(() {
                                _expanded = true;
                              });
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
                            )),
                      ]),
                ),
                Expanded(
                    child: Visibility(
                        visible: _expanded,
                        child: LoginForm(
                          screenSize: screenSize,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

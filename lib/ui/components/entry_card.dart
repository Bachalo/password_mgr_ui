//

import 'package:chrome_extension/ui/pages/entry_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../scheme.dart';

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key? key,
    required this.id,
    required this.appIcon,
    required this.appName,
    required this.email,
    required this.password,
    required this.url,
    required this.appTag,
  }) : super(key: key);

  final int id;
  final IconData appIcon;
  final String appName;
  final String email;
  final String password;
  final String url;
  final String appTag;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: screenSize.width * 0.91,
        height: screenSize.height * 0.30,
        decoration: BoxDecoration(
            color: kSecondaryAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 18.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(appIcon, color: kPrimaryDark, size: 32),
                  Text(
                    appName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            curve: Curves.easeInOutCubic,
                            duration: kAnimationDuration,
                            type: PageTransitionType.rightToLeftWithFade,
                            child: EntryDetailsPage(
                              id: id,
                              email: email,
                              password: password,
                              url: url,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: kPrimaryDark,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0.0, 18.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 18,
                          color: kSecondaryFontColor,
                          fontWeight: kFontBold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                          color: kPrimaryDark,
                          size: 24,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: email));
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        password.replaceAll(RegExp("."), "*"),
                        style: const TextStyle(
                          fontSize: 18,
                          color: kSecondaryFontColor,
                          fontWeight: kFontBold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                          color: kPrimaryDark,
                          size: 24,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: password));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    url,
                    style: const TextStyle(
                      fontSize: 18,
                      color: kSecondaryFontColor,
                      fontWeight: kFontMedium,
                    ),
                  ),
                  Text(
                    appTag,
                    style: const TextStyle(
                      fontSize: 18,
                      color: kSecondaryFontColor,
                      fontWeight: kFontMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

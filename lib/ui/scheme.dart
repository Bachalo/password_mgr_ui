//

import 'package:flutter/material.dart';

const Color kBackground = Colors.white;
const Color kPrimaryLight = Color(0xFFAA9ABA);
const Color kPrimaryDark = Color(0xFF8783D1);
const Color kSecondaryLight = Color(0xFFE3B9BC);
const Color kSecondaryDark = Color(0xFFD1ABAD);
const Color kSecondaryAccent = Color(0xFFBFA4A4);

// FONTS

const Color kMainFontColor = Colors.black;
const Color kSecondaryFontColor = Color(0xFF505050);

// FONT SHADOWS

final List<Shadow> kFontShadow = <Shadow>[
  Shadow(
    blurRadius: 4.0,
    color: Colors.black.withOpacity(0.20),
  )
];

const Color kShadowColor = Color(0x409E9E9E);

// FONT WEIGHTS

const FontWeight kFontBold = FontWeight.w700;
const FontWeight kFontRegular = FontWeight.w400;
const FontWeight kFontMedium = FontWeight.w500;

// ANIMATION TWEENS

const BorderSide kTextFieldBorderSide =
    BorderSide(width: 0, color: Colors.transparent, style: BorderStyle.none);

const Duration kAnimationDuration = Duration(milliseconds: 300);

// FORM FIELD SHIT
InputDecoration kInputDecoration(IconData icon) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
    prefixIcon: Icon(
      icon,
      color: const Color(0xFF505050),
    ),
    filled: true,
    focusColor: kPrimaryDark,
    fillColor: kSecondaryAccent,
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: kTextFieldBorderSide),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: kTextFieldBorderSide),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: kTextFieldBorderSide),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: kTextFieldBorderSide),
  );
}

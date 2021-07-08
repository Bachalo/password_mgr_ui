//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kBackground = Colors.white;
const Color kPrimaryLight = Color(0xFFAA9ABA);
const Color kPrimaryDark = Color(0xFF8783D1);
const Color kSecondaryLight = Color(0xFFE3B9BC);
const Color kSecondaryDark = Color(0xFFD1ABAD);

// FONTS

const Color kMainFontColor = Colors.black;
const Color kSecondaryFontColor = Color(0xFF505050);

// MAIN FONT
TextStyle kMainFont(TextStyle args) {
  return GoogleFonts.montserrat(textStyle: args);
}

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

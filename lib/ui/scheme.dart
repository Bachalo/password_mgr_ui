//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kBackground = Colors.white;
const Color kPrimary_light = Color(0xFFAA9ABA);
const Color kPrimary_dark = Color(0xFF8783D1);
const Color kSecondary_light = Color(0xFFE3B9BC);
const Color kSecondary_dark = Color(0xFFD1ABAD);

// FONTS

const Color kMainFont_color = Colors.black;
const Color kSecondaryFont_color = Color(0xFF505050);

// MAIN FONT
kMainFont(args) {
  return GoogleFonts.montserrat(textStyle: args);
}

// FONT SHADOWS

final List<Shadow> kFontShadow = <Shadow>[
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 4.0,
    color: Colors.black.withOpacity(0.20),
  )
];

// FONT WEIGHTS

const FontWeight kFontBold = FontWeight.w700;
const FontWeight kFontRegular = FontWeight.w400;
const FontWeight kFontMedium = FontWeight.w500;

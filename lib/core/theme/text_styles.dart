import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  MyStyles._();

  static final h1 = GoogleFonts.roboto(
    fontWeight: FontWeight.w800,
    fontSize: 24,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );
  static final h2 = GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    color: Colors.white,
  );
  static final h3 = GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.white,
  );
  static final bodyBold = GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.white,
  );
  static final body = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.white,
  );
  static final medium = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.white,
  );
}

import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  snackBarTheme: SnackBarThemeData(
    backgroundColor: MyColors.yellow,
    contentTextStyle: MyStyles.body.copyWith(color: Colors.black),
  ),
  brightness: Brightness.dark,
  primaryColor: MyColors.black,
  scaffoldBackgroundColor: const Color(0xFF151515),
  fontFamily: GoogleFonts.roboto().fontFamily,
  switchTheme: SwitchThemeData(
    
  )
);

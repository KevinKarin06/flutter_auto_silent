import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final double borderRadius = 6.0;

final ThemeData darkTheme = ThemeData();
final ThemeData ligthTheme = ThemeData(
  primaryColor: Colors.cyan,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.lato().fontFamily,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    ),
  ),
);

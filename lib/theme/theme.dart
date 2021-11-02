import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final double borderRadius = 6.0;

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.cyan,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    color: const Color(0x42000000),
  ),
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
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: Colors.cyan,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: const Color(0xffe0e0e0),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: Colors.cyan,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
  ),
);

///              ///
/// LIGHT THEME ///
///             ///

final ThemeData ligthTheme = ThemeData(
  primarySwatch: Colors.cyan,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    color: Colors.cyan,
  ),
  snackBarTheme: SnackBarThemeData(),
  primaryColor: Colors.cyan,
  fontFamily: GoogleFonts.lato().fontFamily,
  textTheme: TextTheme(),
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
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: const Color(0xff80deea),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: const Color(0xffe0e0e0),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      borderSide: const BorderSide(
        color: Colors.cyan,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // ignore: missing_return
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return Colors.cyan;
        }
      }),
      // ignore: missing_return
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return const Color(0xff000000);
        }
      }),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      // ignore: missing_return
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return Colors.cyan;
        }
      }),
      overlayColor: MaterialStateProperty.all(Colors.cyan.withOpacity(.15)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      // ignore: missing_return
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return Colors.cyan;
        }
      }),
      overlayColor: MaterialStateProperty.all(Colors.cyan.withOpacity(.15)),
    ),
  ),
);

class AppColors {
  static const error = Colors.red;
  static const success = Colors.green;
}

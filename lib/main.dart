import 'package:autosilentflutter/screens/intro.dart';
import 'package:dialog_context/dialog_context.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DialogContext().builder,
      title: 'Auto Silent',
      theme: ThemeData(
        primarySwatch: _isDark ? Colors.blue : Colors.cyan,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Intro(),
    );
  }
}

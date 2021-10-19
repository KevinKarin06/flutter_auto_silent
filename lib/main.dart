import 'package:autosilentflutter/screens/intro.dart';
import 'package:autosilentflutter/setup_locator.dart';
import 'package:autosilentflutter/theme/theme.dart';
import 'package:dialog_context/dialog_context.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_themes/stacked_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ThemeManager.initialise();
  setUp();
  runApp(
    EasyLocalization(
      useFallbackTranslations: true,
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.cyan[700],
        accentColor: Colors.cyan[700],
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      lightTheme: ligthTheme,
      builder: (BuildContext context, ThemeData regularTheme,
              ThemeData darkTheme, ThemeMode themeMode) =>
          MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        builder: DialogContext().builder,
        title: 'Auto Silent',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: Intro(),
      ),
    );
  }
}

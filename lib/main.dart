import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/screens/intro.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/setup_locator.dart';
import 'package:autosilentflutter/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:one_context/one_context.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ThemeManager.initialise();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await dotenv.load(fileName: ".env");
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
      darkTheme: darkTheme,
      lightTheme: ligthTheme,
      builder: (BuildContext context, ThemeData regularTheme,
              ThemeData darkTheme, ThemeMode themeMode) =>
          MaterialApp(
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        onGenerateRoute: AppRouter.generateRoutes,
        initialRoute: AppRouter.home,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        builder: OneContext().builder,
        title: 'Auto Silent',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: Intro(),
      ),
    );
  }
}

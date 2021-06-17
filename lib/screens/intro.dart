import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autosilentflutter/screens/home.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

class Intro extends StatefulWidget {
  const Intro({Key key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with WidgetsBindingObserver {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.cyan,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 15.0,
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _checkDonNotDisturb();
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('Paused');
        break;
      case AppLifecycleState.detached:
        print('Detached');
        break;
    }
  }

  Future<void> _init() async {
    return Future.delayed(Duration(seconds: 5), _checkDonNotDisturb);
  }

  Future<void> _checkDonNotDisturb() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt >= 7) {
        if (!await FlutterDnd.isNotificationPolicyAccessGranted) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Action Required'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                            ' You need to grant access to don not disturb Permission for the app to work properly'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop(animated: true);
                      },
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FlutterDnd.gotoPolicySettings();
                      },
                      child: Text(
                        'OK',
                      ),
                    ),
                  ],
                );
              });
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MyHomePage();
          }));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MyHomePage();
        }));
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Intro Widget Rebuilt');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: TextLiquidFill(
                    loadDuration: Duration(seconds: 4),
                    text: 'Auto Silent',
                    waveColor: Colors.cyan,
                    boxBackgroundColor: ThemeData().scaffoldBackgroundColor,
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 150.0,
                    boxWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.ac_unit,
                    size: 48.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedTextKit(
                  pause: Duration(milliseconds: 100),
                  stopPauseOnTap: false,
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Powered By Dc Corp',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

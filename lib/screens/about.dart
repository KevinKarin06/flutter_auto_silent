import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  color: Colors.red[300],
                  margin: EdgeInsets.only(bottom: 8.0),
                ),
                Text(
                  'Auto Silent',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text('v 1.0.0')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

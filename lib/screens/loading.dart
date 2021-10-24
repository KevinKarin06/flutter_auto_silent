import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger().d('Loading Screen Rebuilt');
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  final Future future;
  const LoadingDialog({Key key, this.future}) : super(key: key);
  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Colors.transparent.withOpacity(0.5),
      elevation: 12,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.height * 0.8,
        child: SizedBox(
          height: 100,
          width: 100,
          // child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

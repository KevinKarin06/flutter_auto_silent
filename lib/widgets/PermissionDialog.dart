import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  final Function onGrant;
  final String msg;
  const PermissionDialog({Key key, this.onGrant, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = msg;
    text ??=
        'You will need to grant Location permission for the app to work properly';
    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text('Permission Required'),
      ),
      elevation: 12,
      content: Container(
        child: Center(
          child: Text(text),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onGrant();
          },
          child: Text(
            'OK',
          ),
        ),
      ],
    );
  }
}

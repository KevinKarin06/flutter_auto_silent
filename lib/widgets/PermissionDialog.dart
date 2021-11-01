import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

class PermissionDialog extends StatelessWidget {
  final String msg;
  final Function onGrant;
  const PermissionDialog({Key key, this.msg, this.onGrant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text('action_required'),
      ),
      content: Container(
        child: Center(
          child: Text(msg).tr(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onGrant();
          },
          child: Text(
            'ok',
          ),
        ),
      ],
    );
  }
}

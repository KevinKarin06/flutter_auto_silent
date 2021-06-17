import 'package:flutter/material.dart';

SnackBar snackBar({bool error, String msg}) {
  return SnackBar(
    backgroundColor: error ? Colors.red : Colors.green,
    content: Row(
      children: [
        Icon(
          !error ? Icons.check_circle_rounded : Icons.error_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 10.0,
        ),
        Flexible(child: Text(msg))
      ],
    ),
  );
}

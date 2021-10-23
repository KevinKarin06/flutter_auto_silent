import 'package:autosilentflutter/Utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class InputField extends StatefulWidget {
  final bool enabled;
  final String label, text, hint;
  final int maxLines;
  final Function validator;
  const InputField(
      {Key key,
      this.enabled = false,
      this.label,
      this.text,
      this.maxLines,
      this.validator,
      this.hint})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int numLine;
  @override
  void initState() {
    numLine = Utils.numberOfLines(widget.text);
    Logger().d('numLine', numLine);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: (String val) {
          return widget.validator(val);
        },
        enabled: widget.enabled,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: widget.text,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}

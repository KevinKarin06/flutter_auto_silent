import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool enabled;
  final String label, text;
  final int maxLines;
  final Function validator;
  const InputField(
      {Key key,
      this.enabled = false,
      this.label,
      this.text,
      this.maxLines,
      this.validator})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  var numLine;
  @override
  void initState() {
    numLine = '\n'.allMatches(widget.text).length + 1;
    print(numLine);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        enabled: widget.enabled,
        maxLines: numLine,
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

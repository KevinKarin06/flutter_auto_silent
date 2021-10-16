import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool enabled;
  final TextEditingController controller;
  final String label, text;
  final int maxLines;
  const InputField(
      {Key key,
      @required this.controller,
      this.enabled = false,
      this.label,
      this.text,
      this.maxLines})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: TextField(
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        controller: widget.controller,
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

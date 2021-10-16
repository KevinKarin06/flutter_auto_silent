import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String leftText, rightText;
  final bool defaultValue;
  final Function onValueChanged;
  const CustomSwitch(
      {Key key,
      this.leftText,
      this.rightText,
      this.defaultValue = false,
      this.onValueChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _selected = false;
  @override
  void initState() {
    _selected = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 50.0,
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _selected = false;
              });
              widget.onValueChanged(_selected);
            },
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: _selected ? null : Colors.cyan,
                borderRadius: BorderRadius.circular(8.0),
              ),
              duration: const Duration(milliseconds: 500),
              child: Text(
                widget.leftText.toUpperCase(),
                maxLines: 1,
                style: TextStyle(
                  color: _selected ? Colors.black : Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selected = true;
              });
              widget.onValueChanged(_selected);
            },
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: _selected ? Colors.cyan : null,
                borderRadius: BorderRadius.circular(8.0),
              ),
              duration: const Duration(milliseconds: 500),
              child: Text(
                widget.rightText.toUpperCase(),
                maxLines: 1,
                style: TextStyle(
                  color: _selected ? Colors.white : Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String leftText, rightText, label;
  final bool defaultValue;
  final Function onValueChanged;
  CustomSwitch({
    Key key,
    this.leftText,
    this.rightText,
    this.defaultValue = false,
    this.onValueChanged,
    this.label,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _selected = false;
  final double _initialDistance = 8.0;
  double _distance;
  void _updatePosition() {
    _selected = widget.defaultValue;
    if (widget.defaultValue) {
      _distance = 200.0;
    } else {
      _distance = _initialDistance;
    }
  }

  @override
  void initState() {
    _selected = widget.defaultValue;
    if (_selected) {
      _distance = 200.0;
    } else
      _distance = _initialDistance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _updatePosition();
    return Stack(
      children: [
        AnimatedPositioned(
          top: 18,
          left: _distance,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          duration: Duration(milliseconds: 500),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            height: 60.0,
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
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
                      _distance = _initialDistance;
                    });
                    widget.onValueChanged(_selected);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      widget.leftText,
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
                      _distance = 200;
                    });
                    widget.onValueChanged(_selected);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      widget.rightText,
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
          ),
        ),
        Positioned(
          left: 8.0,
          top: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

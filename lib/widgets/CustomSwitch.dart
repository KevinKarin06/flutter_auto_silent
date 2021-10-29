import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomSwitch extends StatefulWidget {
  final String leftText, rightText, label;
  final bool defaultValue, disabled;
  final Function onValueChanged;
  CustomSwitch({
    Key key,
    this.leftText,
    this.rightText,
    this.defaultValue,
    this.onValueChanged,
    this.label,
    this.disabled,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with WidgetsBindingObserver {
  bool _selected = false;
  final double _initialDistance = 17.0;
  double _distance = 17.0;
  void _updatePosition(context) {
    if (widget.defaultValue != _selected) {
      _distance = _initialDistance;
    } else {
      _distance = MediaQuery.of(context).size.width - 170;
      _selected = widget.defaultValue ?? true;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selected = widget.defaultValue ?? true;
      if (_selected) {
        _distance = MediaQuery.of(context).size.width - 170;
        Logger().d('During Bindings', widget.defaultValue);
      } else
        _distance = _initialDistance;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _updatePosition(context);
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
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
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
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selected = true;
                      _distance = MediaQuery.of(context).size.width - 170;
                    });
                    widget.onValueChanged(_selected);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
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
                  maxLines: 1,
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

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}

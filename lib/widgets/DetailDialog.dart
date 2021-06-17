import 'package:autosilentflutter/Utils.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:flutter/material.dart';

class DetailDialog extends StatefulWidget {
  final LocationModel model;
  final Function onUpdate;
  const DetailDialog({
    Key key,
    @required this.model,
    this.onUpdate,
  }) : super(key: key);
  @override
  _DetailDialogState createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  bool _edit = false;
  bool _valid = true;
  TextEditingController _controller;
  bool validate(String value) {
    if (value.isEmpty) {
      setState(() {
        _valid = false;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(child: Text(widget.model.title)),
      elevation: 12,
      content: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _edit
                  ? Container(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: TextField(
                        // maxLines: 1,
                        // maxLength: 20,
                        onSubmitted: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              _valid = false;
                            });
                          } else {
                            widget.model.title = Utils.capitalize(value);
                            widget.onUpdate(widget.model);
                            setState(() {
                              _edit = false;
                            });
                          }
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          errorText: _valid ? null : 'Title cannot be empty',
                          errorBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          // fillColor: Colors.grey[300],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.location_on_rounded,
                          ),
                        ),
                      ),
                    )
                  : dialogDetails(
                      Icons.location_on_rounded, widget.model.title),
              dialogDetails(Icons.map_rounded, widget.model.subtitle),
              dialogDetails(Icons.maps_ugc_rounded,
                  'Latitude : ${widget.model.latitude.toString()}'),
              dialogDetails(Icons.maps_ugc_rounded,
                  'Longitude : ${widget.model.longitude.toString()}'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_edit) {
              Navigator.pop(context);
            } else {
              _controller.text = widget.model.title;
              setState(() {
                _edit = true;
              });
            }
          },
          child: Text(_edit ? 'CANCEL' : 'EDIT'),
        ),
        TextButton(
          onPressed: () {
            if (_edit) {
              if (validate(_controller.text)) {
                widget.model.title = Utils.capitalize(_controller.text);
                widget.onUpdate(widget.model);
                setState(() {
                  _edit = false;
                });
              }
              print(_controller.text);
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(_edit ? 'SAVE' : 'OK'),
        ),
      ],
    );
  }

  Row dialogDetails(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    print('Detailed Dialog is being disposed');
    super.dispose();
  }
}

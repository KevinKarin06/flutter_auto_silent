import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final List<LocationModel> model;
  final Function onDelete;
  final Function onCancel;
  const ConfirmDialog({Key key, this.model, this.onDelete, this.onCancel})
      : super(key: key);
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  String _location;
  @override
  void initState() {
    super.initState();
    _location = widget.model.length > 1 ? 'Locations' : 'Location';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(child: Text('Delete')),
      elevation: 12,
      content: Container(
        child: Center(
          child: Text('${widget.model.length} $_location will be removed'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onDelete(widget.model);
          },
          child: Text(
            'REMOVE',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    print('Confirm Dialog is being disposed');
    super.dispose();
  }
}

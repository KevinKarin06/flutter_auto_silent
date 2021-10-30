import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProgressDialog extends ViewModelWidget {
  // final Future<dynamic> task;
  // const ProgressDialog(this.task);
  @override
  Widget build(BuildContext context, viewModel) {
    return SimpleDialog(
      title: Text('loading'),
      children: [],
    );
  }
}

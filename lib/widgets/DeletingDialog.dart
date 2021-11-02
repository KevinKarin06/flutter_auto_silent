import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DeletingDialog extends StatelessWidget {
  const DeletingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   '${GetIt.I<HomeViewModel>().deleted} / ${GetIt.I<HomeViewModel>().selected.length}',
            // ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: LinearProgressIndicator(
                value: GetIt.I<HomeViewModel>().deleted.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

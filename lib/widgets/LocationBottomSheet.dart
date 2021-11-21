import 'package:autosilentflutter/view_models/LocationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => LocationViewModel(),
      builder: (BuildContext context, LocationViewModel vModel, Widget child) =>
          Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height * 0.27,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            alignment: Alignment.topLeft,
            child: Text(
              'add_location',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ).tr(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            margin: EdgeInsets.only(top: 12.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('current_location').tr(),
                  onTap: () {
                    Navigator.pop(context);
                    vModel.addCurrentLocation();
                  },
                  minLeadingWidth: 20.0,
                  leading: Align(
                    widthFactor: 0,
                    child: Icon(Icons.my_location_rounded),
                  ),
                  minVerticalPadding: 8.0,
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
                // SizedBox(height: 8.0),
                ListTile(
                  title: Text('search_location').tr(),
                  onTap: () {
                    Navigator.pop(context);
                    vModel.searchLocationOnline();
                  },
                  minLeadingWidth: 20.0,
                  leading: Align(
                    widthFactor: 0,
                    child: Icon(Icons.place_rounded),
                  ),
                  minVerticalPadding: 8.0,
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:autosilentflutter/view_models/LocationDetailViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:autosilentflutter/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class LocationDetails extends StatefulWidget {
  // final LocationModel model;
  // const LocationDetails({Key key, @required this.model}) : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LocationDetailViewModel(),
      onModelReady: (LocationDetailViewModel model) => model.initialise(),
      builder: (BuildContext context, LocationDetailViewModel vModel,
              Widget child) =>
          Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(vModel.model.title,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'delete'.tr(),
              onPressed: () {},
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InputField(
                      label: 'Location',
                      text: vModel.model.title,
                      enabled: true,
                    ),
                    InputField(
                      label: 'Location Details',
                      text: vModel.model.subtitle,
                      maxLines: 3,
                    ),
                    InputField(
                      label: 'Latitude',
                      text: vModel.model.latitude.toString(),
                    ),
                    InputField(
                      label: 'Longitude',
                      text: vModel.model.longitude.toString(),
                    ),
                    InputField(
                      label: 'Radius',
                      text: vModel.model.radius.toString(),
                      enabled: true,
                    ),
                    CustomSwitch(
                        leftText: 'once'.tr(),
                        rightText: 'always'.tr(),
                        label: 'Trigger',
                        defaultValue: vModel.model.justOnce,
                        onValueChanged: (val) {
                          print(val);
                        }),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(children: [
                        MaterialButton(
                          color: Colors.cyan,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            vModel.update();
                          },
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('save'.tr()),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.check),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        MaterialButton(
                          textColor: Colors.black,
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('cancel'.tr()),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.cancel),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

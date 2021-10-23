import 'package:autosilentflutter/view_models/LocationDetailViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:autosilentflutter/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
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
          title: Text(vModel.getModel().title,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          centerTitle: true,
          actions: [
            vModel.getModel().id != null
                ? IconButton(
                    tooltip: 'delete'.tr(),
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      onFieldSubmitted: (String val) {
                        _formKey.currentState.validate();
                        vModel.setTitle(val.trim());
                      },
                      onChanged: (String value) {
                        // vModel.setTitle(value.trim());
                      },
                      initialValue: vModel.getModel().title,
                      validator: (String val) {
                        return vModel.validateLocation(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'location'.tr(),
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      readOnly: true,
                      initialValue: vModel.getModel().subtitle,
                      decoration: InputDecoration(
                        labelText: 'location_details'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      readOnly: true,
                      initialValue: vModel.getModel().latitude.toString(),
                      decoration: InputDecoration(
                        labelText: 'latitude'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      readOnly: true,
                      initialValue: vModel.getModel().longitude.toString(),
                      decoration: InputDecoration(
                        labelText: 'longitude'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      onFieldSubmitted: (String val) {
                        _formKey.currentState.validate();
                        vModel.setRadius(val);
                      },
                      initialValue: vModel.getModel().radius.toString(),
                      keyboardType: TextInputType.number,
                      validator: (String val) {
                        return vModel.validateRaduis(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'radius'.tr(),
                      ),
                    ),
                    mySpacer(),
                    CustomSwitch(
                        leftText: 'once'.tr(),
                        rightText: 'always'.tr(),
                        label: 'location_notify'.tr(),
                        defaultValue: vModel.getModel().justOnce,
                        onValueChanged: (val) {
                          vModel.setJustOnce(val);
                        }),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              ScaleTransition(scale: animation, child: child),
                      child: vModel.isDirty
                          ? Container(
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
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  onPressed: () {
                                    vModel.clearChanges();
                                  },
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            )
                          : Container(),
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

  Widget mySpacer() {
    return SizedBox(height: 8.0);
  }
}

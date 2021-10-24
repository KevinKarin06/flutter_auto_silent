import 'package:autosilentflutter/view_models/LocationDetailViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key key}) : super(key: key);

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
      onDispose: (LocationDetailViewModel model) {
        model.clearControllers();
      },
      fireOnModelReadyOnce: true,
      viewModelBuilder: () => LocationDetailViewModel(),
      onModelReady: (LocationDetailViewModel model) => model.initialise(),
      builder: (BuildContext context, LocationDetailViewModel vModel,
              Widget child) =>
          Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            vModel.getModel().title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
                      controller: vModel.getLocationController(),
                      onFieldSubmitted: (String val) {
                        _formKey.currentState.validate();
                        vModel.setTitle(val.trim());
                      },
                      onChanged: (String value) {
                        // vModel.setTitle(value.trim());
                      },
                      validator: (String val) {
                        return vModel.validateLocation(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'location'.tr(),
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      maxLines: 3,
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
                      controller: vModel.getRadiusController(),
                      onFieldSubmitted: (String val) {
                        _formKey.currentState.validate();
                        vModel.setRadius(val);
                      },
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
                        leftText: 'always'.tr(),
                        rightText: 'once'.tr(),
                        label: 'location_notify'.tr(),
                        defaultValue: vModel.getModel().justOnce,
                        onValueChanged: (val) {
                          vModel.setJustOnce(val);
                        }),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
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
                                      vModel.saveLocation();
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
    return SizedBox(height: 10.0);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

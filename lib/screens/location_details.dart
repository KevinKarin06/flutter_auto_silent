import 'package:autosilentflutter/constants/constants.dart';
import 'package:autosilentflutter/utils/Utils.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/view_models/LocationDetailViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class LocationDetails extends StatelessWidget {
  final LocationModel locationModel;
  LocationDetails(this.locationModel);
  //
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onDispose: (LocationDetailViewModel model) {
        model.clearControllers();
      },
      fireOnModelReadyOnce: true,
      viewModelBuilder: () => LocationDetailViewModel(),
      onModelReady: (LocationDetailViewModel model) =>
          model.initialise(locationModel),
      builder: (BuildContext context, LocationDetailViewModel vModel,
              Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text(
            vModel.model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            vModel.model.id != null
                ? IconButton(
                    tooltip: 'delete'.tr(),
                    onPressed: () {
                      vModel.onDelete(vModel.model);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
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
                      maxLines: Utils.numberOfLines(vModel.model.title),
                      controller: vModel.locationController,
                      onFieldSubmitted: (String val) {
                        _formKey.currentState.validate();
                        vModel.setTitle(val.trim());
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
                      maxLines: Utils.numberOfLines(vModel.model.subtitle),
                      readOnly: true,
                      initialValue: vModel.model.subtitle,
                      decoration: InputDecoration(
                        labelText: 'location_details'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      readOnly: true,
                      initialValue: vModel.model.latitude.toString(),
                      decoration: InputDecoration(
                        labelText: 'latitude'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    TextFormField(
                      readOnly: true,
                      initialValue: vModel.model.longitude.toString(),
                      decoration: InputDecoration(
                        labelText: 'longitude'.tr(),
                        enabled: false,
                      ),
                    ),
                    mySpacer(),
                    // TextFormField(
                    //   controller: vModel.radiusController,
                    //   onFieldSubmitted: (String val) {
                    //     _formKey.currentState.validate();
                    //     vModel.setRadius(val);
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   validator: (String val) {
                    //     return vModel.validateRaduis(val);
                    //   },
                    //   decoration: InputDecoration(
                    //     labelText: 'radius'.tr(),
                    //   ),
                    // ),
                    Row(
                      children: [
                        Flexible(
                          child: DropdownButtonFormField(
                            value: vModel.model.radius,
                            onChanged: (int val) {
                              _formKey.currentState.validate();
                              vModel.setRadius(val);
                            },
                            onSaved: (int val) {
                              _formKey.currentState.validate();
                              vModel.setRadius(val);
                            },
                            decoration: InputDecoration(
                              labelText: 'radius'.tr(),
                            ),
                            items: Constants.GEO_RADIUS.entries
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.key).tr(),
                                    value: e.value,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Flexible(
                          child: DropdownButtonFormField(
                            value: vModel.model.deleyTime,
                            onChanged: (val) {
                              _formKey.currentState.validate();
                              vModel.setDelayTime(val);
                            },
                            onSaved: (val) {
                              _formKey.currentState.validate();
                              vModel.setDelayTime(val);
                            },
                            decoration: InputDecoration(
                              labelText: 'loitering'.tr(),
                            ),
                            items: Constants.GEO_DELAY_TIME.entries
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.key).tr(),
                                    value: e.value,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    mySpacer(),
                    CustomSwitch(
                        leftText: 'always'.tr(),
                        rightText: 'once'.tr(),
                        label: 'location_notify'.tr(),
                        defaultValue: vModel.model.justOnce,
                        onValueChanged: (val) {
                          vModel.setJustOnce(val);
                        }),
                    AnimatedSwitcher(
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              ScaleTransition(scale: animation, child: child),
                      duration: Duration(milliseconds: 500),
                      child: vModel.isDirty
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(children: [
                                OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      vModel.saveLocation();
                                    }
                                  },
                                  child: Text('save'.tr()),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    // ignore: missing_return
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return Colors.red;
                                    }),
                                  ),
                                  onPressed: () {
                                    _formKey.currentState.validate();
                                    vModel.clearChanges();
                                  },
                                  child: Text('cancel'.tr()),
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
}

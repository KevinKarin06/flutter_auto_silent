import 'package:autosilentflutter/screens/loading.dart';
import 'package:autosilentflutter/screens/no_location.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:autosilentflutter/widgets/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => GetIt.I<MainViewModel>(),
      builder: (BuildContext context, MainViewModel vModel, Widget child) =>
          WillPopScope(
        onWillPop: () async {
          return Future.delayed(
            Duration(milliseconds: 100),
            () => vModel.handleBackButtonPressed(),
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(),
          floatingActionButton: FloatingActionButton(
            tooltip: 'add_location'.tr(),
            onPressed: () {
              vModel.addLocation();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Center(
                child: !vModel.isBusy && vModel.dataReady
                    ? Container(
                        child: vModel.locations.isNotEmpty
                            ? ListView.builder(
                                itemCount: vModel.locations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      vModel.handleItemTap(
                                          vModel.locations[index]);
                                    },
                                    onLongPress: () {
                                      vModel.handleOnLongPress(
                                          vModel.locations[index]);
                                    },
                                    selected: vModel
                                        .isSelected(vModel.locations[index]),
                                    selectedTileColor: Colors.grey[200],
                                    title: Text(
                                      vModel.locations[index].title
                                          .toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      vModel.locations[index].subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    minVerticalPadding: 8.0,
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                    leading: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0,
                                      child: Icon(
                                        !vModel.selected.contains(
                                                vModel.locations[index])
                                            ? Icons.place_rounded
                                            : Icons.check_circle_rounded,
                                        size: 28.0,
                                      ),
                                    ),
                                  );
                                })
                            : NoLocationScreen(),
                      )
                    : LoadingScreen()),
          ),
        ),
      ),
    );
  }
}

import 'package:autosilentflutter/view_models/AutoCompleteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class AutoCompleteLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onDispose: (AutoCompleteViewModel model) {
        model.cleanUp();
      },
      viewModelBuilder: () => AutoCompleteViewModel(),
      builder:
          (BuildContext context, AutoCompleteViewModel vModel, Widget child) =>
              Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              Material(
                elevation: 4.0,
                color: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextField(
                    onChanged: (String value) {
                      vModel.suggest(value.trim());
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'search'.tr(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      // focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.place_rounded),
                      ),
                      // suffix: IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.clear_rounded),
                      // ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          vModel.onBackIconPressded();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              vModel.isBusy
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child: !vModel.isBusy && vModel.suggestions.isNotEmpty
                      ? Container(
                          child: ListView.builder(
                            itemCount: vModel.suggestions.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              onTap: () {
                                vModel.onItemTap(vModel.suggestions[index]);
                              },
                              title: Text(vModel.suggestions[index].title),
                              subtitle:
                                  Text(vModel.suggestions[index].subtitle),
                              minVerticalPadding: 8.0,
                            ),
                          ),
                        )
                      : vModel.suggestions.isEmpty
                          ? Text('no result yet')
                          : Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

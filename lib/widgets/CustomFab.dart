import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/screens/auto_complete.dart';
import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  // The icon to be used on the FAB
  final IconData icon;

  // The background color of the FAB
  final Color backgroundColor;

  // The color of the icon on the FAB
  final Color iconColor;

  final Function getCurrent, onSearchResult;

  final bool willPop;

  CustomFab(
    this.icon, {
    this.backgroundColor,
    this.iconColor,
    this.getCurrent,
    this.onSearchResult,
    this.willPop,
  });

  @override
  _CustomFabState createState() => _CustomFabState(icon);
}

class _CustomFabState extends State<CustomFab> {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  bool folded = true;

  void setfold(bool fold) {
    setState(() {
      folded = fold;
    });
  }

  _CustomFabState(this.icon,
      {this.backgroundColor = Colors.cyan, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    print('Custom Fab Rebuild');
    return WillPopScope(
      onWillPop: () async {
        if (!folded) {
          setState(() {
            folded = true;
          });
          return false;
        } else {
          return widget.willPop;
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: folded ? 56 : MediaQuery.of(context).size.width / 2.0,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.cyan,
          boxShadow: kElevationToShadow[6],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: IconButton(
                          tooltip: 'Search Locations',
                          icon: Icon(Icons.search_rounded),
                          onPressed: () {},
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          tooltip: 'Add Current Location',
                          icon: Icon(Icons.my_location_rounded),
                          onPressed: () {
                            widget.getCurrent();
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              child: Material(
                // type: MaterialType.transparency,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                color: Colors.cyan,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(folded ? 32 : 0),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(folded ? 32 : 0),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      folded = !folded;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('Custom Fab Dissmissed');
    super.dispose();
  }
}

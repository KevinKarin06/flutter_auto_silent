import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/helpers/ApiHelper.dart';
import 'package:autosilentflutter/widgets/MySnackBar.dart';
import 'package:autosilentflutter/widgets/SearchField.dart';
import 'package:dialog_context/dialog_context.dart';
import 'package:flutter/material.dart';

class AutoComplete extends StatefulWidget {
  final Function onSelect;
  const AutoComplete({Key key, @required this.onSelect}) : super(key: key);

  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  TextEditingController _textEditingController;
  ApiHelper _apiHelper;
  List<LocationModel> _suggestions;
  bool _loading = false;

  Future<void> _autoSuggest(String query) async {
    clearList();
    setState(() {
      _loading = true;
    });
    try {
      List<LocationModel> temp = await _apiHelper.photonSearch(query);
      setState(() {
        _suggestions = temp;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      DialogContext()
          .showSnackBar(snackBar: snackBar(error: true, msg: e.toString()));
    }
  }

  void clearList() {
    _suggestions.clear();
    setState(() {});
  }

  void _checkLoad() {
    if (_textEditingController.text.isEmpty) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _apiHelper = ApiHelper();
    _suggestions = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    print('Auto Complete Widget Rebuild');
    _checkLoad();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.15,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: SearchField(
                          controller: _textEditingController,
                          icon: Icons.location_on_rounded,
                          onClear: clearList,
                          hintText: 'IUT Douala',
                          function: (String query) {
                            if (query.length >= 3) {
                              _autoSuggest(query);
                              print(query);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: !_loading
                      ? ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: _suggestions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]),
                                ),
                              ),
                              child: _suggestions.length > 0
                                  ? ListTile(
                                      onTap: () {
                                        widget.onSelect(_suggestions[index]);
                                        Navigator.pop(context);
                                      },
                                      title: Text(_suggestions[index].title),
                                      subtitle:
                                          Text(_suggestions[index].subtitle),
                                      leading: Icon(Icons.location_on_rounded),
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text('No Results Found'),
                                      ),
                                    ),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedList list() {
    return AnimatedList(itemBuilder: (context, index, animation) {});
  }

  @override
  void dispose() {
    print('AutoComplete is being Disposed');
    super.dispose();
    _textEditingController.dispose();
  }
}
